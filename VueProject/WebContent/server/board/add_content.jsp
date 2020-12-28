<%@ page language="java" contentType="application/json; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
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
	
	// 업로드 파일 최대 용량 
	int maxSize = 1024*1024*100;  //100mb
	// 이름 변경 정책 (중복된 파일명이 올라올 경우 뒤에 숫자를 붙이겠다)
	DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
	//저장될 서버상의 경로
	String path = getServletContext().getRealPath("/upload");
	//업로드 처리
	MultipartRequest mr = new MultipartRequest(request,path,maxSize,"UTF-8",policy);
	
	String str1 = mr.getParameter("board_writer_idx");
	int board_writer_idx = Integer.parseInt(str1);
	
	String str2 = mr.getParameter("content_board_idx");
	int content_board_idx = Integer.parseInt(str2);
	
	String board_subject = mr.getParameter("board_subject");
	String board_content = mr.getParameter("board_content");
	String board_file = mr.getFilesystemName("board_file");
	
	String sql = "INSERT INTO content_table (content_subject, content_text, content_file, content_writer_idx, content_board_idx) VALUES (?,?,?,?,?)";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setString(1, board_subject);
	pstmt.setString(2, board_content);
	pstmt.setString(3, board_file);
	pstmt.setInt(4, board_writer_idx);
	pstmt.setInt(5, content_board_idx);
	
	pstmt.execute();
	
	// 새롭게 추가된 글의 번호를 파악
	String newWriteNumSql = "SELECT MAX(content_idx) as content_idx FROM content_table";
	PreparedStatement newWNpre = db.prepareStatement(newWriteNumSql);
	ResultSet newRs = newWNpre.executeQuery();
	
	newRs.next();
	int content_idx = newRs.getInt("content_idx");
	db.close();

%>	
{
	"result" : true,
	"content_idx" :<%=content_idx%>
}