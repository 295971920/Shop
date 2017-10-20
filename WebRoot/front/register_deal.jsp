<%@ page language="java" import="java.util.*"
	import="java.sql.ResultSet" pageEncoding="UTF-8"%>
<%-- 创建ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="cn.xiaoshan.tools.ConnDB" />
<%-- 创建MemberDaoImpl类的对象 --%>
<jsp:useBean id="ins_member" scope="page"
	class="cn.xiaoshan.dao.MemberDaoImpl" />
<%-- 创建Member类的对象,并对Member类的属性进行赋值 --%>
<jsp:useBean id="member" scope="request"
	class="cn.xiaoshan.model.Member">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>注册检查</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<%
		request.setCharacterEncoding("UTF-8");//设置请求的编码为UTF-8
		String username = member.getUsername();//获取会员账号
		ResultSet rs = conn.executeQuery("select * from tb_member where username='" + username + "'");
		if (rs.next()) {
			out.println("<script language='javascript'>alert('该账号已经存在;请重新注册！');"
					+ "windows.location.href='register.jsp';</script>");
		} else {
			int ret = 0;//记录更新记录条数的变量
			ret = ins_member.insert(member); //将填写的会员信息保存到数据库中
			if (ret != 0) {
				session.setAttribute("username", username);//将会员信息保存发哦Session中
				out.println("<script language='javascript'>alert('会员注册成功');"+"windows.location.href='index.jsp';</script>");
			} else {
			out.println("<script language='javascript'>alert('会员注册失败！请电话联系管理员：10086');"+"windows.location.href='register.jsp';</script>");
			}
		}
	%>

</body>
</html>