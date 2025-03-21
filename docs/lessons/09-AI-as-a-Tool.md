# AI: Not Quite Our New Overlords

We've all asked ChatGPT to come up with a limerick or on the fly at least once or twice... right? Just me? Whatever. Well, it turns out that AI can be leveraged and utilized for more than just little whimsical quips and asides.

AI, while an incredibly powerful tool is not without its faults. "Computers don't blunder" doesn't really work when we're talking artificial intelligence due to the very nature of the intelligence being, well, artificial. AI only knows about what it is trained to know until the model ingests new information and that's not something we're going to be diving into here. 

## Privacy

This is probably the most serious section, so let's get it out of the way. We absolutely never, and The Rock means NEVVVVVVER, want to submit personally identifiable information that could be traced back to the company. Plain and simple, there's no room for grey (gray) areas here. I will typically substitute "ERGOS" with "ACME" in code that I work with; find/replace is your best friend here. 

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

1. OpenAI ChatGPT
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

2. Microsoft Copilot
```Powershell
# Define the path where the log will be exported
$exportPath = "C:\ACME\System.evtx"

# Export the System log to the specified path
Export-EventLog -LogName System -Path $exportPath

Write-Host "System log has been exported to $exportPath"
```

3. Google Gemini
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

4. ClaudeAI
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

5. Bonus, "Powershell Experts Model"
```Powershell
$logSession = New-Object System.Diagnostics.Eventing.Reader.EventLogSession
$logSession.ExportLog("System", [System.Diagnostics.Eventing.Reader.PathType]::LogName, "*", "C:\ACME\System.evtx")

```
