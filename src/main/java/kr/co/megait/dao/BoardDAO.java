package kr.co.megait.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;

import kr.co.megait.common.ConnectionDB;

public class BoardDAO {

	/**
	 * 게시판 글 전체 가져오기.
	 * 
	 * @return
	 * @throws SQLException
	 */

	public LinkedHashMap BoardList(int current_page) throws SQLException {

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		LinkedHashMap board_list = new LinkedHashMap();
		LinkedHashMap board_info = new LinkedHashMap();

		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;
		
		// ArrayList<LinkedHashMap> member_list2 = new ArrayList<LinkedHashMap>();

		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from board "
					+ "join member on member.member_idx=board.member_idx "
					+ "order by ref desc, depth asc limit " +iStartPage+", "+iEndPage+" ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				board_info.put("board_idx", new Integer(rs.getInt("board_idx")));
				board_info.put("board_title", new String(rs.getString("board_title")));
				

				board_info.put("ref", new Integer(rs.getInt("ref")));
				board_info.put("subref", new Integer(rs.getInt("subref")));
				board_info.put("depth", new Integer(rs.getInt("depth")));
				board_info.put("visit", new Integer(rs.getInt("visit")));
				

				board_info.put("board_contents", new String(rs.getString("board_contents")));
				board_info.put("reg_dt", new String(rs.getString("reg_dt")));
				board_info.put("mod_dt", new String(rs.getString("mod_dt")));
				board_info.put("member_idx", new Integer(rs.getInt("member_idx")));
				
				
				board_info.put("member_idx",rs.getInt("member_idx"));
				board_info.put("member_id",new String(rs.getString("member_id")));
				board_info.put("member_pwd",new String(rs.getString("member_pwd")));
				board_info.put("member_name",new String(rs.getString("member_name")));
				board_info.put("member_birth",new String(rs.getString("member_birth")));
				board_info.put("member_phone",new String(rs.getString("member_phone")));
				board_info.put("member_gender",new String(rs.getString("member_gender")));
				board_info.put("zipcode",new String(rs.getString("zipcode")));
				board_info.put("jaddress",new String(rs.getString("jaddress")));
				board_info.put("raddress",new String(rs.getString("raddress")));
				board_info.put("address",new String(rs.getString("address")));
				board_info.put("member_del_yn",new String(rs.getString("member_del_yn")));
		
				

				board_list.put(String.valueOf(rs.getInt("board_idx")), new LinkedHashMap(board_info));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return board_list;
	}
	
	
	/**
	 * 게시글 정보 가져오기
	 * @param board_idx
	 * @return
	 * @throws SQLException
	 */
	public LinkedHashMap BoardInfo(int board_idx) throws SQLException{
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		LinkedHashMap board_info = new LinkedHashMap();
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from board "
					+ "join member on member.member_idx = board.member_idx "
					+ "where board_idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//게시글 정보
				board_info.put("board_idx", new Integer(rs.getInt("board_idx")));
				board_info.put("member_idx", new Integer(rs.getInt("member_idx")));
				board_info.put("board_title", new String(rs.getString("board_title")));
				
				board_info.put("ref", new Integer(rs.getInt("ref")));
				board_info.put("subref", new Integer(rs.getInt("subref")));
				board_info.put("depth", new Integer(rs.getInt("depth")));
				board_info.put("visit", new Integer(rs.getInt("visit")));
				
				board_info.put("board_contents", new String(rs.getString("board_contents")));
				board_info.put("reg_dt", new String(rs.getString("reg_dt")));
				board_info.put("mod_dt", new String(rs.getString("mod_dt")));
				
				//회원 정보
				board_info.put("member_idx", rs.getInt("member_idx"));
				board_info.put("member_id", new String( rs.getString("member_id") ));
				board_info.put("member_pwd", new String( rs.getString("member_pwd") ));
				board_info.put("member_name", new String( rs.getString("member_name") ));
				board_info.put("member_birth", new String( rs.getString("member_birth") ));
				board_info.put("member_phone", new String( rs.getString("member_phone") ));
				board_info.put("member_gender", new String( rs.getString("member_gender") ));
				board_info.put("zipcode", new String( rs.getString("zipcode") ));
				board_info.put("jaddress", new String( rs.getString("jaddress") ));
				board_info.put("raddress", new String( rs.getString("raddress") ));
				board_info.put("address", new String( rs.getString("address") ));
				board_info.put("member_del_yn", new String( rs.getString("member_del_yn") ));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return board_info;
	}
	
	/**
	 * 게시글 전체 개수
	 * 
	 * @return
	 * @throws SQLException
	 */

	public int BoardTotal() throws SQLException {

		Connection conn = null;
		ConnectionDB  connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LinkedHashMap board_info = new LinkedHashMap();
		
		int total_count = 0;
		
		
		try {

			conn = connectionDB.YesConnectionDB();
			sql ="select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			
			while (rs.next()) {
				total_count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return total_count;
	}

	/**
	 * 게시글 등록하기.
	 * 
	 * @param params
	 * @throws SQLException
	 */
	public void BoardInsert(HashMap<String, String> params) throws SQLException {

		  int board_idx = Integer.parseInt((String)params.get("board_idx"));
	      int member_idx = Integer.parseInt((String)params.get("member_idx"));
	      String board_title = (String)params.get("board_title");
	      String board_contents = (String)params.get("board_contents");
	      
	      
	      int ref = Integer.parseInt((String)params.get("ref"));
	      int subref = Integer.parseInt((String)params.get("subref"));
	      int depth = Integer.parseInt((String)params.get("depth"));
	      int visit =  Integer.parseInt((String)params.get("visit"));
	      Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      String sql = null;
	      PreparedStatement pstmt = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         sql = "insert into board ("
	         	   + "board_idx, "
	               + "board_title, "
	               + "ref, "
	               + "subref, "
	               + "depth, "
	               + "visit, "
	               + "board_contents, "
	               + "reg_dt, "
	               + "mod_dt, "
	               + "member_idx) "
	               + "values (?, ?, ?, ?, ?, ?, ?, now(), now(), ?)";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, board_idx);
	         pstmt.setString(2, board_title);
	         pstmt.setInt(3, ref);
	         pstmt.setInt(4, subref);
	         pstmt.setInt(5, depth);
	         pstmt.setInt(6, visit);
	         pstmt.setString(7, board_contents);
	         pstmt.setInt(8,member_idx);
	     
	         pstmt.executeUpdate();
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	}
	
	
	  /**
	    * 게시글 수정하기
	    * @param params
	    * @throws SQLException
	    */
	   public void BoardModify(HashMap<String, String>params) throws SQLException{
		  int board_idx = Integer.parseInt((String)params.get("board_idx"));
	      String board_title = (String)params.get("board_title");
	      String board_contents = (String)params.get("board_contents");
	      
	      Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      String sql = null;
	      PreparedStatement pstmt = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         sql = "update board set "
	               + "board_title = ?, "
	               + "board_contents = ?, "
	               + "mod_dt = now() where board_idx=?";

	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, board_title);
	         pstmt.setString(2, board_contents);
	         pstmt.setInt(3, board_idx);
	         pstmt.executeUpdate();
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	
	
	/**
	 * 게시글 삭제하기.
	 * @param board_idx
	 * @throws SQLException
	 */
	
	public void BoardDelete(int board_idx) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			conn = connectionDB.YesConnectionDB();
			sql = "delete from board where board_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 게시글 방문자 업데이트.
	 * @param board_idx
	 * @throws SQLException
	 */
	
	public void BoardVisitUpdate(int board_idx) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			conn = connectionDB.YesConnectionDB();
			sql = "update board set visit=visit+1 where board_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	

	/**
	 * 게시글 전체 개수
	 * 
	 * @return
	 * @throws SQLException
	 */

	public int BoardMaxId() throws SQLException {

		Connection conn = null;
		ConnectionDB  connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LinkedHashMap board_info = new LinkedHashMap();
		
		int max_number = 0;
		
		
		try {

			conn = connectionDB.YesConnectionDB();
			sql ="select max(board_idx) from board";
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			
			while (rs.next()) {
				max_number = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return max_number;
	}
	
	
	public void BoardDepthUpdate(int ref, int depth) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			conn = connectionDB.YesConnectionDB();
			sql = "update board set depth=depth+1 where ref=? and depth > ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,ref);
			pstmt.setInt(2,depth);
			pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
