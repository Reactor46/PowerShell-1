# FileName:  ps_FindSendAs.ps1
#----------------------------------------------------------------------------
# Script Name: [Find Mailboxes with Send-As permissions]
# Created: [07/27/2017]
# Author: Rob Wolsky
# Company: NovaTech Group
# Email: rob.wolsky@ntekcloud.com
# Requirements: CSV file containing mailboxes to search by CN or UPN
# Requirements: List relevant identities in c:\Temp\sendas.csv (header Name)
# Requirements: 
# Keywords:
#-----------------------------------------------------------------------------
# Purpose: Investigation of Send-As permissions for Office 365 migration project
#-----------------------------------------------------------------------------
# REVISION HISTORY
#-----------------------------------------------------------------------------
# Date: [07/27/2017]
# Time: [1051]
# Issue: Update for IFF. 
# Solution:
#
#-----------------------------------------------------------------------------
# Script Body - Main script section
#-----------------------------------------------------------------------------


#Populate Identity Array
[Array] $identities = Import-Csv C:\temp\sendas.csv

#Initialize array variable used to store records for output

$arrResults = @()

ForEach ($mailbox in [Array] $identities)
{

#Process mailbox for AD Permissions data
Get-ADPermission -Identity $mailbox.Name | ? {($_.ExtendedRights | Out-String).Contains("Send")} | Select User,Identity,ExtendedRights | % {

    $objEX = New-Object -TypeName PSObject

    $objEX | Add-Member -MemberType NoteProperty -Name Mailbox -Value $mailbox.Name

    $objEX | Add-Member -MemberType NoteProperty -Name User -Value $_.User

    $objEX | Add-Member -MemberType NoteProperty -Name Identity -Value $_.Identity

    $objEX | Add-Member -MemberType NoteProperty -Name ExtendedRights -Value  $_.ExtendedRights

    $arrResults += $objEX 

    } 
}

$arrResults | Out-GridView
#$arrResults | Export-Csv -Path 'C:\Temp\SENDAS_RESULT.csv' -NoTypeInformation 

#-----------------------------------------------------------------------------
# END OF SCRIPT: [Find Mailboxes with Send-As permissions]
#-----------------------------------------------------------------------------
#>