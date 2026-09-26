import { CustomEditor } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth, type TuiMouseEvent } from "@earendil-works/pi-tui";

/** Keep Pi's editor behavior, replacing only its two border rows with a prompt. */
export class PaperPromptEditor extends CustomEditor {
  private sourceRows: number[] = [];
  private promptWidth = 2;

  protected renderTopBorder(): string { return ""; }
  protected renderBottomBorder(): string { return ""; }

  render(width: number): string[] {
    this.sourceRows = [];
    if (width <= 0) return [];
    // Pi may apply its global editor padding after the factory returns.
    this.setPaddingX(0);
    this.promptWidth = Math.min(2, Math.max(0, width - 1));
    const available = Math.max(1, width - this.promptWidth);
    // Base editor needs two text cells plus a cursor cell for wide glyphs.
    const rows = super.render(Math.max(3, available));
    const result: string[] = [];
    for (let i = 0; i < rows.length; i++) {
      // Only the two overridden border rows are empty; text rows are padded.
      if (rows[i] === "") continue;
      this.sourceRows.push(i);
      const prefix = this.promptWidth ? (result.length === 0 ? "› ".slice(0, this.promptWidth) : " ".repeat(this.promptWidth)) : "";
      const body = visibleWidth(rows[i]) > available
        ? truncateToWidth(rows[i], available, "") : rows[i];
      result.push(prefix + body);
    }
    return result;
  }

  handleMouse(event: TuiMouseEvent) {
    const sourceRow = this.sourceRows[event.y];
    if (sourceRow === undefined) return undefined;
    // Translate both editor clicks and completion-menu clicks to the base layout.
    return super.handleMouse({
      ...event,
      x: Math.max(0, event.x - this.promptWidth),
      y: sourceRow,
      width: Math.max(3, event.width - this.promptWidth),
      height: event.height + 2,
    });
  }
}
