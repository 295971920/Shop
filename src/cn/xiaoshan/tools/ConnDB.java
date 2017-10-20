package cn.xiaoshan.tools;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
	/**
	 * 这是一个SQL Server数据库连接
	 * 功能:数据库连接、更新、查询、关闭
	 * @author www.xiaoshan2016.cn
	 * @date 2017年10月16日
	 */
public class ConnDB {
	public Connection conn = null; //数据库连接对象
	public Statement stmt = null;  //Statement对象；用于执行SQL语句
	public ResultSet rs = null;	   //结果集对象
	
	//驱动类的类名
	private static String dbClassName ="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String dbUrl = "jdbc:sqlserver://127.0.0.1:1433;DatabaseName=db_shop";
	private static String dbUser = "sa"; //登录SQL Server的用户名
	private static String dbPwd ="8520"; //登录SQL Server的密码
	
	/**
	 * 连接数据库的方法getConnection()
	 * 功能：创建与数据库的连接
	 * @return
	 */
	public static Connection getConnection(){
		 //声明数据库连接对象
		Connection conn = null;
		//使用try...catch捕捉异常
		try {
			//装载数据库驱动
			Class.forName(dbClassName).newInstance(); 
			//获取连接对象
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPwd);
			//catch处理异常
		} catch (Exception ee) {
			// 输出异常信息
			ee.printStackTrace();
		}
		if(conn == null){
			//输出连接信息；方便调试
			System.err.println("DBConnectionManager.getConnection()"+dbUrl+"\r\n"+dbUser+"/"+dbPwd);
		}
		return conn;
	}
	
	/**
	 * 功能：更新数据
	 * @param sql
	 * @return
	 */
	
	public int executeUpdate(String sql){
		int result = 0;//更新数据的记录条数
		try {
			conn = getConnection();//获取数据的连接
			//创建用于执行SQL语句的Statement对象
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			result =stmt.executeUpdate(sql);// 执行SQL语句
		} catch (SQLException ex) { //处理异常
			// 指定更新数据的记录条数为0；表示没有更新数据
			result = 0;
			//输出异常
			ex.printStackTrace();
		}
		try {
			stmt.close();//关闭用于执行SQL语句的Statement对象
		} catch (SQLException ex1) {
			// 输出异常
			ex1.printStackTrace();
		}
		return result; //返回更行数据的记录条数
	}
	
	/**
	 * 功能：根据指定的SQL语句查询数据
	 * @param sql
	 * @return
	 */
	public ResultSet executeQuery(String sql){
		try {
			//获取数据库连接
			conn =getConnection();
			//创建用于执行SQL语句的Statement对象
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(sql); //执行SQL语句
		} catch (SQLException ex) {
			// TODO: handle exception
			ex.printStackTrace();
		}
		return rs; //返回查询结果
	}
	
	/**
	 * 功能：关闭数据库连接
	 */
	public void close(){
		try {
			if(rs != null){
				rs.close(); //关闭结果集对象
			}
			if(stmt != null){
				stmt.close(); //关闭Statement对象
			}
			if(conn != null){
				conn.close(); //关闭数据库连接对象
			}
			//处理异常
		} catch (Exception e) { 
			// 输出异常信息
			e.printStackTrace(System.err);
		}
	}
	public static void main(String[] args) {
		//如果获取到数据库连接
		if(getConnection() != null){
			System.out.println("SQL Server数据库连接成功！");
		}
	}
}
