#!/bin/bash

# Unified script to check if SonarLint is installed for various IDEs

# Function to display an error message and exit
function error_exit {
    echo "ERROR: $1"
    exit 1
}

# Function to check SonarLint installation for different IDEs
check_sonarlint() {
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
            echo "Checking SonarLint installation for Visual Studio..."
            sonar_path=$(find "$LOCALAPPDATA\\Microsoft\\VisualStudio" -name "SonarLint.VisualStudio*.dll" 2>/dev/null)
            ;;
        *)
            error_exit "Unsupported or unspecified IDE. Please use one of: vscode, intellij, eclipse, visualstudio."
            ;;
    esac

    if [ -z "$sonar_path" ]; then
        error_exit "SonarLint is not installed for $ide. Please install SonarLint to proceed."
    else
        echo "SonarLint is installed for $ide."
    fi
}

# Check if an IDE was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 [vscode|intellij|eclipse|visualstudio]"
    exit 1
fi

# Run the SonarLint check for the specified IDE
check_sonarlint $1
