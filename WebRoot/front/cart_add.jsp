<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%-- 导入java.sql.ResultSet类 --%>
<%@ page import="java.sql.ResultSet"%>
<%-- 导入Java的向量类 --%>
<%@ page import="java.util.Vector"%>
<%-- 导入购物车商品的模型类 --%>
<%@ page import="cn.xiaoshan.model.Goodselement"%>
<%-- 创建一个cn.xiaoshan.tools.ConnDB类的对象 --%>
<jsp:useBean id="conn" scope="page" class="cn.xiaoshan.tools.ConnDB"></jsp:useBean>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>购物车商品添加</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<%
		String username = (String) session.getAttribute("username");//获取会员账号
		String num = (String) request.getParameter("num");//获取商品数量
		//如果没有登录；将跳转到登录页面
		if(username == null || username == ""){
			response.sendRedirect("login.jsp");//重定向页面到会员登录页面
			return;//返回
		}
		int ID = Integer.parseInt(request.getParameter("goodsID"));//获取会员商品ID
		String sql ="select * from tb_goods where ID="+ID;//定义根据商品ID查询商品信息的SQL语句
		ResultSet rs = conn.executeQuery(sql);//根据商品ID查询商品
		float nowprice = 0;//定义保存商品价格的变量
		if(rs.next()){//如果查询到指定商品
			nowprice = rs.getFloat("nowprice");//获取该商品的价格
		}
		//创建保存购物车内商品信息的模型类对象mygoodselement
		Goodselement mygoodselement = new Goodselement();
		mygoodselement.ID =ID;//将商品ID保存到mygoodselement对象中
		mygoodselement.nowprice=nowprice;//将商品价格保存到mygoodselement对象
		mygoodselement.number =Integer.parseInt(num);//将购买数量保存到mygoodselement对象中
		boolean Flag =true;//记录购物车是否已经存在所所要添加的商品
		Vector cart =(Vector)session.getAttribute("cart");
		if(cart == null ){ //如果购物车对象为空
			cart = new Vector();//创建一个购物车对象
		}else{
			//判断购物车是否已经存在所购买的商品
			for(int i=0;i<cart.size();i++){
				Goodselement goodsitem =(Goodselement)cart.elementAt(i);//获取购物车内的一个商品
				if(goodsitem.ID == mygoodselement.ID){//如果当前需要添加的商品已在购物车中
					//直接改变购物数量
					goodsitem.number = goodsitem.number +mygoodselement.number;
					cart.setElementAt(goodsitem, i);//重新保存到购物车中
					Flag = false;//设置标记变量Flag为false;代表购物车中存在这商品
				}
			}
		}
		
		if(Flag) //如果购物车内不存在该商品
			cart.addElement(mygoodselement); //将需要购买的商品保存到购物车中
			session.setAttribute("cart",cart);//将购物车对象添加到Session中
			conn.close();//关闭数据库的连接
			response.sendRedirect("cart_see.jsp");//重定向页面到查看购物车页面
		
	%>
</body>
</html>
