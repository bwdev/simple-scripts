param([string]$outFileName, [string[]]$groups)
Import-Module ActiveDirectory
$fileName = "./$(Get-Date -Format 'yyyyMMdd')_" + $outFileName + ".txt"

$output = ""

foreach ($group in $groups) {    
    $table = (Get-ADGroupMember -identity $group -Recursive | Get-ADUser -Property DisplayName | Sort-Object DisplayName)

    Write-Host $group
    $table | Format-List -Property Name, ObjectClass

    if ($outFileName) {
        $group >> $fileName
        Get-ADGroupMember -identity $group -Recursive | Get-ADUser -Property DisplayName | Sort-Object DisplayName | Select Name, ObjectClass >> $fileName
    }
}
