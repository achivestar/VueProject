<%@ page language="java" contentType="application/json; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%

	// 로그인 여부 값을 가지고 오겠다.
	Boolean login_chk = (Boolean)session.getAttribute("login_chk");
	if(login_chk == null || login_chk == false){	
		return ; // 세션 값이 null 또는 없다면 수행중단
	}
	
	//데이터 베이스 접속 정보
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/kkameun12?useUnicode=true&characterEncoding=UTF-8";
	String user = "root";
	String password = "qkagksmf1!";
	
	//접속
	Class.forName(driver);
	Connection db = DriverManager.getConnection(url, user, password);	
	
	// 파라미터 데이터를 추출
	String str1 = request.getParameter("user_idx");
	int user_idx = Integer.parseInt(str1);
	
	String user_pw = request.getParameter("user_pw");
	
	String sql = "UPDATE user_table set user_pw = ?  WHERE user_idx = ?";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, user_pw);
	pstmt.setInt(2, user_idx);
	
	pstmt.execute();
	
	db.close();
%>	
{
	"result" : true
}
