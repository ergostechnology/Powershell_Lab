# This script will import user data from users.csv and create those users in Active Directory.
import-module ActiveDirectory
$userData = Import-Csv -Path .\lab-prep\users.csv

$domain = Get-ADDomain

$ouDN = "OU=labUsers,$($domain.DistinguishedName)"

if (Get-ADOrganizationalUnit -Filter 'Name -like "labUsers"'| Where-Object { $_.DistinguishedName -eq $ouDN}) {
    Write-Host "[INFO] OU labUsers already exists."
} else {
    Write-Host "[INFO] Creating OU labUsers."
    New-ADOrganizationalUnit -Name "labUsers" -Path $domain.DistinguishedName
}

foreach ($user in $userData) {
    # $password = ConvertTo-SecureString -String $user.Password -AsPlainText -Force
    $userParams = @{
        Name = "$($user.FirstName) $($user.LastName)"
        GivenName = $user.FirstName
        Surname = $user.LastName
        SamAccountName = "$($user.FirstName[0])$($user.LastName)"
        EmailAddress = "$($user.FirstName)-$($user.LastName)@$($domain.DNSRoot)"
        UserPrincipalName = "$($user.FirstName[0])$($user.LastName)@$($domain.DNSRoot)"
        # AccountPassword = $password
        Enabled = $true
        Path = $ouDN
    }
    try {
        New-ADUser @userParams
    }
    catch {
        Write-Host "[ERROR] Failed to create user $($user.FirstName) $($user.LastName)."
    }
   
}