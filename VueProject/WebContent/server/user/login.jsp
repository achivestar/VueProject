<%@ page language="java" contentType="application/json; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%
	//데이터 베이스 접속 정보
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/kkameun12?useUnicode=true&characterEncoding=UTF-8";
	String user = "root";
	String password = "qkagksmf1!";
	
	//접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, user, password);
	
	//파라미터 한글처리
	request.setCharacterEncoding("utf-8");
	
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");

	
	String sql = "SELECT user_idx, user_name FROM user_table WHERE user_id = ? AND user_pw = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	pstmt.setString(2, user_pw);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next();

	JSONObject root = new JSONObject();
	
	if(chk == false){
		root.put("result" , false);
	}else{
		root.put("result" , true);
		root.put("user_idx", rs.getInt("user_idx"));
		root.put("user_name", rs.getString("user_name"));
		root.put("user_id", user_id);
		
		session.setAttribute("login_chk",true);
	}
	
	db.close();
%>	
<%=root.toJSONString() %>


