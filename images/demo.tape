# VHS https://github.com/charmbracelet/vhs
Output demo.gif
Hide
Set Shell pwsh
Type "Import-Module ../.publish/XMLLab.psd1"
Enter
Type "Clear-Host"
Enter
Show
Type "Test-Xml -Xml '<x/>'"
Enter
Sleep 2s
Type "Test-Xml -Xml '</>'"
Enter
Sleep 2s
Type "Test-Xml -Path demo.tape"
Enter
Sleep 2s
Type "Format-Xml -Xml '<a><b c=''value''/></a>'"
Enter
Sleep 2s
Type "Select-Xml -XPath //@* -Xml ([xml]'<a><b c=''value''/></a>') |Resolve-XPath"
Enter
Sleep 2s
Type "Get-XmlNamespaces ../test/data/xslt-test.xslt"
Enter
Sleep 9s
