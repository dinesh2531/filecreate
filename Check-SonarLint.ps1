# Check-SonarLint.ps1
param([string]$ide)

Write-Host "Validating SonarLint installation for $ide..."

switch ($ide) {
    "vscode" {
        $path = Test-Path -Path "$env:USERPROFILE\.vscode\extensions\sonarlint*"
        if (-not $path) {
            Write-Host "ERROR: SonarLint is not installed for VS Code. Please install SonarLint to proceed."
            exit 1
        } else {
            Write-Host "SonarLint is installed for VS Code."
        }
    }
    "intellij" {
        $path = Test-Path -Path "$env:APPDATA\JetBrains\sonarlint*"
        if (-not $path) {
            Write-Host "ERROR: SonarLint is not installed for IntelliJ IDEA. Please install SonarLint to proceed."
            exit 1
        } else {
            Write-Host "SonarLint is installed for IntelliJ IDEA."
        }
    }
    "eclipse" {
        $path = Test-Path -Path "$env:USERPROFILE\eclipse\plugins\org.sonarlint.eclipse*"
        if (-not $path) {
            Write-Host "ERROR: SonarLint is not installed for Eclipse. Please install SonarLint to proceed."
            exit 1
        } else {
            Write-Host "SonarLint is installed for Eclipse."
        }
    }
    "visualstudio" {
        $path = Test-Path -Path "$env:LOCALAPPDATA\Microsoft\VisualStudio\SonarLint.VisualStudio*.dll"
        if (-not $path) {
            Write-Host "ERROR: SonarLint is not installed for Visual Studio. Please install SonarLint to proceed."
            exit 1
        } else {
            Write-Host "SonarLint is installed for Visual Studio."
        }
    }
    default {
        Write-Host "ERROR: Unsupported IDE specified."
        exit 1
    }
}
