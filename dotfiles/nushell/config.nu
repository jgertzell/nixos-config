$env.config.history.max_size = 1000000
$env.TZDIR = "/etc/zoneinfo"
$env.SSL_CERT_DIR = $"/etc/ssl/certs:($env.HOME)/.aspnet/dev-certs/trust"
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".dotnet" "tools") | uniq)
$env.config.abbreviations = {
  ll: "ls -l",
  gs: "git status",
  gco: "git checkout",
  gfp: "git fetch && git pull"
}

# Nushell does not load external command completions like fish does.
# Keep this nushell-specific unless the other shells lose their native completion support.
let fish_completer = {|spans|
  let expanded_alias = (scope aliases | where name == $spans.0 | $in.0?.expansion?)
  let spans = (if $expanded_alias != null {
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans
  })

  fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
  | from tsv --flexible --noheaders --no-infer
  | rename value description
  | update value {|row|
    let value = $row.value
    let need_quote = ['\\ ' '[' ']' '(' ')' ' ' '\t' "'" '"' '`'] | any {$in in $value}
    if ($need_quote and ($value | path exists)) {
      let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
      $'"($expanded_path | str replace --all "\"" "\\\"")"'
    } else {$value}
  }
}

$env.config.completions.external = {
  enable: true,
  completer: $fish_completer
}

source /etc/nixos/dotfiles/nushell/zoxide.nu

def nixos-switch [] {
  sudo nixos-rebuild switch --flake $"/etc/nixos#(^hostname | str trim)"
}

alias "nvim-cheatsheet" = glow /etc/nixos/docs/neovim.md
alias "nvim-help" = glow /etc/nixos/docs/neovim.md
