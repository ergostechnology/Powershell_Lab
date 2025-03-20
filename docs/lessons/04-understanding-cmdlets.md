# What the Heck is a Cmdlet?

There are a few words and concepts that you will want to understand before we go on. Time for the boring stuff.
## cmdlets 

cmdlets are the verbs or action names given to the operators in PowerShell. The start of any action will begin with a cmdlet.

Try running the following cmdlet

```powershell
Update-Help
```

Nice, you fell for it. Now the local PowerShell help files on your computer should be updated with the latest information. 

## variables

Variables are common in just about every programming language, and PowerShell is no different. 

PowerShell variables start with a dollar sign ($) and can contain strings, objects, numbers, arrays, even results of functions. 

```powershell
$name = "Steve Buscemi" # Sets the variable $name to the string "Steve Buscemi".

$array = @('1','2','3') # Creates an array with the the values 1, 2, and 3.

$processes = Get-Process # Stores a .NET object with the results of the Get-Process cmdlet into the variable $processes
```

## properties


Properties are the parts that define an object. For instance, a user account has properties like username, e-mail address, and password. 

In object oriented programming, a property can be addressed by calling and object, and then using dot (.) notation to select specific properties of an object.

```powershell
$processes = Get-Process # Store the list of running processes

$processes.ProcessName # List all of the process names found in the variable
```

## The Pipeline

PowerShell makes use of a concept called "The Pipeline", which is represented by using the ` | ` character. This allows for the results of one function to be "piped" into the next cmdlet or function.

For example, you can grab the list of running processes on a computer, and then format that data for easier viewing by using the Format-Table function:

```powershell
Get-Process | Format-Table
```

This can be handy if you don't want to store something in a variable and then retrieve the data later.

The pipeline also allows for continued used. Following our example above, you could pick just the first ten processes, and then format the output:

```powershell
Get-Process | Select-Object -First 10 | Format-Table
```

