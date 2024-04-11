Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\MailKit.4.4.0\lib\netstandard2.0\MailKit.dll"
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\MimeKit.4.4.0\lib\netstandard2.0\MimeKit.dll"

$SMTP = New-Object MailKit.Net.Smtp.SmtpClient
$Message = New-Object MimeKit.MimeMessage
$Builder= New-Object MimeKit.BodyBuilder

$Account = Import-Clixml -Path C:\Users\Lore\Desktop\scripts\send-mail\outlook.xml
$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Account.UserName,$Account.Password
$Message.From.add("contact@lorenzowashington.com")
$Message.to.add("contact@lorenzowashington.com")
$Message.Subject = "Test message"
$Builder.TextBody = "This is a test email message"
$Message.Body = $Builder.ToMessageBody()
$SMTP.Connect('smtp-mail.outlook.com', 587, $false)
$SMTP.Authenticate($MyCredential)
$SMTP.Send($Message)
$SMTP.Disconnect($true)
$SMTP.Dispose()