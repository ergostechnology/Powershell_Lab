# Around the World

Conditionals are great for evaluating single items, but what happens when you have a group or collection of objections assigned to a variable, and you need to evaluate something about each object inside the collection? 

Iterating over a group of objects is called "looping", and it really helps with performing an action or set of actions across multiple items in a set. 

Following on our previous example, what if we don't already know the username of the account we are looking for, but we do know their first or last name?

In this situation we can use a loop to go through the list of user accounts, and evaluate which account(s) share a specific first name:

``` powershell
# First, let's get all of the users in the 'Domain Users' OU
# To accomplish this, we'll need to grab the Distinguished Name of the OU, but we can get this easily using PowerShell

$OU =(Get-ADOrganizationalUnit -Filter {name -like "Domain Users"}).DistinguishedName

# With the OU assigned to a variable, we can use this to search Active Directory for a group of users in that OU specifically. We'll assign a variable to this for easy use

$DomainUsers = Get-ADUser -SearchBase $OU -Filter *

# Now, we have our data. Let's start our loop:

foreach ($user in $DomainUsers) {
	# Any code we put here applies to each $user object individually
	# Let's see which users have a first name of Mason

	if ($user.GivenName -match "Mason") {
		# If the user's Given name is a match to the string "Mason", write to the host
		Write-Host "Found $($user.SamAccountName) with Given Name Mason"
	}
}

```

While writing to the console may not be much, this is just an example. 

Using loops, you can iterate through a directory to do things like update phone numbers across user accounts, change employee titles based off of e-mail addresses, or even add and remove users to groups, all without having to look for each account one at a time. 