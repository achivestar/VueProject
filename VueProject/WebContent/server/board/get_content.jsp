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
	
	request.setCharacterEncoding("utf-8");
	
	//글 번호를 받겠다.
	String str1 = request.getParameter("content_idx");
	int content_idx = Integer.parseInt(str1);
	
	String sql = 
			"SELECT a1.content_idx, a1.content_subject, a1.content_text, a1.content_file, a1.content_writer_idx, a2.user_name, a1.content_date "+
			 "FROM content_table a1, user_table a2 "+
			 "WHERE a1.content_writer_idx = a2.user_idx "+ 
			 "AND a1.content_idx = ?";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, content_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	
	JSONObject root = new JSONObject();
	
	root.put("content_idx", rs.getInt("content_idx"));
	root.put("content_subject", rs.getString("content_subject"));
	root.put("content_text", rs.getString("content_text"));
	root.put("content_writer_idx", rs.getInt("content_writer_idx"));
	root.put("content_file", rs.getString("content_file"));
	root.put("user_name", rs.getString("user_name"));
	root.put("content_date", rs.getString("content_date"));
	
	db.close();
%>	
<%=root.toJSONString()%>