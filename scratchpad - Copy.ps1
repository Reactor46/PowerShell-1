#Properties to expose AccessRights as Array
get-mailbox "RDNJ B*" | Get-MailboxPermission | Select User,AccessRights | FT

#Properties to expose GrantSendOnBehalfTo 
Get-Mailbox -ResultSize 300 | ? {$_.GrantSendOnBehalfTo} | Select DisplayName, GrantSendOnBehalfTo | FT

#Command to get what I need from Get-AdUser
get-aduser -Filter "*" -ResultSetSize 100 -Properties DisplayName, Manager, Office | Select DisplayName, UserPrincipalName, Office, Manager | FT

#Command to get what I need from Get-ADPermission (ExtendedRights holds Send-As)
Get-ADPermission -Identity rxw1401 | ? {$_.ExtendedRights} | Select User,Identity,ExtendedRights | FT

#Command to export Mailbox "Name" field for import to sendas script
Get-Mailbox -ResultSize 100 | Select Name | Export-CSV -Path 'c:\Temp\sendas.csv' -notype

#ISE Setup Commands
RemoteExchange.ps1                                                                                   
add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010                                            
Set-AdServerSettings -ViewEntireForest $True                                 