import os from "node:os";
import path from "node:path";
import type { AssistantMessage } from "@earendil-works/pi-ai";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

function fmtInt(n: number): string {
  if (n < 1000) return `${n}`;
  if (n < 1_000_000) return `${(n / 1000).toFixed(1)}k`;
  return `${(n / 1_000_000).toFixed(1)}m`;
}

export default function (pi: ExtensionAPI) {
  let enabled = true;

  function applyFooter(ctx: any) {
    if (!enabled) {
      ctx.ui.setFooter(undefined);
      return;
    }

    ctx.ui.setFooter((tui, theme, footerData) => {
      const unsub = footerData.onBranchChange(() => tui.requestRender());

      return {
        dispose: unsub,
        invalidate() {},
        render(width: number): string[] {
          let input = 0;
          let output = 0;
          let cacheRead = 0;
          let cacheWrite = 0;
          let cost = 0;
          let latestCacheHitRate: number | undefined;

          for (const entry of ctx.sessionManager.getEntries()) {
            if (entry.type === "message" && entry.message.role === "assistant") {
              const msg = entry.message as AssistantMessage;
              input += msg.usage.input;
              output += msg.usage.output;
              cacheRead += msg.usage.cacheRead;
              cacheWrite += msg.usage.cacheWrite;
              cost += msg.usage.cost.total;

              const latestPromptTokens = msg.usage.input + msg.usage.cacheRead + msg.usage.cacheWrite;
              latestCacheHitRate = latestPromptTokens > 0 ? (msg.usage.cacheRead / latestPromptTokens) * 100 : undefined;
            }
          }

          const usage = ctx.getContextUsage();
          const model = ctx.model?.id ?? "no-model";
          const thinkingLevel = pi.getThinkingLevel();
          const sessionName = pi.getSessionName();
          const gitBranch = footerData.getGitBranch();
          const statuses = Array.from(footerData.getExtensionStatuses().values()).filter(Boolean);
          const cwd = process.cwd();
          const home = os.homedir();
          const dirName = cwd === home ? "~" : path.basename(cwd);

          const sep = theme.fg("muted", "•");
          const majorSep = theme.fg("borderAccent", "  ::  ");

          const identityParts = [
            theme.fg("accent", "π pi"),
            theme.fg("customMessageLabel", dirName),
            gitBranch ? theme.fg("mdLink", ` ${gitBranch}`) : undefined,
            sessionName ? theme.fg("thinkingText", sessionName) : undefined,
          ].filter(Boolean) as string[];

          const modelBlock = [
            theme.fg("mdLink", "🤖"),
            theme.fg("mdHeading", model),
            theme.fg("thinkingText", thinkingLevel),
          ].join(" ");

          const statsParts = [
            modelBlock,
            usage ? theme.fg("text", `${fmtInt(usage.tokens)} ctx`) : undefined,
            usage?.percent != null ? theme.fg("warning", `${Math.round(usage.percent)}%`) : undefined,
            theme.fg("success", `↑${fmtInt(input)}`),
            theme.fg("thinkingHigh", `↓${fmtInt(output)}`),
            theme.fg("bashMode", `$${cost.toFixed(cost >= 10 ? 2 : 3)}`),
          ].filter(Boolean) as string[];

          const statusParts = statuses.length ? statuses : [];
          const sections = [
            identityParts.join(` ${sep} `),
            statsParts.join(` ${sep} `),
            statusParts.length ? statusParts.join(` ${sep} `) : undefined,
          ].filter(Boolean) as string[];

          const left = `  ${sections.join(majorSep)}`;
          const cacheColor = "syntaxComment" as const;
          const cacheParts = [
            cacheRead > 0 ? theme.fg(cacheColor, `R${fmtInt(cacheRead)}`) : undefined,
            cacheWrite > 0 ? theme.fg(cacheColor, `W${fmtInt(cacheWrite)}`) : undefined,
            latestCacheHitRate != null && (cacheRead > 0 || cacheWrite > 0)
              ? theme.fg(cacheColor, `CH${latestCacheHitRate.toFixed(1)}%`)
              : undefined,
          ].filter(Boolean) as string[];
          const right = cacheParts.length ? cacheParts.join(` ${sep} `) : null;

          if (!right) {
            return [truncateToWidth(left, width), ""];
          }

          const leftWidth = visibleWidth(left);
          const rightWidth = visibleWidth(right);
          const minGap = 2;

          if (leftWidth + minGap + rightWidth <= width) {
            return [[left, " ".repeat(width - leftWidth - rightWidth), right].join(""), ""];
          }

          const availableLeft = Math.max(0, width - rightWidth - minGap);
          if (availableLeft > 0) {
            const truncatedLeft = truncateToWidth(left, availableLeft);
            const truncatedLeftWidth = visibleWidth(truncatedLeft);
            const gap = " ".repeat(Math.max(minGap, width - truncatedLeftWidth - rightWidth));
            return [[truncatedLeft, gap, right].join(""), ""];
          }

          return [truncateToWidth(right, width), ""];
        },
      };
    });
  }

  pi.on("session_start", async (_event, ctx) => {
    applyFooter(ctx);
  });

  pi.registerCommand("dracula-footer", {
    description: "Manage the custom Dracula-style footer (usage: /dracula-footer [on|off|toggle|apply])",
    handler: async (args, ctx) => {
      const cmd = args.trim();

      if (cmd === "off") {
        enabled = false;
      } else if (cmd === "toggle") {
        enabled = !enabled;
      } else {
        enabled = true;
      }

      applyFooter(ctx);
      ctx.ui.notify(enabled ? "Dracula footer enabled" : "Default footer restored", "info");
    },
  });
}
