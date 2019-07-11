param(
    [Parameter(Mandatory=$true)][string]$user,
    [string]$group = "Administrators"
)
$ErrorActionPreference= 'silentlycontinue'
$ObjGroupMember = $null

Try {
    $ObjGroupMember = Get-LocalGroupMember -Group $group -Member $user
}
Catch [Microsoft.PowerShell.Commands.PrincipalNotFoundException] {
    Exit
}

If ($ObjGroupMember) {
    Remove-LocalGroupMember -Group $group -Member $user
}