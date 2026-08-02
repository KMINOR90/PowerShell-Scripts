#PowerShell script to get information off of AD, Need test Excel sheet, 

Get-Process C:\Users\username> Get-ADGroup -Server company.se  ara-886f34 |Get-ADGroupMember -Server ericsson.se |select -ExpandProperty name | %{
>>     Get-ADUser $_ -Server company.se -Properties samaccountname,givenname,surname, mail
>> } |Format-Table samaccountname,givenname,surname, mail

samaccountname givenname    surname mail


Get-Process C:\Users\username> $domainName = "company.se"
Get-Process C:\Users\username> Get-ADGroup -Server company.se  ara-886f34ca937a|Get-ADGroupMember -Server $domainName |select -ExpandProperty name | %{
>>     Get-ADUser $_ -Server $domainName -Properties samaccountname,givenname,surname, mail
>> } |Format-Table samaccountname,givenname,surname, mail

#Script to get useraccount, Name, and email from active directory

  Get-Process C:\Users\username> $domainName = "company.se"
>>
>> # Get members of the specified AD group and retrieve user details
>> Get-ADGroup -Server $domainName -Identity "ara-886f34ca937a" |
>>     Get-ADGroupMember -Server $domainName |
>>     ForEach-Object {
>>         Get-ADUser $_ -Server $domainName -Properties SamAccountName, GivenName, Surname, Mail
>>     } |
>>     Format-Table SamAccountName, GivenName, Surname, Mail
>>

#This script provides list of user name in Groups of Active directory
Get-Process C:\Users\username> Get-ADGroup -Server Company.se  ara-886f3|Get-ADGroupMember -Server ericsson.se |select name

