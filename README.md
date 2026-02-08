# IT-Support-Automation
PowerShell and Bash scripts used for streamlining help desk tasks.

##Table of Contents
* [Script: Get-SystemInfo.ps1](#-featured-script-get-systeminfo-ps1)
* [Script: Invoke-DiskMaintenance.ps1](#-maintenance-script-invoke-diskmaintenance-ps1)
* [Network Health Tester (Test-NetworkHealth.ps1)](#-network-health-tester-test-networkhealth-ps1)
* [Technical Deep-Dive: Console Output Logic](#-technical-deep-dive-console-output-logic)
* [Usage Instructions]
(#-how-to-use)
* [Planned Updates]
(#-planned-updates)
--------------------------------------------------------------------------------------------------------------------------------
## Featured Script: Get-SystemInfo.ps1
This script provides hardware, network, and storage data. It is meant to be run at the start of a support call to gather critical system facts quickly without navigating through the GUI.

###Technical Deep-Dive: Console Output Logic
During the development of this script, I encountered a specific **PowerShell Pipeline formatting conflict** that prevented data from displaying in the terminal.

**The Problem:** When running 'Get-ComputerInfo', 'Get-NetIPAddress', and 'Get-Volume' sequentially, the network and disk info weren't appearing in the console, even though the commands were technically correct.

**The Investigation:** I researched the PowerShell output buffer. I discovered that PowerShell establishes a table format based on the *first* object it receives (System Info). Because the following network and volume data headers did not match the inital table schema, the shell suppressed the output to the console.

**The Solution:** 
I implemented the '| Out-Host' command at the end of each 'Get...' command. This forces the pipeline to "clear" the display buffer and render a fresh, independent table for each data object, ensuring the technician sees all requested information.

## Maintenance Script:
Invoke-DiskMaintenance.ps1
This script automates the cleanup of temporary files for a single user profile to resolve lag and free up storage space.

## Recycle Bin Automation: Integrated Clear-RecycleBin with the -Force parameter to bypass manual confirmation prompts, ensuring a fully automated "one-click" experience.

### Key Features:
* **Environment Variable Targeting:** Uses '$env:TEMP' to dynamically locate the active user's temporary folder regardless of their username.
* **Safety First:** Includes '-ErrorAction SilentlyContinue' to ensure the script continues running even if specific files are currently locked by open applications.
* **Calculated Results:** Provides an immediate feedback loop by calculating the difference in disk space before and after the cleanup.

> **Use Case:** This is the "First Response" tool for a user reporting a slow workstation. It targets the most common area for "junk" file accumulation without requiring administrative elevation to other user profiles.

## Network Health Tester: Test-NetworkHealth.ps1A diagnostic tool that isolates where a network connection is failing by testing three specific hops.
### Why this is effective:
* **Automated Gateway Detection:** Instead of hardcoding an IP, the script finds the local router's address using `Get-NetRoute`.
* **Layered Isolation:** It prevents "false alarms" by ensuring the local hardware is working before checking the internet.
* **Rapid Triage:** Designed for Help Desk technicians to run via remote shell to identify if a ticket should be escalated to the Network Team or the ISP.

## Instructions
1. *Download:* Copy the code.
2. *Open PowerShell:* Launch PowerShell with Administrative privileges.
3. *Execution Policy:* If scripts are blocked by system security, run:
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
4. *Run:* Execute the script by typing .\[filename from step 1].

---

