{ config, lib, ... }:
let
	palettes = {
		dark = import ./colors/paradise.nix { };
		light = import ./colors/paradise-light.nix { };
	};
	colors = import ./colors/${config.theme}.nix { };
	mkHighlights = colors:
		let
			ui = {
				background = colors.base00;
				panel      = colors.base01;
				border     = colors.base02;
				subtle     = colors.base03;
				muted      = colors.base04;
				foreground = colors.base05;
				selection  = colors.base02;
			};
			semantic = {
				error     = colors.base08;
				warning   = colors.base09;
				success   = colors.base0B;
				info      = colors.base0D;
				hint      = colors.base0C;
				comment   = colors.base03;
				keyword   = colors.base0E;
				function  = colors.base0D;
				constant  = colors.base0C;
				type      = colors.base0A;
				variable  = colors.base05;
				member    = colors.base04;
				string    = colors.base0B;
				number    = colors.base09;
				operator  = colors.base04;
				attribute = colors.base0C;
				label     = colors.base0D;
				tag       = colors.base0E;
			};
		in {

			# ── UI chrome ─────────────────────────────────────────────────────────────
			CursorLine    = { fg = "none";        bg = ui.panel; };
			CursorLineNr  = { fg = ui.foreground; bg = "none"; bold = true; };
			LineNr        = { fg = ui.border;     bg = "none"; };
			WinSeparator  = { fg = ui.border;     bg = "none"; };
			Whitespace    = { fg = ui.border; };
			StatusNormal  = { bg = "none";        fg = "none"; };
			SignColumn    = { fg = "none";        bg = "none"; };
			FoldColumn    = { fg = ui.subtle;     bg = "none"; };
			Folded        = { fg = ui.subtle;     bg = ui.panel; };
			NormalSB      = { bg = ui.panel;      fg = "none"; };
			EndOfBuffer   = { fg = ui.panel; };

			# ── Selection & search ────────────────────────────────────────────────────
			Visual    = { bg = ui.selection; };
			Search    = { fg = ui.background; bg = semantic.warning; };
			IncSearch = { fg = ui.background; bg = semantic.info; };
			CurSearch = { fg = ui.background; bg = semantic.info; bold = true; };

			# ── Diagnostics ───────────────────────────────────────────────────────────
			DiagnosticError            = { fg = semantic.error; };
			DiagnosticWarn             = { fg = semantic.warning; };
			DiagnosticInfo             = { fg = semantic.info; };
			DiagnosticHint             = { fg = semantic.hint; };
			DiagnosticUnderlineError   = { undercurl = true; sp = semantic.error; };
			DiagnosticUnderlineWarn    = { undercurl = true; sp = semantic.warning; };
			DiagnosticUnderlineInfo    = { undercurl = true; sp = semantic.info; };
			DiagnosticUnderlineHint    = { undercurl = true; sp = semantic.hint; };
			DiagnosticVirtualTextError = { fg = semantic.error; italic = true; };
			DiagnosticVirtualTextWarn  = { fg = semantic.warning; italic = true; };
			DiagnosticVirtualTextInfo  = { fg = semantic.info; italic = true; };
			DiagnosticVirtualTextHint  = { fg = semantic.hint; italic = true; };
			DiagnosticOk               = { fg = semantic.success; };

			# ── FS ────────────────────────────────────────────────────────────────────
			Directory                  = { fg = semantic.info; };
			Underlined                 = { fg = semantic.info; underline = true; };
			Added                      = { fg = semantic.success; };
			Changed                    = { fg = semantic.warning; };
			Removed                    = { fg = semantic.error; };

			# ── GIT ───────────────────────────────────────────────────────────────────
			GitGutterAdd                  = { link = "Added"; };
			GitGutterChange               = { link = "Changed"; };
			GitGutterDelete               = { link = "Removed"; };
			GitSignsAdd                   = { link = "Added"; };
			GitSignsAddCul                = { link = "GitSignsAdd"; };
			GitSignsAddNr                 = { link = "GitSignsAdd"; };
			GitSignsChange                = { link = "Changed"; };
			GitSignsChangeCul             = { link = "GitSignsChange"; };
			GitSignsChangeNr              = { link = "GitSignsChange"; };
			GitSignsChangedelete          = { link = "GitSignsChange"; };
			GitSignsChangedeleteCul       = { link = "GitSignsChangeCul"; };
			GitSignsChangedeleteNr        = { link = "GitSignsChangeNr"; };
			GitSignsDelete                = { link = "Removed"; };
			GitSignsDeleteCul             = { link = "GitSignsDelete"; };
			GitSignsDeleteNr              = { link = "GitSignsDelete"; };
			GitSignsTopdelete             = { link = "GitSignsDelete"; };
			GitSignsTopdeleteCul          = { link = "GitSignsDeleteCul"; };
			GitSignsTopdeleteNr           = { link = "GitSignsDeleteNr"; };
			GitSignsUntracked             = { link = "GitSignsAdd"; };
			GitSignsUntrackedCul          = { link = "GitSignsAddCul"; };
			GitSignsUntrackedNr           = { link = "GitSignsAddNr"; };
			GitSignsStagedAdd             = { link = "Added"; };
			GitSignsStagedAddCul          = { link = "GitSignsStagedAdd"; };
			GitSignsStagedAddNr           = { link = "GitSignsStagedAdd"; };
			GitSignsStagedChange          = { link = "Changed"; };
			GitSignsStagedChangeCul       = { link = "GitSignsStagedChange"; };
			GitSignsStagedChangeNr        = { link = "GitSignsStagedChange"; };
			GitSignsStagedChangedelete    = { link = "GitSignsStagedChange"; };
			GitSignsStagedChangedeleteCul = { link = "GitSignsStagedChangeCul"; };
			GitSignsStagedChangedeleteNr  = { link = "GitSignsStagedChangeNr"; };
			GitSignsStagedDelete          = { link = "Removed"; };
			GitSignsStagedDeleteCul       = { link = "GitSignsStagedDelete"; };
			GitSignsStagedDeleteNr        = { link = "GitSignsStagedDelete"; };
			GitSignsStagedTopdelete       = { link = "GitSignsStagedDelete"; };
			GitSignsStagedTopdeleteCul    = { link = "GitSignsStagedDeleteCul"; };
			GitSignsStagedTopdeleteNr     = { link = "GitSignsStagedDeleteNr"; };
			GitSignsStagedUntracked       = { link = "GitSignsStagedAdd"; };
			GitSignsStagedUntrackedCul    = { link = "GitSignsStagedAddCul"; };
			GitSignsStagedUntrackedNr     = { link = "GitSignsStagedAddNr"; };

			# ── Popups & floats ───────────────────────────────────────────────────────
			Pmenu       = { fg = ui.muted;      bg = ui.panel; };
			PmenuSbar   = { fg = "none";        bg = ui.panel; };
			PmenuThumb  = { fg = "none";        bg = ui.subtle; };
			PmenuSel    = { fg = ui.foreground; bg = ui.selection; };
			FloatBorder = { fg = ui.border;     bg = "none"; };
			NormalFloat = { fg = "none";        bg = ui.background; };

			# ── Noice cmdline ─────────────────────────────────────────────────────────
			NoiceCmdlinePopup             = { fg = ui.muted;  bg = ui.panel; };
			NoiceCmdlinePopupBorder       = { fg = ui.border; bg = ui.panel; };
			NoiceCmdlinePopupBorderSearch = { fg = ui.subtle; bg = ui.panel; };

			# ── MiniPick ─────────────────────────────────────────────────────────────
			MiniPickBorder      = { link = "FloatBorder"; };
			MiniPickNormal      = { link = "NormalFloat"; };
			MiniPickPrompt      = { link = "Title"; };
			MiniPickMatchCurrent = { link = "PmenuSel"; };
			MiniPickMatchRanges  = { link = "Search"; };

			# ── Alpha dashboard ───────────────────────────────────────────────────────
			AlphaHeader = { fg = semantic.keyword; bg = "none"; };

			# ── Completion (nvim-cmp) ─────────────────────────────────────────────────
			CmpItemAbbrMatch      = { fg = semantic.function; bg = "none"; bold = true; };
			CmpItemAbbrMatchFuzzy = { fg = semantic.function; bg = "none"; };
			CmpItemAbbr           = { fg = ui.muted;          bg = "none"; };
			CmpItemKind           = { fg = semantic.constant; bg = "none"; };
			CmpItemMenu           = { fg = ui.subtle;         bg = "none"; };
			CmpItemKindSnippet    = { fg = semantic.string;   bg = "none"; };

			# ── LSP / Trouble ─────────────────────────────────────────────────────────
			TroubleNormal       = { link = "Normal"; };
			TroubleNormalNC     = { link = "NormalNC"; };
			LspReferenceRead    = { bg = ui.selection; };
			LspReferenceText    = { bg = ui.selection; };
			LspReferenceWrite   = { bg = ui.selection; };
			LspInlayHint        = { fg = semantic.comment; bg = "none"; };
			NeoTreeGitUntracked = { fg = semantic.warning; bg = "none"; };

			# ── Navic (breadcrumbs) ────────────────────────────────────────────────────
			NavicIconsFile          = { fg = semantic.member;   bg = ui.background; };
			NavicIconsModule        = { fg = semantic.keyword;  bg = ui.background; };
			NavicIconsNamespace     = { fg = semantic.type;     bg = ui.background; };
			NavicIconsPackage       = { fg = semantic.keyword;  bg = ui.background; };
			NavicIconsClass         = { fg = semantic.type;     bg = ui.background; };
			NavicIconsMethod        = { fg = semantic.function; bg = ui.background; };
			NavicIconsProperty      = { fg = semantic.constant; bg = ui.background; };
			NavicIconsField         = { fg = semantic.member;   bg = ui.background; };
			NavicIconsConstructor   = { fg = semantic.warning;  bg = ui.background; };
			NavicIconsEnum          = { fg = semantic.constant; bg = ui.background; };
			NavicIconsInterface     = { fg = semantic.type;     bg = ui.background; };
			NavicIconsFunction      = { fg = semantic.function; bg = ui.background; };
			NavicIconsVariable      = { fg = semantic.variable; bg = ui.background; };
			NavicIconsConstant      = { fg = semantic.warning;  bg = ui.background; };
			NavicIconsString        = { fg = semantic.string;   bg = ui.background; };
			NavicIconsNumber        = { fg = semantic.number;   bg = ui.background; };
			NavicIconsBoolean       = { fg = semantic.number;   bg = ui.background; };
			NavicIconsArray         = { fg = semantic.keyword;  bg = ui.background; };
			NavicIconsObject        = { fg = semantic.type;     bg = ui.background; };
			NavicIconsKey           = { fg = semantic.constant; bg = ui.background; };
			NavicIconsNull          = { fg = semantic.comment;  bg = ui.background; };
			NavicIconsEnumMember    = { fg = semantic.constant; bg = ui.background; };
			NavicIconsStruct        = { fg = semantic.type;     bg = ui.background; };
			NavicIconsEvent         = { fg = semantic.function; bg = ui.background; };
			NavicIconsOperator      = { fg = semantic.operator; bg = ui.background; };
			NavicIconsTypeParameter = { fg = semantic.constant; bg = ui.background; };
			NavicText               = { fg = ui.foreground;     bg = ui.background; };
			NavicSeparator          = { fg = semantic.comment;  bg = ui.background; };


			# ── Comments ──────────────────────────────────────────────────────────────
			"@comment"               = { fg = semantic.comment; italic = true; };
			"@comment.documentation" = { fg = semantic.comment; italic = true; };
			"@comment.error"         = { fg = semantic.error;   italic = true; };  # FIXME
			"@comment.warning"       = { fg = semantic.warning; italic = true; };  # TODO, HACK
			"@comment.note"          = { fg = semantic.hint;    italic = true; };  # NOTE, INFO

			# ── Keywords & control flow ───────────────────────────────────────────────
			# Lavender — the grammar skeleton. Pervasive but soft.
			"@keyword"             = { fg = semantic.keyword; };
			"@keyword.function"    = { fg = semantic.keyword; };          # fn, func, def
			"@keyword.return"      = { fg = semantic.keyword; italic = true; };  # rose — terminator, not just grammar
			"@keyword.operator"    = { fg = semantic.keyword; };          # and, or, not, sizeof
			"@keyword.exception"   = { fg = semantic.error; };          # try, catch, throw, raise, panic
			"@keyword.coroutine"   = { fg = semantic.keyword; italic = true; };  # async, await
			"@keyword.storage"     = { fg = semantic.keyword; };          # static, extern, register
			"@keyword.modifier"    = { fg = semantic.keyword; };          # const (qualifier), volatile
			"@keyword.type"        = { fg = semantic.keyword; };          # struct, enum, union, typedef
			"@keyword.conditional" = { fg = semantic.keyword; };
			"@keyword.repeat"      = { fg = semantic.keyword; };

			# ── Preprocessor (C / C++) ────────────────────────────────────────────────
			"@keyword.import"           = { fg = semantic.warning; };   # use, import, #include
			"@keyword.directive"        = { fg = semantic.warning; };   # all # directives
			"@keyword.directive.define" = { fg = semantic.warning; };   # #define specifically
			"@preproc"                  = { fg = semantic.warning; };   # compat alias

			# ── Functions & calls ─────────────────────────────────────────────────────
			"@function"             = { fg = semantic.function; };
			"@function.call"        = { fg = semantic.function; };
			"@function.builtin"     = { fg = semantic.function; italic = true; };
			"@function.method"      = { fg = semantic.function; };
			"@function.method.call" = { fg = semantic.function; };
			"@constructor"          = { fg = semantic.function; };

			"@function.macro"       = { fg = semantic.function; };

			# ── Constants ─────────────────────────────────────────────────────────────
			"@constant"         = { fg = semantic.constant; };
			"@constant.builtin" = { fg = semantic.constant; italic = true; };
			"@constant.macro"   = { fg = semantic.constant; };

			# ── Types ─────────────────────────────────────────────────────────────────
			"@type"            = { fg = semantic.type; };
			"@type.builtin"    = { fg = semantic.type; italic = true; };   # int, bool, char, void
			"@type.definition" = { fg = semantic.type; bold = true; };     # typedef / type alias LHS
			"@type.qualifier"  = { fg = semantic.keyword; };                  # const qualifier → keyword axis

			"@module"         = { fg = semantic.type; italic = true; };
			"@module.builtin" = { fg = semantic.type; italic = true; };

			# ── Variables ─────────────────────────────────────────────────────────────
			"@variable"           = { fg = semantic.variable; };
			"@variable.builtin"   = { fg = semantic.keyword; italic = true; };  # self, this, super
			"@variable.parameter" = { fg = semantic.variable; italic = true; };
			"@variable.member"    = { fg = semantic.member; };                 # struct fields / obj props

			# ── Literals ──────────────────────────────────────────────────────────────
			"@string"            = { fg = semantic.string; };                # sage — data content
			"@string.escape"     = { fg = semantic.constant; };                # \n, \t → teal pops inside strings
			"@string.regex"      = { fg = semantic.constant; };
			"@string.special"    = { fg = semantic.constant; };
			"@character"         = { fg = semantic.string; };                # 'c'
			"@character.special" = { fg = semantic.constant; };
			"@number"            = { fg = semantic.number; };                # gold — type-adjacent
			"@number.float"      = { fg = semantic.number; };
			"@boolean"           = { fg = semantic.number; };

			# ── Operators & punctuation ───────────────────────────────────────────────
			"@operator"              = { fg = semantic.operator; };
			"@punctuation.delimiter" = { fg = semantic.operator; };   # , ; .
			"@punctuation.bracket"   = { fg = semantic.operator; };   # ( ) [ ] { }
			"@punctuation.special"   = { fg = semantic.constant; };   # string interpolation ${}

			# ── Attributes ────────────────────────────────────────────────────────────
			"@attribute"         = { fg = semantic.attribute; };
			"@attribute.builtin" = { fg = semantic.attribute; italic = true; };
			"@lsp.type.builtinAttribute" = { fg = semantic.attribute; italic = true; };

			# ── Labels ────────────────────────────────────────────────────────────────
			"@label" = { fg = semantic.label; };   # goto labels, Rust loop labels ('label:)

			# ── Tags (HTML / JSX) ─────────────────────────────────────────────────────
			"@tag"           = { fg = semantic.tag; };
			"@tag.attribute" = { fg = semantic.attribute; };
			"@tag.delimiter" = { fg = semantic.comment; };

			# ── Markup / documentation prose ──────────────────────────────────────────
			"@markup.raw"           = { fg = semantic.string; };
			"@markup.link"          = { fg = semantic.function; underline = true; };
			"@markup.link.label"    = { fg = semantic.function; };
			"@markup.link.url"      = { fg = semantic.function; underline = true; };
			"@markup.italic"        = { fg = semantic.variable; italic = true; };
			"@markup.strong"        = { fg = semantic.variable; bold = true; };
			"@markup.strikethrough" = { fg = semantic.comment;  strikethrough = true; };
			"@markup.underline"     = { fg = semantic.keyword;  underline = true; };
			"@markup.heading"       = { fg = semantic.function; bold = true; };
			"@markup.heading.1"     = { fg = semantic.function; bold = true; };
			"@markup.heading.2"     = { fg = semantic.type;     bold = true; };
			"@markup.heading.3"     = { fg = semantic.keyword;  bold = true; };
			"@markup.math"          = { fg = semantic.type; };
			"@markup.environment"   = { fg = semantic.keyword; };
			"@markup.list"          = { fg = semantic.constant; };


			# ══════════════════════════════════════════════════════════════════════════
			# LSP SEMANTIC TOKENS
			# Override treesitter when clangd / rust-analyzer is active.
			# ══════════════════════════════════════════════════════════════════════════

			# clangd emits `macro` for ALL macros at priority 125, stomping treesitter (100).
			# No LSP-level distinction between CONST_MACRO and FUNC_MACRO(x) exists.
			"@lsp.type.macro.c"                  = lib.nixvim.emptyTable;
			"@lsp.mod.declaration.c"             = lib.nixvim.emptyTable;
			"@lsp.mod.globalScope.c"             = lib.nixvim.emptyTable;
			"@lsp.typemod.macro.declaration.c"   = lib.nixvim.emptyTable;
			"@lsp.typemod.macro.globalScope.c"   = lib.nixvim.emptyTable;
			"@lsp.type.macro.cpp"                = lib.nixvim.emptyTable;
			"@lsp.mod.declaration.cpp"           = lib.nixvim.emptyTable;
			"@lsp.mod.globalScope.cpp"           = lib.nixvim.emptyTable;
			"@lsp.typemod.macro.declaration.cpp" = lib.nixvim.emptyTable;
			"@lsp.typemod.macro.globalScope.cpp" = lib.nixvim.emptyTable;

			"@lsp.type.function"      = { fg = semantic.function; };
			"@lsp.type.method"        = { fg = semantic.function; };
			"@lsp.type.variable"      = { fg = semantic.variable; };
			"@lsp.type.parameter"     = { fg = semantic.variable; italic = true; };
			"@lsp.type.property"      = { fg = semantic.member; };
			"@lsp.type.enum"          = { fg = semantic.type; };
			"@lsp.type.enumMember"    = { fg = semantic.constant; };
			"@lsp.type.struct"        = { fg = semantic.type;     italic = true; };
			"@lsp.type.class"         = { fg = semantic.type;     italic = true; };
			"@lsp.type.interface"     = { fg = semantic.type;     italic = true; };
			"@lsp.type.type"          = { fg = semantic.type; };
			"@lsp.type.typeParameter" = { fg = semantic.type;     italic = true; };
			"@lsp.type.namespace"     = { fg = semantic.type;     italic = true; };
			"@lsp.type.keyword"       = { fg = semantic.keyword; };
			"@lsp.type.comment"       = { fg = semantic.comment;  italic = true; };
			"@lsp.type.string"        = { fg = semantic.string; };
			"@lsp.type.number"        = { fg = semantic.number; };
			"@lsp.type.operator"      = { fg = semantic.operator; };
			"@lsp.type.decorator"     = { fg = semantic.attribute; };
			"@lsp.type.selfKeyword"   = { fg = semantic.keyword;  italic = true; };

			"@lsp.mod.deprecated"     = { strikethrough = true; };
			"@lsp.mod.readonly"       = { italic = true; };
			"@lsp.mod.static"         = { italic = true; };

			"@keyword.doxygen"        = { fg = semantic.keyword; italic = true; };

			# ── Bufferline ───────────────────────────────────────────────────────────────
			BufferLineFill                  = { fg = ui.muted;      bg = ui.background; };
			BufferLineBackground            = { fg = ui.subtle;     bg = ui.panel; };
			BufferLineBufferSelected        = { fg = ui.foreground; bg = ui.background; bold = true; };
			BufferLineBufferVisible         = { fg = ui.subtle;     bg = ui.background; };
			BufferLineCloseButton           = { fg = ui.subtle;     bg = ui.panel; };
			BufferLineCloseButtonVisible    = { fg = ui.subtle;     bg = ui.panel; };
			BufferLineCloseButtonSelected   = { fg = semantic.error; };
			BufferLineIndicatorSelected     = { fg = "none";        bg = semantic.function; };
			BufferLineIndicatorVisible      = { fg = "none";        bg = "none"; };
			BufferLineSeparator             = { fg = ui.panel;      bg = ui.panel; };
			BufferLineSeparatorVisible      = { fg = ui.border;     bg = ui.border; };
			BufferLineModified              = { fg = ui.subtle;     bg = ui.panel; };
			BufferLineModifiedVisible       = { fg = ui.subtle;     bg = ui.background; };
			BufferLineModifiedSelected      = { fg = semantic.success; };
			BufferLineTabClose              = { fg = ui.border;     bg = ui.background; };
			BufferLineDuplicate             = { fg = ui.subtle;     bg = ui.panel; };
			# Bufferline groups used by newer versions and by optional integrations.
			BufferLineDevIconDefaultSelected = { link = "BufferLineBufferSelected"; };
			BufferLineDevIconDefault         = { link = "BufferLineBackground"; };
			BufferLineDevIconDefaultVisible  = { link = "BufferLineBufferVisible"; };
			BufferLineDevIconDefaultInactive = { link = "BufferLineBackground"; };
			BufferLineTab                    = { link = "BufferLineBackground"; };
			BufferLineBuffer                 = { link = "BufferLineBackground"; };
			BufferLineNumbers                = { link = "BufferLineBackground"; };
			BufferLineGroupLabel             = { link = "Title"; };
			BufferLineDiagnostic             = { link = "DiagnosticInfo"; };
			BufferLineTabSeparator           = { link = "BufferLineSeparator"; };
			BufferLineNumbersVisible         = { link = "BufferLineBufferVisible"; };
			BufferLineWarningVisible         = { link = "DiagnosticWarn"; };
			BufferLineErrorDiagnostic        = { link = "DiagnosticError"; };
			BufferLineWarningDiagnostic      = { link = "DiagnosticWarn"; };

			# Fyler uses its own groups for file and git-status rendering.
			FylerNormal          = { link = "Normal"; };
			FylerNormalNC        = { link = "NormalNC"; };
			FylerBorder          = { link = "FloatBorder"; };
			FylerFSDirectoryIcon = { link = "Directory"; };
			FylerFSDirectoryName = { link = "Directory"; };
			FylerFSFile          = { link = "Normal"; };
			FylerFSLink          = { link = "Underlined"; };
			FylerDirectoryIcon   = { link = "Directory"; };
			FylerDirectoryName   = { link = "Directory"; };
			FylerIndentMarker    = { link = "NonText"; };
			FylerIndentGuide     = { link = "NonText"; };
			FylerGrey            = { link = "Comment"; };
			FylerGreen           = { link = "Added"; };
			FylerYellow          = { link = "Changed"; };
			FylerRed             = { link = "Removed"; };
			FylerGitAdded        = { link = "Added"; };
			FylerGitStaged       = { link = "Added"; };
			FylerGitModified     = { link = "Changed"; };
			FylerGitUnstaged     = { link = "Changed"; };
			FylerGitDeleted      = { link = "Removed"; };
			FylerGitConflict     = { link = "DiagnosticError"; };
			FylerGitRenamed      = { link = "Changed"; };
			FylerGitUntracked    = { link = "Added"; };
			FylerGitIgnored      = { link = "NonText"; };
		};
in {
	options.themeData = lib.mkOption {
		type = lib.types.attrs;
		internal = true;
		default = { };
	};

	config = lib.mkIf config.colorschemes.base16.enable {
		themeData = {
			inherit palettes;
			highlights = lib.mapAttrs (_: palette: mkHighlights palette) palettes;
		};
		highlight = mkHighlights colors;
	};
}
