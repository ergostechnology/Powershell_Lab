# AI: Not Quite Our New Overlords

We've all asked ChatGPT to come up with a limerick or on the fly at least once or twice... right? Just me? Whatever. Well, it turns out that AI can be leveraged and utilized for more than just little whimsical quips and asides.

AI, while an incredibly powerful tool is not without its faults. "Computers don't blunder" doesn't really work when we're talking artificial intelligence due to the very nature of the intelligence being, well, artificial. AI only knows about what it is trained to know until the model ingests new information and that's not something we're going to be diving into here. 
## Privacy

This is probably the most serious section, so let's get it out of the way. We absolutely [NEVER, and The Rock means NEVVVVVVER](https://looptube.io/?videoId=9F2iVzVGm1w&start=0.4062499999999999&end=5.59191176470588&rate=1), want to submit personally identifiable information that could be traced back to the company. Plain and simple, there's no room for grey (gray) areas here. I will typically substitute "ERGOS" with "ACME" in code that I work with; find/replace is your best friend here. 

Now that we have that out of the way and we can all agree to not leak our deepest, darkest secrets to the machines, we can move on.
## The "Main" Models

1. OpenAI ChatGPT: https://chat.openai.com
2. Microsoft Copilot: https://www.microsoft365.com/
3. Google Gemini: https://gemini.google.com/
4. ClaudeAI: https://claude.ai/

At the core, all of these models are designed to do the same thing, learn. Let's see an example prompt and response from each of the models mentioned. For simplicity we will use the same prompt across all models.
### Prompt
```
Can you write me a Powershell script that will export the Windows System log to C:\ACME\System.evtx?
```
### OpenAI ChatGPT
```Powershell
$ExportPath = "C:\ACME\System.evtx"

# Ensure the directory exists
$ExportDirectory = Split-Path -Path $ExportPath -Parent
if (!(Test-Path -Path $ExportDirectory)) {
    New-Item -ItemType Directory -Path $ExportDirectory -Force | Out-Null
}

# Export the System event log
wevtutil epl System $ExportPath

Write-Output "System log exported to $ExportPath"

```

This script:

1. Defines the export path (`C:\ACME\System.evtx`).
2. Ensures the target directory exists, creating it if necessary.
3. Uses `wevtutil epl` to export the System log.
4. Outputs a confirmation message.

Let me know if you need any modifications! 🚀

### Microsoft Copilot
```Powershell
# Define the path where the log will be exported
$exportPath = "C:\ACME\System.evtx"

# Export the System log to the specified path
Export-EventLog -LogName System -Path $exportPath

Write-Host "System log has been exported to $exportPath"
```

 This script sets the export path and uses the `Export-EventLog` cmdlet to export the System log to the specified location. If you have any questions or need further assistance, feel free to ask!

### Google Gemini
```Powershell
# Define the output path
$OutputPath = "C:\ACME\System.evtx"

# Check if the output directory exists, create if not
$OutputDir = Split-Path -Path $OutputPath -Parent
if (!(Test-Path -Path $OutputDir -PathType Container)) {
    try {
        New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    }
    catch {
        Write-Error "Failed to create directory: $($OutputDir). Error: $($_.Exception.Message)"
        return # Exit the script if directory creation fails
    }
}

# Export the System log
try {
    Get-WinEvent -LogName System | Export-WinEvent -Path $OutputPath -Force
    Write-Host "System log exported successfully to: $OutputPath"
}
catch {
    Write-Error "Failed to export System log. Error: $($_.Exception.Message)"
}
```

**Explanation and Important Considerations:**

1. **Output Path:**
    - The `$OutputPath` variable defines the location where the System log will be saved. Ensure that the "C:\ACME" directory exists or that the script has the permissions to create it.
2. **Directory Creation:**
    - The script uses `Split-Path` to extract the directory path from `$OutputPath`.
    - `Test-Path` checks if the directory exists.
    - `New-Item` creates the directory if it doesn't exist. The `-Force` parameter suppresses any confirmation prompts.
    - A `try...catch` block handles potential errors during directory creation.
3. **Exporting the Log:**
    - `Get-WinEvent -LogName System` retrieves all events from the System log.
    - `Export-WinEvent -Path $OutputPath -Force` exports the retrieved events to the specified file. The `-Force` parameter overwrites any existing file with the same name.
    - A `try...catch` block handles potential errors during the export process, such as insufficient permissions or file access issues.
4. **Error Handling:**
    - The script includes `try...catch` blocks to handle potential errors during directory creation and log export. This ensures that the script doesn't terminate unexpectedly and provides informative error messages.
5. **Permissions:**
    - Running this script might require administrator privileges, especially if you're writing to a protected location like the root of the C drive. Right-click on PowerShell and select "Run as administrator" to ensure you have the necessary permissions.
6. **File Size:**
    - System logs can be quite large. Be aware of the potential file size when exporting, and ensure you have sufficient disk space.
7. **Overwriting existing files:**
    - The -force parameter in the Export-WinEvent cmdlet will overwrite any existing files that share the same name as the output file. If you do not want this behavior, remove the -force parameter.
8. **Alternative directory creation:**
    - Instead of using try catch for directory creation, you could also use if(!(Test-Path -Path $OutputDir -PathType Container)){mkdir $OutputDir} which is often more readable.
### ClaudeAI
```Powershell
# Script to export Windows System log to C:\ACME\System.evtx

# Create the destination directory if it doesn't exist
if (-not (Test-Path -Path "C:\ACME" -PathType Container)) {
    New-Item -Path "C:\ACME" -ItemType Directory -Force
    Write-Host "Created directory: C:\ACME"
}

# Export the System event log
try {
    wevtutil epl System "C:\ACME\System.evtx"
    Write-Host "Successfully exported System event log to C:\ACME\System.evtx"
} catch {
    Write-Error "Failed to export System event log: $_"
    exit 1
}

# Verify the export was successful
if (Test-Path -Path "C:\ACME\System.evtx" -PathType Leaf) {
    $fileInfo = Get-Item "C:\ACME\System.evtx"
    Write-Host "Export verified. File size: $($fileInfo.Length) bytes"
} else {
    Write-Error "Export verification failed. File not found at C:\ACME\System.evtx"
    exit 1
}
```

You can run this script in PowerShell to export the Windows System event log to the specified location. The script:

1. Creates the C:\ACME directory if it doesn't exist
2. Uses the wevtutil command to export the System log
3. Verifies that the export was successful and reports the file size

You'll need administrator privileges to run this script successfully since accessing event logs typically requires elevated permissions.

---
### Bonus Prompt
```
Is there a more efficient way than the following code snippet to export the System log to an evtx file in powershell? 

`wevtutil epl System "C:\Export\System.evtx"` 

I would like to avoid using an external program wevtutil.exe if possible.
```

### "Powershell Experts Model" via OpenAI
```Powershell
# Define the export directory and file
$exportDir = "C:\ACME"
$exportFile = "$exportDir\System.evtx"

# Ensure the directory exists
if (-not (Test-Path -Path $exportDir)) {
    New-Item -Path $exportDir -ItemType Directory -Force | Out-Null
}

# Export the System event log
$logSession = New-Object System.Diagnostics.Eventing.Reader.EventLogSession
$logSession.ExportLog("System", [System.Diagnostics.Eventing.Reader.PathType]::LogName, "*", $exportFile)
Write-Host "System log exported to: $exportFile"
```

 Yes! You can use PowerShell's built-in `Export-EventLog` or `Save-EventLog` (depending on your Windows version) instead of `wevtutil`. However, these cmdlets work with classic event logs, not the newer Windows Event Log system.

For modern logs (like "System"), use `New-EventLogSession` with `Get-WinEvent` to export logs programmatically.

Alternative using `Get-WinEvent` and `.SaveChanges()`
You can use the `System.Diagnostics.Eventing.Reader.EventLogSession` class to export logs:
### Explanation:

- `ExportLog` exports the "System" log.
- `"*"` is a query filter (can be customized).
- `"C:\Export\System.evtx"` is the output file.

This approach eliminates dependency on `wevtutil.exe` and keeps everything within PowerShell.

Would you like help customizing the export further, such as filtering events by time range or event ID?

## Hands On

1. Review the output from each AI model. 
	1. Does the response make sense? 
	2. Does it match the code provided?
2. Attempt to execute each code block and review the results.
	1. Did all the of the provided samples work?
	2. If any of the samples didn't work, why not? 
3. How can the provided code samples be used in production scripts?
---
![Thanks For Coming]([https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif](https://media.tenor.com/QTtnvTd5RXwAAAAC/thats-it-there-you-go.gif))

# Q & A Time
You've got questions, I might have answers.
