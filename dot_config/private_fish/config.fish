set fish_greeting

# Load Homebrew environment
eval (/opt/homebrew/bin/brew shellenv)

function fish_prompt
    set_color cyan
    echo -n (whoami) # only username (X)
    set_color normal
    echo -n " "(prompt_pwd)" ❯ "
end

# opencode
fish_add_path /Users/wangyuxiang/.opencode/bin

## starship - 最後に以下を追記してください
starship init fish | source
