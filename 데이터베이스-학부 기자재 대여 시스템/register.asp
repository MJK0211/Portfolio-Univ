<%
Set DBCon = Server.CreateObject("ADODB.Connection")
DBCon.Open ("DSN=JAEMOON;UID=sa;Pwd=1234")
id = Request("id")
pass = Request("pass")
name = Request("name")
SQLString = "SELECT MAX(rindex) FROM member"
Set Result=DBCon.Execute(SQLString)
If IsNULL(Result(0)) Then
	rindex = 1
else
	rindex = Result(0) + 1
End If
	SQLString = "INSERT INTO member VALUES	("&rindex&",'"&id&"','"&pass&"','"&name&"')"
DBCon.Execute(SQLString)
%>

<html>
<head>
<title>����ڵ�� ����</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<p align="center">&nbsp;
<div align="center"><table border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="634" height="83" valign="top"><table border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="633" height="31" bgcolor="#e2e2e2">
<p align="left">&nbsp;<b>&nbsp;����ڵ�� ����- <%= id %></b></td>
</tr>
</table>
<p>
�Ʒ��� ���� ������ ���� ����ڷ� ��ϵǾ����ϴ�. ��й�ȣ�� ���̵�� �ݵ�� ����� �ֽñ� �ٶ��ϴ�. ���̵�� ��й�ȣ �нǽ� �˻��� ���� �Ұ����մϴ�. ^^;; ����� ������ ������ �α����� �Ͻ��� �����Ͻñ� �ٶ��ϴ�. <P>
<ul>
�����ID : <%=id%><br>
����ڸ� : <%=name%><br>
��й�ȣ : <%=pass%><br>
</ul>
<p>
<table border="0" cellpadding="0" cellspacing="0" bordercolor="#e2e2e2" bordercolordark="silver">
<tr>
<td width="634" height="31" bgcolor="#e2e2e2">
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
<p align="center"><a href="index.html"><font size="2">[�α���]</font></a></p>
</body>
<%
DBCon.Close
%>
</html>