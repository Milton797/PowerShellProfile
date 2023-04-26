# PowerShell Configuration Profile

## Table of Contents

- [PowerShell Configuration Profile](#powershell-configuration-profile)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
    - [Install Scoop command-line installer](#install-scoop-command-line-installer)
      - [Create some useful aliases](#create-some-useful-aliases)
      - [Install git](#install-git)
      - [Install 'extras' bucket](#install-extras-bucket)
    - [Install a Nerd Font](#install-a-nerd-font)
      - [Add nerd-fonts bucket](#add-nerd-fonts-bucket)
      - [Select a font style you want to use from the available list](#select-a-font-style-you-want-to-use-from-the-available-list)
      - [Install selected font](#install-selected-font)
    - [Install Oh My Posh](#install-oh-my-posh)
    - [Install fzf](#install-fzf)
    - [Install bat](#install-bat)
    - [Install less (suggests by bat)](#install-less-suggests-by-bat)
    - [Install fd](#install-fd)
    - [Install PowerShell Modules](#install-powershell-modules)
      - [Install NuGet](#install-nuget)
      - [Install z, PSFzf, posh-git, PSReadLine, PowerColorLS, Terminal-Icons](#install-z-psfzf-posh-git-psreadline-powercolorls-terminal-icons)
  - [Copy the new configuration on $profile path](#copy-the-new-configuration-on-profile-path)
    - [Online installation method](#online-installation-method)
    - [Clone or download version method](#clone-or-download-version-method)
  - [Last steps](#last-steps)
  - [Available alias](#available-alias)
  - [Scoop alias](#scoop-alias)
    - [PowerShell alias](#powershell-alias)
    - [z Alias](#z-alias)
    - [Shortcuts of Set-PsFzfOption](#shortcuts-of-set-psfzfoption)
    - [Use of external modules (official documentation)](#use-of-external-modules-official-documentation)

## Prerequisites

> **Warning**
>
> - Windows 10 Anniversary Update, Windows Server 2016 or higher
> - Windows Terminal use PowerShell version 5.1 by default, for
> some of the features, we might need a PowerShell 7
> - To see your PowerShell version use $PSVersionTable

- [Windows Terminal](https://github.com/microsoft/terminal "Windows Terminal")
- [PowerShell Core/Desktop](https://microsoft.com/PowerShell "PowerShell Core/Desktop")

## Installation

> **Note**
>
> - You can use other sources than scoop to install the packages
> - **You can ignore installing packages if you already have them**

### Install [Scoop](https://scoop.sh/ "scoop") command-line installer

```bash
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser ; irm get.scoop.sh | iex
```

#### Create some useful aliases

```bash
scoop alias add dump 'Get-ChildItem "~/scoop/buckets/$($args[0])/bucket" -ErrorAction SilentlyContinue |% { echo "$($_.BaseName)" }'
scoop alias add i 'scoop install $args[0]'
scoop alias add r 'scoop uninstall $args[0]'
scoop alias add l 'scoop list'
scoop alias add u 'scoop update $args[0]'
scoop alias add ua 'scoop update *'
scoop alias add ca 'scoop cleanup *'
scoop alias add cc 'scoop cache rm *'
```

#### Install git

```bash
scoop install git
```

#### Install 'extras' bucket

> **Note**
>
> Optional but necessary to have a better app's repository

```bash
scoop bucket add extras
```

### Install a [Nerd Font](https://www.nerdfonts.com/ "Nerd Font")

#### Add nerd-fonts bucket

```bash
scoop bucket add nerd-fonts
```

#### Select a font style you want to use from the available list

```bash
scoop dump nerd-fonts
```

#### Install selected font

In my case CascadiaCode-NF

```bash
scoop install CascadiaCode-NF
```

> **Warning**
>
> - Close the Windows Terminal to refresh the new installed font
> - If the new font doesn't appear try checking the 'Show all fonts' box
> - **Make sure to set the new font in Windows Terminal**

### Install [Oh My Posh](https://ohmyposh.dev/docs/ "Oh My Posh")

```bash
scoop install oh-my-posh
```

### Install [fzf](https://github.com/junegunn/fzf "fzf")

```bash
scoop install fzf
```

### Install [bat](https://github.com/sharkdp/bat "bat")

```bash
scoop install bat
```

### Install [less](https://github.com/gwsw/less "less") (suggests by bat)

```bash
scoop install less
```

### Install [fd](https://github.com/sharkdp/fd "fd")

```bash
scoop install fd
```

### Install [PowerShell Modules](https://www.powershellgallery.com/ "PowerShell Modules")

#### Install NuGet

> **Note**
>
> You need to install 'NuGet' for 5.1 <= PowerShell version < 6.0 (if not just skip)

```bash
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
```

#### Install z, PSFzf, posh-git, PSReadLine, PowerColorLS, Terminal-Icons

```bash
Install-Module -Name z, PSFzf, posh-git, PSReadLine, PowerColorLS, Terminal-Icons -Force -AllowClobber -Scope CurrentUser
```

## Copy the new configuration on $profile path

> **Note**
>
> Select only one of both

### Online installation method

```bash
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Milton797/PowerShellProfile/master/Microsoft.PowerShell_profile.ps1" -OutFile $profile
```

### Clone or download version method

> **Note**
>
> Get sure to change directory to the project path
> before execute the command in your terminal

```bash
Copy-Item -Force -Path ".\Microsoft.PowerShell_profile.ps1" -Destination $profile
```

## Last steps

- Deletes all old installed versions of apps

```bash
scoop ca
```

- Removes all downloaded files from the cache

```bash
scoop cc
```

- Close Windows Terminal and open it again to see the results

> **Note**
>
> - If you see broken icons, check the selected font

## Available alias

## Scoop alias

- **dump:** This alias lists all the packages available in a particular bucket. It takes one argument, the name of the bucket.

- **i:** This alias installs an app. It takes one argument, the name of the app to install.

- **r:** This alias uninstalls an app. It takes one argument, the name of the app to uninstall.

- **l:** This alias lists all the apps installed via Scoop.

- **u:** This alias updates an app or Scoop itself. It takes one argument, the name of the app to update.

- **ua:** This alias updates all installed apps.

- **ca:** This alias deletes all old installed versions of apps. It is recommended to exit any running programs before using this command.

- **cc:** This alias empties the download cache. It removes all downloaded files from the cache.

### PowerShell alias

- **ie:** This alias stands for Invoke-Explorer and opens Windows File Explorer in the current directory.

- **gpsv:** This alias stands for Get-PSVersion and returns information about the PowerShell version that is currently running.

- **grep:** This alias stands for Select-String and searches for a pattern in a string or file.

- **gdir:** This alias stands for Get-MemberInfo and returns information about the members of an object.

- **ife:** This alias stands for Invoke-FuzzyEdit and opens a fuzzy search window to select a file to edit.

- **ifs:** This alias stands for Invoke-FuzzyScoop and opens a fuzzy search window to select a scoop package to install.

- **ifh:** This alias stands for Invoke-FuzzyHistory and opens a fuzzy search window to search through the command history.

- **cch:** This alias stands for Clear-CommandHistory and clears the command history.

- **ifg:** This alias stands for Invoke-FuzzyGitStatus and opens a fuzzy search window to select a file to stage for a git commit.

- **ifk:** This alias stands for Invoke-FuzzyKillProcess and opens a fuzzy search window to select a process to kill.

- **ifd:** This alias stands for Invoke-SetFuzzyDirectory and opens a fuzzy search window to select a directory to change.

- **cat:** This alias stands for bat and displays the contents of a file with syntax highlighting.

- **ls:** This alias stands for PowerColorLS and lists the contents of the current directory with color highlighting.

### z Alias

You can also use z as an alternative to the cd command.

- z [Jump path]

### Shortcuts of Set-PsFzfOption

- **Ctrl+t:** Shortcut to trigger file and directory selection

- **Ctrl+r:** Shortcut to trigger history selection

- **Shift+Tab:** Shortcut to replace the standard tab completion

- **Alt+d:** Shortcut to opens a fuzzy search window to select a directory to change

### Use of external modules (official documentation)

- <https://github.com/junegunn/fzf#usage>
- <https://github.com/sharkdp/bat#how-to-use>
- <https://github.com/gwsw/less>
- <https://github.com/sharkdp/fd#how-to-use>
- <https://github.com/badmotorfinger/z#examples>
- <https://github.com/kelleyma49/PSFzf#usage>
- <https://github.com/dahlbyk/posh-git#using-posh-git>
- <https://github.com/PowerShell/PSReadLine#usage>
- <https://github.com/gardebring/PowerColorLS#example-usage>
- <https://github.com/devblackops/Terminal-Icons#usage>
- <https://ohmyposh.dev/docs>
