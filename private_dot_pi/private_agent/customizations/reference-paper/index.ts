import type { ExtensionAPI, Theme } from "@earendil-works/pi-coding-agent";
import { paperFooter } from "./status-footer";
import { PaperPromptEditor } from "./prompt-editor";
import { Text, truncateToWidth } from "@earendil-works/pi-tui";

type GoalDetails = {
  kind?: string;
  goal?: {
    objective?: string;
    timeUsedSeconds?: number;
    tokensUsed?: number;
    tokenBudget?: number | null;
  } | null;
};

const labels: Record<string, string> = {
  active: "active", continuation: "continuing", resumed: "resumed",
  complete: "achieved", paused: "paused", cleared: "cleared",
  budget_limited: "budget reached",
};

function elapsed(value = 0): string {
  const seconds = Math.max(0, Math.round(value));
  if (seconds < 60) return `${seconds}s`;
  const minutes = Math.floor(seconds / 60);
  if (minutes < 60) return `${minutes}m`;
  return `${Math.floor(minutes / 60)}h${minutes % 60 ? ` ${minutes % 60}m` : ""}`;
}

export function renderGoal(details: GoalDetails | undefined, expanded: boolean, theme: Theme) {
  const kind = details?.kind ?? "continuation";
  const state = details?.goal;
  const complete = kind === "complete";
  const status = labels[kind] ?? kind;
  const ruleColor = complete ? "customMessageLabel"
    : kind === "continuation" ? "borderMuted" : "border";
  const suffix = complete && state
    ? `(${elapsed(state.timeUsedSeconds)})`
    : expanded ? "" : "(ctrl+o to expand)";
  let content = theme.fg("customMessageLabel", "Goal") + " "
    + theme.fg(complete ? "customMessageText" : "muted", status)
    + (suffix ? " " + theme.fg("muted", suffix) : "");
  if (expanded && state) {
    content += "\n" + theme.fg("muted", "Goal: ")
      + theme.fg("customMessageText", state.objective ?? "");
    const usage = state.tokenBudget != null
      ? `${state.tokensUsed ?? 0} / ${state.tokenBudget} tokens · ${elapsed(state.timeUsedSeconds)}`
      : elapsed(state.timeUsedSeconds);
    content += "\n" + theme.fg("muted", `Usage: ${usage}`);
  }
  const body = new Text(content, 0, 0);
  return {
    invalidate() { body.invalidate(); },
    render(width: number): string[] {
      if (width <= 0) return [];
      const rule = theme.fg(ruleColor, "│");
      if (width <= 2) return [truncateToWidth(rule, width)];
      // Wrap the body first so every continuation line receives the same rule.
      return body.render(width - 2).map(line => rule + " " + truncateToWidth(line, width - 2, ""));
    },
  };
}

export default function referencePaper(pi: ExtensionAPI) {
  pi.on("session_start", (_event, ctx) => {
    ctx.ui.setFooter((tui, _theme, data) =>
      paperFooter(ctx, pi, data, () => tui.requestRender()));
    ctx.ui.setEditorComponent((tui, theme, keybindings) =>
      new PaperPromptEditor(tui, theme, keybindings, { paddingX: 0 }));
  });
  pi.registerMessageRenderer<GoalDetails>("pi-goal-event", (message, { expanded }, theme) =>
    renderGoal(message.details, expanded, theme));
}
