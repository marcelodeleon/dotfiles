import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { getEncoding } from "js-tiktoken";

const encoder = getEncoding("cl100k_base");

function countTokens(text: string): number {
  if (!text) return 0;
  return encoder.encode(text).length;
}

function formatTokens(n: number): string {
  if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(1)}M`;
  if (n >= 1_000) return `${(n / 1_000).toFixed(1)}k`;
  return `${n}`;
}

function formatCost(cost: number): string {
  if (cost < 0.01) return `$${cost.toFixed(4)}`;
  return `$${cost.toFixed(2)}`;
}

export default function (pi: ExtensionAPI) {
  function getSessionStats(ctx: any) {
    let input = 0;
    let output = 0;
    let cacheRead = 0;
    let cacheWrite = 0;
    let cost = 0;
    let turns = 0;

    for (const entry of ctx.sessionManager.getEntries()) {
      if (entry.type === "message" && entry.message.role === "assistant") {
        const msg = entry.message as AssistantMessage;
        input += msg.usage.input;
        output += msg.usage.output;
        cacheRead += msg.usage.cacheRead;
        cacheWrite += msg.usage.cacheWrite;
        cost += msg.usage.cost.total;
        turns++;
      }
    }

    return { input, output, cacheRead, cacheWrite, cost, turns };
  }

  function getContextBreakdown(ctx: any) {
    const options = ctx.getSystemPromptOptions();
    const breakdown: { label: string; tokens: number }[] = [];

    // Custom/base system prompt
    if (options.customPrompt) {
      breakdown.push({ label: "System prompt", tokens: countTokens(options.customPrompt) });
    }

    // Tool snippets (one-line descriptions in system prompt)
    if (options.toolSnippets?.length) {
      const toolText = options.toolSnippets.join("\n");
      breakdown.push({ label: "Tool definitions", tokens: countTokens(toolText) });
    }

    // Guidelines
    if (options.promptGuidelines?.length) {
      const guidelinesText = options.promptGuidelines.join("\n");
      breakdown.push({ label: "Guidelines", tokens: countTokens(guidelinesText) });
    }

    // Context files (AGENTS.md, etc.)
    if (options.contextFiles?.length) {
      let contextTokens = 0;
      const fileDetails: { name: string; tokens: number }[] = [];
      for (const file of options.contextFiles) {
        if (file.content) {
          const t = countTokens(file.content);
          contextTokens += t;
          fileDetails.push({ name: file.path ?? "unknown", tokens: t });
        }
      }
      if (contextTokens > 0) {
        breakdown.push({
          label: `Context files (${options.contextFiles.length})`,
          tokens: contextTokens,
        });
      }
    }

    // Skills
    if (options.skills?.length) {
      let skillTokens = 0;
      for (const skill of options.skills) {
        skillTokens += countTokens(skill.description ?? "");
        skillTokens += countTokens(skill.name ?? "");
      }
      breakdown.push({
        label: `Skills (${options.skills.length})`,
        tokens: skillTokens,
      });
    }

    // Appended system prompt
    if (options.appendSystemPrompt) {
      breakdown.push({ label: "Appended prompt", tokens: countTokens(options.appendSystemPrompt) });
    }

    // Conversation messages
    let conversationTokens = 0;
    let toolResultTokens = 0;
    for (const entry of ctx.sessionManager.getEntries()) {
      if (entry.type !== "message") continue;
      const msg = entry.message;

      if (msg.role === "user" || msg.role === "assistant") {
        if (Array.isArray(msg.content)) {
          for (const block of msg.content) {
            if (block.type === "text") {
              conversationTokens += countTokens(block.text);
            } else if (block.type === "tool_use") {
              conversationTokens += countTokens(JSON.stringify(block.input ?? {}));
              conversationTokens += countTokens(block.name ?? "");
            } else if (block.type === "tool_result") {
              const resultText = Array.isArray(block.content)
                ? block.content.map((c: any) => (c.type === "text" ? c.text : "")).join("")
                : typeof block.content === "string"
                  ? block.content
                  : "";
              toolResultTokens += countTokens(resultText);
            }
          }
        } else if (typeof msg.content === "string") {
          conversationTokens += countTokens(msg.content);
        }
      } else if (msg.role === "toolResult" || (msg as any).role === "tool") {
        const content = (msg as any).content;
        if (typeof content === "string") {
          toolResultTokens += countTokens(content);
        } else if (Array.isArray(content)) {
          for (const block of content) {
            if (block.type === "text") toolResultTokens += countTokens(block.text);
          }
        }
      }
    }

    breakdown.push({ label: "Conversation", tokens: conversationTokens });
    if (toolResultTokens > 0) {
      breakdown.push({ label: "Tool results", tokens: toolResultTokens });
    }

    return breakdown;
  }

  pi.registerCommand("usage", {
    description: "Show detailed token usage and context breakdown for this session",
    handler: async (_args, ctx) => {
      const stats = getSessionStats(ctx);
      const totalTokens = stats.input + stats.output;
      const contextUsage = ctx.getContextUsage();

      const lines = [
        `── Session Token Usage ──`,
        ``,
        `  Input tokens:    ${formatTokens(stats.input)}`,
        `  Output tokens:   ${formatTokens(stats.output)}`,
        `  Cache read:      ${formatTokens(stats.cacheRead)}`,
        `  Cache write:     ${formatTokens(stats.cacheWrite)}`,
        `  Total tokens:    ${formatTokens(totalTokens)}`,
        ``,
        `  Total cost:      ${formatCost(stats.cost)}`,
        `  Turns:           ${stats.turns}`,
        `  Avg cost/turn:   ${stats.turns > 0 ? formatCost(stats.cost / stats.turns) : "N/A"}`,
        `  Avg tokens/turn: ${stats.turns > 0 ? formatTokens(Math.round(totalTokens / stats.turns)) : "N/A"}`,
      ];

      if (contextUsage) {
        const pct = ((contextUsage.tokens / contextUsage.contextWindow) * 100).toFixed(1);
        lines.push(
          ``,
          `── Context Window ──`,
          ``,
          `  Used:     ${formatTokens(contextUsage.tokens)} / ${formatTokens(contextUsage.contextWindow)}`,
          `  Fill:     ${pct}%`,
        );
      }

      // Token breakdown
      const breakdown = getContextBreakdown(ctx);
      if (breakdown.length > 0) {
        const totalCounted = breakdown.reduce((sum, b) => sum + b.tokens, 0);
        lines.push(
          ``,
          `── Context Breakdown (cl100k_base tokenizer) ──`,
          ``,
        );

        const maxLabelLen = Math.max(...breakdown.map((b) => b.label.length));
        for (const { label, tokens } of breakdown) {
          const pct = totalCounted > 0 ? ((tokens / totalCounted) * 100).toFixed(0) : "0";
          const barLen = totalCounted > 0 ? Math.round((tokens / totalCounted) * 20) : 0;
          const bar = "█".repeat(barLen);
          lines.push(`  ${label.padEnd(maxLabelLen)}  ${formatTokens(tokens).padStart(6)}  ${pct.padStart(3)}%  ${bar}`);
        }
        lines.push(`  ${"".padEnd(maxLabelLen + 2)}───────`);
        lines.push(`  ${"Total".padEnd(maxLabelLen)}  ${formatTokens(totalCounted).padStart(6)}`);

        if (contextUsage) {
          const drift = ((Math.abs(totalCounted - contextUsage.tokens) / contextUsage.tokens) * 100).toFixed(0);
          lines.push(`  ${"Drift vs reported".padEnd(maxLabelLen)}  ${drift.padStart(5)}%`);
        }
      }

      if (stats.cacheRead > 0 || stats.cacheWrite > 0) {
        const totalPromptTokens = stats.input + stats.cacheRead + stats.cacheWrite;
        const hitRate = totalPromptTokens > 0 ? ((stats.cacheRead / totalPromptTokens) * 100).toFixed(1) : "0";
        lines.push(
          ``,
          `── Cache Efficiency ──`,
          ``,
          `  Hit rate:   ${hitRate}%`,
        );
      }

      ctx.ui.notify(lines.join("\n"), "info");
    },
  });
}
