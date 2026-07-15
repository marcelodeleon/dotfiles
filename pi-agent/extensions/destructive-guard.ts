/**
 * Destructive Operations Guard
 *
 * Prompts for confirmation before:
 * - Force pushes (git push --force / -f)
 * - File/directory deletion (rm, unlink, shutil.rmtree, etc.)
 * - Git destructive operations (reset --hard, clean -fd, checkout -- .)
 * - Overwriting important files via the write tool (optional)
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
	// Bash commands that are considered destructive
	const destructivePatterns: Array<{ pattern: RegExp; label: string }> = [
		// Force push
		{ pattern: /\bgit\s+push\b.*(\s--force|\s-f)\b/, label: "git force push" },
		{ pattern: /\bgit\s+push\b.*\+\w/, label: "git force push (+ refspec)" },

		// File deletion
		{ pattern: /\brm\s/, label: "file deletion (rm)" },
		{ pattern: /\bunlink\s/, label: "file deletion (unlink)" },
		{ pattern: /\brmdir\s/, label: "directory deletion (rmdir)" },
		{ pattern: /\bshutil\.rmtree\b/, label: "directory deletion (shutil.rmtree)" },

		// Git destructive operations
		{ pattern: /\bgit\s+reset\b.*--hard/, label: "git reset --hard" },
		{ pattern: /\bgit\s+clean\b.*-[a-zA-Z]*f/, label: "git clean (force)" },
		{ pattern: /\bgit\s+checkout\s+--\s+\./, label: "git checkout -- . (discard all changes)" },
		{ pattern: /\bgit\s+stash\s+drop\b/, label: "git stash drop" },
		{ pattern: /\bgit\s+branch\s+-[dD]\s/, label: "git branch delete" },

		// Other destructive
		{ pattern: /\b(truncate|shred)\s/, label: "file destruction" },
	];

	pi.on("tool_call", async (event, ctx) => {
		// Guard bash commands
		if (event.toolName === "bash") {
			const command = event.input.command as string;
			const matched = destructivePatterns.find(({ pattern }) => pattern.test(command));

			if (matched) {
				if (!ctx.hasUI) {
					return { block: true, reason: `Destructive operation blocked (${matched.label}) - no UI for confirmation` };
				}

				const choice = await ctx.ui.select(
					`⚠️  Destructive operation detected: ${matched.label}\n\n  ${command}\n\nAllow this?`,
					["Yes, proceed", "No, block it"]
				);

				if (choice !== "Yes, proceed") {
					return { block: true, reason: `Blocked by user: ${matched.label}` };
				}
			}
		}

		return undefined;
	});
}
