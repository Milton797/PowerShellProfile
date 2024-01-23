# Set PowerShell to UTF-8
# -------------------------------------
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Imports
# -------------------------------------
Import-Module -Name z
Import-Module -Name PSFzf
Import-Module -Name posh-git
Import-Module -Name PSReadLine
Import-Module -Name PowerColorLS
Import-Module -Name Terminal-Icons

# Global variables
# -------------------------------------
$Theme = "$env:POSH_THEMES_PATH/amro.omp.json"
$WindowSize = $Host.UI.RawUI.WindowSize
$BigWindow = (($WindowSize.Width -ge 54) -and ($WindowSize.Height -ge 15))
$UseListView = if ($BigWindow) { "ListView" } else { "InLineView" }

# Start Oh My Posh prompt
# -------------------------------------
oh-my-posh init pwsh -c $Theme | Invoke-Expression

# Enable and configure PSReadLine predictive IntelliSense
# -------------------------------------
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle $UseListView

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key DownArrow -Function NextHistory
Set-PSReadLineKeyHandler -Key UpArrow -Function PreviousHistory
Set-PSReadlineKeyHandler -Key 'Shift+Tab' -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadlineKeyHandler -Key 'Alt+d' -ScriptBlock { Invoke-SetFuzzyDirectory }

# Configuration to PSFzf
# -------------------------------------
Set-PsFzfOption -TabExpansion
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t'
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# Aliases (Shortcuts)
# -------------------------------------
Set-Alias -Name ie -Value Invoke-Explorer
Set-Alias -Name gpsv -Value Get-PSVersion
Set-Alias -Name grep -Value Select-String
Set-Alias -Name gdir -Value Get-MemberInfo
Set-Alias -Name ife -Value Invoke-FuzzyEdit
Set-Alias -Name ifs -Value Invoke-FuzzyScoop
Set-Alias -Name ifh -Value Invoke-FuzzyHistory
Set-Alias -Name cch -Value Clear-CommandHistory
Set-Alias -Name ifg -Value Invoke-FuzzyGitStatus
Set-Alias -Name ifk -Value Invoke-FuzzyKillProcess
Set-Alias -Name ifd -Value Invoke-SetFuzzyDirectory

Set-Alias -Name cat -Value bat -Option AllScope
Set-Alias -Name ls -Value PowerColorLS -Option AllScope

# Functions
# -------------------------------------
function Invoke-Explorer {
    Invoke-Expression "explorer.exe ."
}

function Get-MemberInfo {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Object] $InputObject
    )

    $InputObject | Get-Member
}

function Invoke-SetFuzzyDirectory {
    Get-ChildItem . -Attributes Directory | Invoke-Fzf | Set-Location
}

function Clear-CommandHistory {
    $confirm = (Read-Host "Are you sure to delete the history? (y/n)").ToLower()
    if ($confirm -eq "s" -or $confirm -eq "y") {
        z -clean
        Clear-History
        Remove-Item "$env:APPDATA/Microsoft/Windows/PowerShell/PSReadLine/*"
    }
}

function Get-PSVersion {
    $FinalInfo = ""
    $VersionData = $PSVersionTable
    foreach ($key in $VersionData.Keys) {
        if ($key -eq "PSCompatibleVersions") {
            $FinalInfo += "$($key): $($VersionData[$key] -join ", ")`n"
        }
        else {
            $FinalInfo += "$($key): $($VersionData[$key])`n"
        }
    }
    return $FinalInfo
}
