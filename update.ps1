clear-host
write-host "### INIZIO AGGIORNAMENO"

#Pulisco la directory
Get-ChildItem -Path . -Recurse |
Where-Object {
    $_.FullName -notlike "*\providers\*" -and
    $_.Extension -notin ".txt"
} | Remove-Item -Recurse -Force


#Clono il repository
$gitProcess = Start-Process -FilePath "git" `
    -ArgumentList "clone https://github.com/Rfusar/editorConfig.git EditorConfig" `
        -NoNewWindow -PassThru
$gitProcess.WaitForExit()


#Pulizia finali
get-childItem -Path ".\EditorConfig\*" -Recurse | Move-Item -Destination .
remove-item -force -path "EditorConfig" 

write-host "### FINE AGGIORNAMENTO`n`n"
