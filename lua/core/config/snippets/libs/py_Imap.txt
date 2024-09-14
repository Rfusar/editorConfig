from myImap import EMAIL

credenziali = {
    "dominio": "",
    "email": "",
    "password": "",
}
with EMAIL(credenziali) as casella:
    casella.ShowFolders()
