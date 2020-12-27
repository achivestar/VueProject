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
	
	//파라미터 추출
	// 아이디만 추출하여 아이디 중복확인 처리 할것
	String user_id = request.getParameter("user_id");
	String sql = "SELECT * FROM user_table WHERE user_id = ?";
	
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_id);
	
	ResultSet rs = pstmt.executeQuery();
	
	boolean chk = rs.next(); //가져온 값이 있다면 아이디가 있다는 의미
	
	db.close();
%>	

{
	"check_result" : <%=chk %>
}

