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
<title>사용자등록 종료</title>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<p align="center">&nbsp;
<div align="center"><table border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="634" height="83" valign="top"><table border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="633" height="31" bgcolor="#e2e2e2">
<p align="left">&nbsp;<b>&nbsp;사용자등록 종료- <%= id %></b></td>
</tr>
</table>
<p>
아래와 같은 정보를 가진 사용자로 등록되었습니다. 비밀번호와 아이디는 반드시 기억해 주시기 바랍니다. 아이디와 비밀번호 분실시 검색은 거의 불가능합니다. ^^;; 등록후 정보의 변경은 로그인을 하신후 변경하시기 바랍니다. <P>
<ul>
사용자ID : <%=id%><br>
사용자명 : <%=name%><br>
비밀번호 : <%=pass%><br>
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
<p align="center"><a href="index.html"><font size="2">[로그인]</font></a></p>
</body>
<%
DBCon.Close
%>
</html>