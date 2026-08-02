
# Path to your usernames text file
# Replace username and company with correct info
$usernames = Get-Content "C:\Users\username\OneDrive - company\Documents"



# Loop through each username and check if it exists in Active Directory

foreach ($username in $usernames) {

    $user = Get-ADUser -Filter {SamAccountName -eq $username} -ErrorAction SilentlyContinue

    if ($user) {

        Write-Host "$username exists in Active Directory."

    } else {

        Write-Host "$username does NOT exist in Active Directory."

    }

}



$domainName = "company.se"

 # Get members of the specified AD group and retrieve user details
Get-ADGroup -Server $domainName -Identity "ara-3a9467331b7a" |
    Get-ADGroupMember -Server $domainName |
    ForEach-Object {
        Get-ADUser $_ -Server $domainName -Properties SamAccountName, GivenName, Surname, Mail
    } |
    Format-Table SamAccountName, GivenName, Surname, Mail
	
	
	
	
	
	
	

