# Software Prerequisites

While most of this lab uses native PowerShell and the examples can be followed using PowerShell ISE, there are more modern tools that provide a better experience all around. 

## Visual Studio Code

Visual Studio Code is a modern, modular development environment maintained by Microsoft that is completely free to use. The software is cross-platform and can be run on any system. 

Through its expansive plugin library, VS Code is adaptable to almost any programming or scripting language, and can even connect remotely to many types of endpoints for easier development, debugging, or general script running. 

You can find the latest versions of VS Code for download at [https://code.visualstudio.com/](https://code.visualstudio.com/)

On Windows 10 and newer, you can also install this using the package manager winget:

```powershell
winget install Microsoft.VisualStudioCode
```
## Visual Studio Code PowerShell Extension

With VS Code installed, you can now install extensions. 

To see your installed extensions, and search for new ones, open VS Code and look for the Extensions icon on the left panel (Ctrl+Shift+X).

You will want to be certain that the PowerShell extension published by Microsoft is installed and activated.

## Git for Windows

Git is the standard when it comes to Source Control. While we won't be going in depth with Git, it will be helpful for some portions of the lab (such as cloning and updating the repository as it improves.)

You can find the latest versions of git at [https://git-scm.com/](https://git-scm.com/)

On Windows 10 and newer, you can also install this using the package manager winget:

```powershell
winget install --id Git.Git -e --source winget
```

## A copy of this repository

It'll be easiest to follow along if you have access to the materials. 

You can find the repository here: https://github.com/ergostechnology/Powershell_Lab

Of if you want to follow the spirit of the platform, open a terminal:

```powershell
# Make sure you are in your home directory
cd ~
# Create a projects directory if you don't have one
mkdir projects
# Move on in to that
cd projects
# Clone the project
git clone https://github.com/ergostechnology/Powershell_Lab
```

If you are already familiar with using git at the command line, you can skip to the end and just:

```powershell
git clone https://github.com/ergostechnology/Powershell_Lab
```
