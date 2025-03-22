# Users, Users, Users

One of the most common objects most of us will interact with are user accounts in Active Directory. So let's talk a little about that
# Find a User

The cmdlet to load a user account into memory is `Get-ADUser`

By Default, `Get-ADUser` works by just passing a username as an object

``` powershell
# Find an AD user with the username mason
Get-ADUser mason
```

Gives the result:

```
DistinguishedName : CN=Mason Feuhrer,OU=Active Users,OU=Domain Users,DC=omicr0n,DC=com
Enabled           : True
GivenName         : Mason
Name              : Mason Feuhrer
ObjectClass       : user
ObjectGUID        : 776c1f2a-f3f2-4d08-96e9-1878fe2fd0d1
SamAccountName    : mason
SID               : S-1-5-21-2850356459-7477480-345521354-1107
Surname           : Feuhrer
UserPrincipalName : mason@omicr0n.com
```

# Update a User

The cmdlet to update a user account is `Set-ADUser`

`Set-ADUser` requires a user to be referenced, or else no action will be taken. You can select the user either by passing a username:
```powershell
Set-ADUser -Identity mason -Replace @(url="masonfeuhrer.com")
```
or by passing an object:
```powershell
# You can either use a variable to get the user and then set the property:
$user = Get-ADUser mason
Set-ADUser $user -Replace @(url="masonfeuhrer.com")

# Or you can use the pipeline:
Get-ADUser mason | Set-ADUser -Replace @(url="masonfeuhrer.com")
```

# Create a User

The cmdlet to create a new user account is is `New-ADUser`

Creating a new user in Active directory only requires passing a name, but that only creates a user object, and assigns no Universal Principal Name, Display Name or Password. Effectively, you have a user that can't login.

```
New-ADUser testguy
```

results in:

```
DistinguishedName : CN=testguy,OU=Domain Users,DC=omicr0n,DC=com
Enabled           : False
GivenName         : 
Name              : testguy
ObjectClass       : user
ObjectGUID        : db291867-b90c-44cc-b254-27e328c98f36
SamAccountName    : testguy
SID               : S-1-5-21-2850356459-7477480-345521354-13291
Surname           : 
UserPrincipalName : 
```

To use this cmdlet a little more effectively, we should include some properties so that our user can be more easily recognized and actually log in to systems:

```powershell
New-Aduser -SamAccountName "mason-ergos" -GivenName "Mason" -Surname "Feuhrer" -Name "Mason Feuhrer" -Office "Austin" -Enabled $true
```

The above command gives a better structured user account, and gives us more control to define the object being created. The user object also now looks like this when we perform `Get-ADUser`

```
DistinguishedName : CN=Mason Feuhrer,OU=Domain Users,DC=omicr0n,DC=com
Enabled           : True
GivenName         : Mason
Name              : Mason Feuhrer
ObjectClass       : user
ObjectGUID        : 8a8e8d21-ebbf-4af9-9238-05cac0dd50a4
SamAccountName    : mason-ergos
SID               : S-1-5-21-2850356459-7477480-345521354-13293
Surname           : Feuhrer
UserPrincipalName : 
```

We can also structure our properties in an array, and pass that data as a whole. This method lends itself to automation as we can start to perform actions like reading a list of users from a CSV and setting AD attributes based on those values. 

```powershell
# First define the parameters
$userParams = @{
	Name = "Mason Feuhrer"
    GivenName = "Mason"
    Surname = "Feuhrer"
    SamAccountName = "mason-ergos"
    Office = "Austin"
    Enabled = $true
}

# And then use those Parameters to create the user account
New-ADUser @userParams
```