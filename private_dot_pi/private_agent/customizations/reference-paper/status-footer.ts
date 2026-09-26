import { FooterComponent, SettingsManager, getAgentDir, type ExtensionAPI, type ExtensionContext } from "@earendil-works/pi-coding-agent";
import { stripTerminalSequences, visibleWidth, wrapTextWithAnsi } from "@earendil-works/pi-tui";

type FooterData = ConstructorParameters<typeof FooterComponent>[1];

/** Use Pi's own accounting, then arrange its output on a quiet paper footer. */
export function paperFooter(ctx: ExtensionContext, pi: ExtensionAPI, data: FooterData, requestRender: () => void) {
  const session = {
    get state() { return { model: ctx.model, thinkingLevel: pi.getThinkingLevel() }; },
    sessionManager: ctx.sessionManager,
    getContextUsage: () => ctx.getContextUsage(),
    modelRuntime: {
      isUsingSubscription: (provider: string) => !!ctx.model
        && ctx.modelRegistry.isUsingOAuth(ctx.model)
        && ctx.modelRegistry.getProvider(provider)?.auth?.oauth?.isSubscription === true,
    },
  } as unknown as ConstructorParameters<typeof FooterComponent>[0];
  const original = new FooterComponent(session, data);
  const unsubscribe = data.onBranchChange(requestRender);
  return {
    invalidate() { original.invalidate(); },
    dispose() { unsubscribe(); original.dispose(); },
    render(width: number): string[] {
      if (width <= 0) return [];
      // Read the effective setting so /settings changes are reflected on redraw.
      original.setAutoCompactEnabled(SettingsManager.create(ctx.cwd, getAgentDir()).getCompactionEnabled());
      // Get untruncated stock content before applying our responsive arrangement.
      const stock = original.render(16384).map(stripTerminalSequences);
      const [stats = "", model = ""] = stock[1].trim().split(/ {2,}/);
      const inset = width >= 8 ? 2 : 0;
      const inner = Math.max(1, width - inset * 2);
      const rows: string[] = [];
      const append = (left: string, right = "") => {
        if (right && visibleWidth(left) + visibleWidth(right) + 3 <= inner) {
          rows.push(left + " ".repeat(inner - visibleWidth(left) - visibleWidth(right)) + right);
        } else {
          // Pi's wrapper handles Unicode cell widths; keep tiny widths safe for wide glyphs.
          const wrapWidth = Math.max(2, inner);
          rows.push(...wrapTextWithAnsi(left, wrapWidth));
          if (right) rows.push(...wrapTextWithAnsi(right, wrapWidth));
        }
      };
      const statuses = [...data.getExtensionStatuses()].sort(([a], [b]) => a.localeCompare(b))
        .map(([key, value]) => {
          const text = stripTerminalSequences(value).replace(/[\r\n\t]+/g, " ").replace(/ +/g, " ").trim();
          if (!text || key !== "pi-goal") return text;
          return "\x1b[3m" + text.charAt(0).toLowerCase() + text.slice(1) + "\x1b[23m";
        }).filter(Boolean).join(" · ");
      append(stock[0].trim(), statuses);
      append(stats, model);
      return [
        "\x1b[38;2;212;212;212m" + "─".repeat(width) + "\x1b[39m",
        ...rows.map(row => {
          // A single-column terminal cannot show a wide glyph; avoid overflowing it.
          const fitted = width === 1 && visibleWidth(row) > 1 ? "…" : row;
          const padded = " ".repeat(inset) + fitted
            + " ".repeat(Math.max(0, width - inset - visibleWidth(fitted)));
          return "\x1b[48;2;250;250;250m\x1b[38;2;115;115;115m" + padded + "\x1b[39m\x1b[49m";
        }),
      ];
    },
  };
}
