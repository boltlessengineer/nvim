-- TODO: refactor
-- 1-cell & 2-cell + codeicons option
local nerd = {
  kind = {
    -- based on lsp-kind
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = 'ﰠ',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '塞', -- TODO: this font doesn't work with font fallback on wezterm
    Value = '',
    Enum = '',
    Keyword = '',
    -- Snippet = "",
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = 'פּ',
    Event = '',
    Operator = '',
    TypeParameter = ''
  },
  type = {
    Array = '',
    Number = '',
    String = '',
    Boolean = '蘒', -- TODO: this font doesn't work with font fallback on wezterm
    Object = '',
  },
  documents = {
    File = '',
    Files = '',
    Folder = '',
    OpenFolder = '',
  },
  git = {
    Add = '',
    Mod = '',
    Remove = '',
    Ignore = '',
    Rename = '',
    Diff = '',
    Repo = '',
    Octoface = '',

    -- NOTE: these three are not default icons
    Branch = '',
    Ahead = '⇡',
    Behind = '⇣',
  },
  ui = {
    ArrowClosed = '',
    ArrowOpen = '',
    Lock = '',
    Circle = '',
    BigCircle = '',
    BigUnfilledCircle = '',
    Close = '',
    NewFile = '',
    Search = '',
    Lightbulb = '',
    Project = '',
    Dashboard = '',
    History = '',
    Comment = '',
    Bug = '',
    Code = '',
    Telescope = '',
    Gear = '',
    Package = '',
    List = '',
    SignIn = '',
    SignOut = '',
    -- TODO: NoteBook icon
    Check = '',
    Fire = '',
    Note = '',
    BookMark = '',
    Pencil = '',
    -- ChevronRight = "",
    ChevronRight = '>',
    Table = '',
    Calendar = '',
    CloudDownload = '',
  },
  diagnostics = {
    Error = '',
    Warning = '',
    Information = '',
    Question = '',
    Hint = '',
  },
  misc = {
    Robot = 'ﮧ',
    Squirrel = '',
    Tag = '',
    Watch = '',
    Smiley = 'ﲃ',
    Package = '',
    CircuitBoard = '',
  },
}
local codeicons = {
  kind = {
    Text = " ",
    Method = " ",
    Function = " ",
    Constructor = " ",
    Field = " ",
    Variable = " ",
    Class = " ",
    Interface = " ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = " ",
    Keyword = " ",
    Snippet = " ",
    Color = " ",
    File = " ",
    Reference = " ",
    Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
    Misc = " ",
  },
  type = {
    Array = " ",
    Number = " ",
    String = " ",
    Boolean = " ",
    Object = " ",
  },
  documents = {
    File = " ",
    Files = " ",
    Folder = " ",
    OpenFolder = " ",
  },
  git = {
    Add = " ",
    Mod = " ",
    Remove = " ",
    Ignore = " ",
    Rename = " ",
    Diff = " ",
    Repo = " ",
    Octoface = " ",

    -- NOTE: these three are not default icons
    Branch = '',
    Ahead = '⇡',
    Behind = '⇣',
  },
  ui = {
    ArrowClosed = "",
    ArrowOpen = "",
    Lock = " ",
    Circle = " ",
    BigCircle = " ",
    BigUnfilledCircle = " ",
    Close = " ",
    NewFile = " ",
    Search = " ",
    Lightbulb = " ",
    Project = " ",
    Dashboard = " ",
    History = " ",
    Comment = " ",
    Bug = " ",
    Code = " ",
    Telescope = " ",
    Gear = " ",
    Package = " ",
    List = " ",
    SignIn = " ",
    SignOut = " ",
    NoteBook = " ",
    Check = " ",
    Fire = " ",
    Note = " ",
    BookMark = " ",
    Pencil = " ",
    ChevronRight = " ",
    Table = " ",
    Calendar = " ",
    CloudDownload = " ",
  },
  diagnostics = {
    Error = " ",
    Warning = " ",
    Information = " ",
    Question = " ",
    Hint = " ",
  },
  misc = {
    Robot = " ",
    Squirrel = " ",
    Tag = " ",
    Watch = " ",
    Smiley = " ",
    Package = " ",
    CircuitBoard = " ",
  },
}
return codeicons
