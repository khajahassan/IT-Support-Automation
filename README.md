# IT-Support-Automation
PowerShell and Bash scripts used for streamlining help desk tasks.

##Table of Contents
* [Script: Get-SystemInfo.ps1](#-featured-script-get-systeminfo-ps1)
* [Script: Invoke-DiskMaintenance.ps1](#-maintenance-script-invoke-diskmaintenance-ps1)
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

### Key Features:
* **Environment Variable Targeting:** Uses '$env:TEMP' to dynamically locate the active user's temporary folder regardless of their username.
* **Safety First:** Includes '-ErrorAction SilentlyContinue' to ensure the script continues running even if specific files are currently locked by open applications.
* **Calculated Results:** Provides an immediate feedback loop by calculating the difference in disk space before and after the cleanup.

> **Use Case:** This is the "First Response" tool for a user reporting a slow workstation. It targets the most common area for "junk" file accumulation without requiring administrative elevation to other user profiles.

## Instructions
1. *Download:* Copy the code from Get-SystemInfo.ps1.
2. *Open PowerShell:* Launch PowerShell with Administrative privileges.
3. *Execution Policy:* If scripts are blocked by system security, run:
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
4. *Run:* Execute the script by typing .\Get-SystemInfo.ps1.

---

## Updates in the |-line (Get it? | = pipe, so |-line = pipeline)
- [ ] *Disk Maintenance Tool:* Automated clearing of %TEMP% folders and system logs to resolve performance issues.
- [ ] *Network Connectivity Tester:* A script to ping the local gateway and external DNS to isolate connection drops.
