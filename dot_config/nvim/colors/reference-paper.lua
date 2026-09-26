-- Neovim translation of ~/.pi/agent/themes/reference-paper.json.
-- Keep the same palette and semantic roles: white paper, charcoal ink, gray accents.
vim.o.background = "light"
vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.g.colors_name = "reference-paper"

local p = {
  paper = "#ffffff",
  ink = "#262626",
  strong = "#171717",
  muted = "#737373",
  dim = "#a3a3a3",
  line = "#d4d4d4",
  faintLine = "#e5e5e5",
  chrome = "#fafafa",
  selection = "#e5e5e5",
  search = "#d4d4d4",
}
local set = vim.api.nvim_set_hl
local groups = {
  Normal = { fg = p.ink, bg = p.paper },
  NormalNC = { link = "Normal" },
  NormalFloat = { fg = p.ink, bg = p.chrome },
  FloatBorder = { fg = p.line, bg = p.chrome },
  FloatTitle = { fg = p.strong, bg = p.chrome, bold = true },
  ColorColumn = { bg = p.chrome },
  Conceal = { fg = p.dim },
  Cursor = { fg = p.paper, bg = p.strong },
  CursorLine = { bg = p.chrome },
  CursorColumn = { bg = p.chrome },
  CursorLineNr = { fg = p.strong, bold = true },
  LineNr = { fg = p.dim },
  SignColumn = { fg = p.muted, bg = p.paper },
  FoldColumn = { fg = p.dim, bg = p.chrome },
  Folded = { fg = p.muted, bg = p.chrome },
  EndOfBuffer = { fg = p.faintLine },
  NonText = { fg = p.dim },
  SpecialKey = { fg = p.dim },
  Whitespace = { fg = p.faintLine },
  VertSplit = { fg = p.line },
  WinSeparator = { fg = p.line },
  StatusLine = { fg = p.ink, bg = p.chrome },
  StatusLineNC = { fg = p.muted, bg = p.chrome },
  TabLine = { fg = p.muted, bg = p.chrome },
  TabLineFill = { bg = p.chrome },
  TabLineSel = { fg = p.strong, bg = p.paper, bold = true },
  WinBar = { fg = p.ink, bg = p.paper },
  WinBarNC = { fg = p.muted, bg = p.paper },
  Pmenu = { fg = p.ink, bg = p.chrome },
  PmenuSel = { fg = p.strong, bg = p.selection, bold = true },
  PmenuSbar = { bg = p.faintLine },
  PmenuThumb = { bg = p.dim },
  WildMenu = { fg = p.strong, bg = p.selection },
  Visual = { bg = p.selection },
  VisualNOS = { bg = p.selection },
  Search = { fg = p.strong, bg = p.search },
  IncSearch = { fg = p.strong, bg = p.search, bold = true },
  CurSearch = { link = "IncSearch" },
  Substitute = { link = "IncSearch" },
  MatchParen = { fg = p.strong, bg = p.selection, bold = true },
  Directory = { fg = p.strong },
  Title = { fg = p.strong, bold = true },
  Question = { fg = p.strong },
  MoreMsg = { fg = p.strong },
  WarningMsg = { fg = p.ink },
  ErrorMsg = { fg = p.strong, bold = true },
  ModeMsg = { fg = p.ink },
  QuickFixLine = { bg = p.selection },
  SpellBad = { undercurl = true, sp = p.strong },
  SpellCap = { undercurl = true, sp = p.muted },
  SpellLocal = { undercurl = true, sp = p.muted },
  SpellRare = { undercurl = true, sp = p.muted },

  -- Pi syntax roles: comments/strings/numbers muted, keywords/types strong.
  Comment = { fg = p.muted, italic = true },
  Constant = { fg = p.muted },
  String = { fg = p.muted },
  Character = { link = "String" },
  Number = { fg = p.muted },
  Boolean = { fg = p.muted },
  Float = { link = "Number" },
  Identifier = { fg = p.ink },
  Function = { fg = p.ink },
  Statement = { fg = p.strong, bold = true },
  Conditional = { link = "Statement" },
  Repeat = { link = "Statement" },
  Label = { link = "Statement" },
  Operator = { fg = p.ink },
  Keyword = { link = "Statement" },
  Exception = { link = "Statement" },
  PreProc = { fg = p.strong },
  Type = { fg = p.strong, bold = true },
  Special = { fg = p.muted },
  Delimiter = { fg = p.muted },
  Underlined = { fg = p.ink, underline = true },
  Ignore = { fg = p.dim },
  Error = { fg = p.strong, bold = true },
  Todo = { fg = p.strong, bg = p.selection, bold = true },

  -- Markdown roles from the source theme.
  ["@markup.heading"] = { fg = p.strong, bold = true },
  ["@markup.link"] = { fg = p.ink, underline = true },
  ["@markup.link.url"] = { fg = p.muted, underline = true },
  ["@markup.raw"] = { fg = p.strong },
  ["@markup.raw.block"] = { fg = p.ink, bg = p.chrome },
  ["@markup.quote"] = { fg = p.muted },
  ["@markup.list"] = { fg = p.ink },
  ["@markup.strong"] = { fg = p.strong, bold = true },
  ["@markup.italic"] = { fg = p.ink, italic = true },
  markdownH1 = { link = "@markup.heading" },
  markdownH2 = { link = "@markup.heading" },
  markdownH3 = { link = "@markup.heading" },
  markdownCode = { fg = p.strong },
  markdownCodeBlock = { fg = p.ink, bg = p.chrome },
  markdownBlockquote = { fg = p.muted },
  markdownRule = { fg = p.faintLine },
  markdownListMarker = { fg = p.ink },
  markdownLinkText = { fg = p.ink, underline = true },
  markdownUrl = { fg = p.muted, underline = true },

  -- Diffs, diagnostics and Git signs remain monochrome like Pi's roles.
  DiffAdd = { fg = p.strong, bg = p.chrome },
  DiffDelete = { fg = p.muted, bg = p.chrome },
  DiffChange = { fg = p.muted, bg = p.chrome },
  DiffText = { fg = p.strong, bg = p.selection, bold = true },
  Added = { fg = p.strong },
  Removed = { fg = p.muted },
  Changed = { fg = p.muted },
  DiagnosticError = { fg = p.strong },
  DiagnosticWarn = { fg = p.ink },
  DiagnosticInfo = { fg = p.muted },
  DiagnosticHint = { fg = p.dim },
  DiagnosticOk = { fg = p.strong },
  DiagnosticDeprecated = { fg = p.dim, strikethrough = true },
  GitSignsAdd = { fg = p.strong },
  GitSignsChange = { fg = p.muted },
  GitSignsDelete = { fg = p.muted },

  -- Common LazyVim UI components.
  WhichKey = { fg = p.strong },
  WhichKeyDesc = { fg = p.ink },
  WhichKeyGroup = { fg = p.muted },
  WhichKeySeparator = { fg = p.dim },
  TelescopeBorder = { fg = p.line, bg = p.chrome },
  TelescopeNormal = { fg = p.ink, bg = p.chrome },
  TelescopeSelection = { fg = p.strong, bg = p.selection },
  TelescopeMatching = { fg = p.strong, bold = true },
  SnacksPickerBorder = { fg = p.line, bg = p.chrome },
  SnacksPickerNormal = { fg = p.ink, bg = p.chrome },
  SnacksPickerMatch = { fg = p.strong, bold = true },
  SnacksPickerSelected = { fg = p.strong, bg = p.selection },
  SnacksIndent = { fg = p.faintLine },
  SnacksIndentScope = { fg = p.line },
  IblIndent = { fg = p.faintLine },
  IblScope = { fg = p.line },
  BlinkCmpMenu = { fg = p.ink, bg = p.chrome },
  BlinkCmpMenuBorder = { fg = p.line, bg = p.chrome },
  BlinkCmpMenuSelection = { fg = p.strong, bg = p.selection },
  BlinkCmpLabelMatch = { fg = p.strong, bold = true },
  CmpItemAbbrMatch = { fg = p.strong, bold = true },
  LspInlayHint = { fg = p.dim, bg = p.chrome },
}

local captures = {
  ["@comment"] = "Comment",
  ["@string"] = "String",
  ["@character"] = "Character",
  ["@number"] = "Number",
  ["@boolean"] = "Boolean",
  ["@constant"] = "Constant",
  ["@keyword"] = "Statement",
  ["@keyword.function"] = "Statement",
  ["@keyword.operator"] = "Statement",
  ["@function"] = "Function",
  ["@function.call"] = "Function",
  ["@method"] = "Function",
  ["@variable"] = "Identifier",
  ["@variable.parameter"] = "Identifier",
  ["@property"] = "Identifier",
  ["@type"] = "Type",
  ["@type.builtin"] = "Type",
  ["@operator"] = "Operator",
  ["@punctuation"] = "Delimiter",
  ["@punctuation.bracket"] = "Delimiter",
  ["@punctuation.delimiter"] = "Delimiter",
  ["@lsp.type.class"] = "Type",
  ["@lsp.type.interface"] = "Type",
  ["@lsp.type.enum"] = "Type",
  ["@lsp.type.function"] = "Function",
  ["@lsp.type.method"] = "Function",
  ["@lsp.type.variable"] = "Identifier",
  ["@lsp.type.parameter"] = "Identifier",
  ["@lsp.type.property"] = "Identifier",
}
for name, target in pairs(captures) do
  groups[name] = { link = target }
end
for _, severity in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
  groups["DiagnosticSign" .. severity] = { link = "Diagnostic" .. severity }
  groups["DiagnosticVirtualText" .. severity] = { fg = groups["Diagnostic" .. severity].fg, bg = p.chrome }
  groups["DiagnosticUnderline" .. severity] = { undercurl = true, sp = groups["Diagnostic" .. severity].fg }
  groups["DiagnosticFloating" .. severity] = { link = "Diagnostic" .. severity }
end
for name, opts in pairs(groups) do
  set(0, name, opts)
end

-- Terminal ANSI colors drawn exclusively from the Pi palette.
local terminal = {
  p.strong, p.strong, p.ink, p.muted, p.ink, p.muted, p.dim, p.paper,
  p.muted, p.strong, p.ink, p.muted, p.ink, p.muted, p.line, p.paper,
}
for i, color in ipairs(terminal) do
  vim.g["terminal_color_" .. (i - 1)] = color
end
