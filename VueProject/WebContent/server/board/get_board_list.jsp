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
	
	//모든 데이터를 담아 넣을 JSONObject
		JSONObject  root = new JSONObject();
	
	//게시판 인덱스 번호
	String str1 = request.getParameter("board_idx");
	int board_idx = Integer.parseInt(str1);
	
	
	//페이징
	String str2 = request.getParameter("page");
	int cur_page =  Integer.parseInt(str2);

	
	//한 페이지에 보여줄 게시물 
	int displayPost = (cur_page-1) * 10;
	
	// 게시글의 총 개수를 구하겠다.
		String board_count = "SELECT "+
			"count(*) as count "+
			"FROM content_table a1, user_table a2 "+
			"WHERE a1.content_writer_idx = a2.user_idx AND a1.content_board_idx=? order by a1.content_idx desc";
	PreparedStatement pstmt_count = db.prepareStatement(board_count);
	pstmt_count.setInt(1, board_idx);
	
	ResultSet rsCount = pstmt_count.executeQuery();
	rsCount.next();
	
	int total_count = rsCount.getInt("count");
	
	// 하단 페이징 번호
	int pageNum = (int)Math.ceil((double)total_count/10);
	
	//표시되는 번호중 마지막 번호
	int endPageNum = (int)(Math.ceil((double)cur_page/(double)10)*10);
	
	//표시되는 페이지 번호 중 첫번째 번호
	int startPageNum = endPageNum - (10 - 1);
	
	//마지막 번호 재계산
	int endPageNum_tmp = (int)(Math.ceil((double)total_count / (double)10));
	
	if(endPageNum > endPageNum_tmp){
		endPageNum = endPageNum_tmp;
	}
	

	//게시판 정보를 가져오겠다.
	String sql = "SELECT board_info_name FROM board_info_table WHERE board_info_idx = ?";
	PreparedStatement pstmt = db.prepareStatement(sql);
	pstmt.setInt(1, board_idx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String board_info_name = rs.getString("board_info_name");
	
	root.put("board_info_name",board_info_name);
	
	//게시글을 가져오겠다
	String board_list = "SELECT "+
			"a1.content_idx, a1.content_subject, a1.content_date, a2.user_name AS content_writer_name "+
			"FROM content_table a1, user_table a2 "+
			"WHERE a1.content_writer_idx = a2.user_idx AND a1.content_board_idx=? order by a1.content_idx desc LIMIT ?,10";
	
	PreparedStatement pstmt_board_list = db.prepareStatement(board_list);
	pstmt_board_list.setInt(1, board_idx);
	pstmt_board_list.setInt(2, displayPost);
	ResultSet board_rs = pstmt_board_list.executeQuery();
	
	JSONArray board_lists = new JSONArray();
	while(board_rs.next()){
		JSONObject obj = new JSONObject();
		obj.put("content_idx", board_rs.getInt("content_idx"));
		obj.put("content_subject", board_rs.getString("content_subject"));
		obj.put("content_writer_name", board_rs.getString("content_writer_name"));
		obj.put("content_date", board_rs.getString("content_date"));
		
		board_lists.add(obj);
	}
	
	
	root.put("board_lists",board_lists);
	
	
	JSONArray page_array = new JSONArray();
	
	for(int i= startPageNum; i<=endPageNum; i++){
		page_array.add(i);
	}
	
	root.put("page_array",page_array);
	
	//이전버튼
	int pre = startPageNum-1;
	if(pre < 1){
		pre = 1;
	}
	//다음 버튼
	int next = endPageNum +1;
	if(next > total_count){
		next = total_count;
	}
	
	//현재페이징 번호
	root.put("cur_page",cur_page);

	root.put("pre",pre);
	root.put("next",next);
	
	db.close();
%>	
<%=root.toJSONString() %>
