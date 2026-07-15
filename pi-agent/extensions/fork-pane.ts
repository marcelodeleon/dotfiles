import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFileSync } from "node:child_process";

/**
 * /fork-pane — fork THIS session into a new pi instance in a new tmux pane.
 *
 * Deterministic: reads the exact current session from ctx.sessionManager
 * (no newest-mtime guessing), so it works correctly even with many pi
 * sessions open across tmux windows.
 *
 * The original session stays live in the current pane; the new pane gets a
 * forked copy carrying full conversation history (clone-like).
 */
export default function (pi: ExtensionAPI) {
  pi.registerCommand("fork-pane", {
    description:
      "Fork this session into a new pi instance in a new tmux pane. Optional leading -h (horizontal/top-bottom, Vim-style, default) or -v (vertical/side-by-side); rest is the session name. e.g. /fork-pane -v \"PAYHUB-1714 holidays\"",
    handler: async (args, ctx) => {
      // 1. Must be inside tmux.
      const tmux = process.env.TMUX;
      const pane = process.env.TMUX_PANE;
      if (!tmux || !pane) {
        ctx.ui.notify("/fork-pane: not inside tmux — can't split a pane.", "error");
        return;
      }

      // 2. Resolve the exact current session (deterministic, not a heuristic).
      const sessionFile = ctx.sessionManager.getSessionFile();
      const sessionId = ctx.sessionManager.getSessionId();
      if (!sessionFile) {
        ctx.ui.notify(
          "/fork-pane: no session file (ephemeral / --no-session) — nothing to fork.",
          "error",
        );
        return;
      }

      // 3. Same path as the current session.
      const cwd = ctx.cwd;

      // 4. Resolve an absolute pi binary so the new pane's non-login shell finds it.
      let piBin = "pi";
      try {
        piBin = execFileSync("sh", ["-c", "command -v pi"], {
          encoding: "utf8",
        }).trim() || "pi";
      } catch {
        // fall back to bare "pi"
      }

      // 5. Parse args: optional leading split flag (-h | -v), rest is the name.
      //    Vim conventions: -h = horizontal (top/bottom, default); -v = vertical
      //    (side-by-side). NOTE: tmux's flags are reversed, so we translate below.
      let rest = args.trim();
      let vimFlag: "-h" | "-v" = "-h";
      const flagMatch = rest.match(/^(-[hv])(?:\s+|$)/);
      if (flagMatch) {
        vimFlag = flagMatch[1] as "-h" | "-v";
        rest = rest.slice(flagMatch[0].length).trim();
      }
      const name = rest.replace(/^["']|["']$/g, "");

      // Translate Vim semantics -> tmux flag (reversed):
      //   Vim -h (horizontal / top-bottom) -> tmux -v
      //   Vim -v (vertical / side-by-side) -> tmux -h
      const split = vimFlag === "-h" ? "-v" : "-h";

      // 6. Build the fork command. Optional name becomes the new session name.
      const shellCmd = name
        ? `${piBin} --fork ${sessionFile} --name ${JSON.stringify(name)}`
        : `${piBin} --fork ${sessionFile}`;

      // 7. Split a pane in the same cwd, targeting THIS pane explicitly, and
      //    launch the forked session.
      try {
        execFileSync(
          "tmux",
          ["split-window", split, "-t", pane, "-c", cwd, shellCmd],
          { stdio: "ignore" },
        );
      } catch (e) {
        ctx.ui.notify(
          `/fork-pane: tmux split-window failed: ${(e as Error).message}`,
          "error",
        );
        return;
      }

      // 8. Report.
      const orientation =
        vimFlag === "-h" ? "horizontal (top/bottom)" : "vertical (side-by-side)";
      ctx.ui.notify(
        `Forked session ${sessionId.slice(0, 8)} into a new ${orientation} pane (cwd: ${cwd}). ` +
          `This session is still live here; sessions don't share state.`,
        "info",
      );
    },
  });
}
