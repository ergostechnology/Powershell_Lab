# If This, Then That

One of the most common tasks in any automation is evaluating conditionals. 

Without any sort of condition, a script or command has no guard rails and would impact every item returned. 

## If What?

The basic conditional is an `if` statement. `If` asks the question "does this criteria fit?"

Let's take a look at an imaginary user:

```powershell
### This user does not actually exist
$user = Get-ADUser mason

### Use an if statement to determine if the account exists
if ($user) {
	Write-Host "The user $($user.name) exists!"
}
```

In the above code, we first search Active Directory for a user with the username mason, and assign the results of that search to the variable $user

In the second statement, we use `if` to begin an evaluation. The data between the parenthesis () is the data we want to evaluate. In this case, we do not need an evaluator, as the we only need to know if the account exists. By default `if ($variable)` is checking to see if the variable exists (and returns $true) or if it does not exists (which returns $null).

If the evaluation is true, the statement allows for the cmdlet in the script block (designated by { } ) to execute. If the evaluation fails, and the user does not exist, the script continues on without performing the functions. 

## What *else*?

`Else` and `elseif` add more functionality to a basic `if` condition. Consider a situation where you want to perform one action if the condition exists, but you want to perform a separate action if the condition is not met. Continuing on with the example from above

```powershell
### This user does not actually exist
$user = Get-ADUser mason

### Use an if statement to determine if the account exists
if ($user) {
	Write-Host "The user $($user.name) exists!"
} else {
	Write-Host "The user account was not found!"
}
```

Now, if we do not find the user account, we can print to the terminal that there is no account found. That text will *only* be displayed if no user account exists. 

To extend this further, what if you had more than 2 possible states for a condition to exist? Perhaps there are multiple users with the username mason (potentially an account named mason-admin could be found). You could look not just at the existence of an object or variable, but take action based on how many objects were returned:

```powershell
### This user does not actually exist
$user = Get-ADUser mason

### Use an if statement to determine if the account exists
if ($user.count -eq 1) {
	Write-Host "The user $($user.name) exists!"
} elseif ($user.count -gt 1) {
	Write-Host "Multiple user accounts were found: "
	$user.name
} else {
	Write-Host "The user account was not found!"
}
```