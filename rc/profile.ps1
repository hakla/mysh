Import-Module PSReadLine
Import-Module posh-git
Import-Module git-aliases -DisableNameChecking

Set-PSReadLineOption -EditMode Emacs

function prompt{
  $esc=[char]27
  $p = $pwd.ProviderPath
  if ($pwd.provider.name -eq "FileSystem") {
    Write-host "$esc]9;9;`"$p`"$esc\" -NoNewline
  }
  $prompt = & $GitPromptScriptBlock
  "$prompt"
}
