#!/bin/bash

# This script validates SonarLint installation for different IDEs across various operating systems

# Function to handle SonarLint check for Unix-based systems (macOS/Linux)
check_sonarlint_unix() {
    local ide=$1
    local sonar_path

    case $ide in
        "vscode")
            echo "Checking SonarLint installation for VS Code..."
            sonar_path=$(find ~/.vscode/extensions -name "sonarlint*" 2>/dev/null)
            ;;
        "intellij")
            echo "Checking SonarLint installation for IntelliJ IDEA..."
            sonar_path=$(find ~/.config/JetBrains -name "sonarlint*" 2>/dev/null)
            ;;
        "eclipse")
            echo "Checking SonarLint installation for Eclipse..."
            sonar_path=$(find ~/eclipse/plugins -name "org.sonarlint.eclipse*" 2>/dev/null)
            ;;
        "visualstudio")
            echo "Checking SonarLint installation for Visual Studio (macOS/Linux)..."
            sonar_path=$(find "$HOME/Library/Application Support/VisualStudio" -name "SonarLint.VisualStudio*.dll" 2>/dev/null)
            ;;
        *)
            echo "ERROR: Unsupported IDE specified for Unix-based system."
            exit 1
            ;;
    esac

    if [ -z "$sonar_path" ]; then
        echo "ERROR: SonarLint is not installed for $ide. Please install SonarLint to proceed."
        exit 1
    else
        echo "SonarLint is installed for $ide."
    fi
}

# Function to handle SonarLint check for Windows (using PowerShell)
check_sonarlint_windows() {
    echo "Running SonarLint check on Windows..."
    powershell -Command "
    param([string]$ide)
    switch ($ide) {
        'vscode' {
            \$path = Test-Path -Path \"\$env:USERPROFILE\\.vscode\\extensions\\sonarlint*\"
            if (-not \$path) { Write-Host 'ERROR: SonarLint is not installed for VS Code. Please install SonarLint to proceed.'; exit 1 }
            else { Write-Host 'SonarLint is installed for VS Code.' }
        }
        'intellij' {
            \$path = Test-Path -Path \"\$env:APPDATA\\JetBrains\\sonarlint*\"
            if (-not \$path) { Write-Host 'ERROR: SonarLint is not installed for IntelliJ IDEA. Please install SonarLint to proceed.'; exit 1 }
            else { Write-Host 'SonarLint is installed for IntelliJ IDEA.' }
        }
        'eclipse' {
            \$path = Test-Path -Path \"\$env:USERPROFILE\\eclipse\\plugins\\org.sonarlint.eclipse*\"
            if (-not \$path) { Write-Host 'ERROR: SonarLint is not installed for Eclipse. Please install SonarLint to proceed.'; exit 1 }
            else { Write-Host 'SonarLint is installed for Eclipse.' }
        }
        'visualstudio' {
            \$path = Test-Path -Path \"\$env:LOCALAPPDATA\\Microsoft\\VisualStudio\\SonarLint.VisualStudio*.dll\"
            if (-not \$path) { Write-Host 'ERROR: SonarLint is not installed for Visual Studio. Please install SonarLint to proceed.'; exit 1 }
            else { Write-Host 'SonarLint is installed for Visual Studio.' }
        }
        default {
            Write-Host 'ERROR: Unsupported IDE specified for Windows.'
            exit 1
        }
    }
    " -ide $1
}

# Main function to detect OS and run appropriate checks
main() {
    local ide=$1

    if [ -z "$ide" ]; then
        echo "Usage: $0 [vscode|intellij|eclipse|visualstudio]"
        exit 1
    fi

    if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
        check_sonarlint_unix $ide
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        check_sonarlint_windows $ide
    else
        echo "ERROR: Unsupported operating system."
        exit 1
    fi
}

main $1
