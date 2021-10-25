package kr.co.megait.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.megait.common.ConnectionDB;

public class NoticeDAO {

	/**
	 * 공지사항 글 전체 가져오기.
	 * 
	 * @return
	 * @throws SQLException
	 */

	public JSONArray NoticeList1(int current_page) throws SQLException {

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		JSONArray notice_list = new JSONArray();
		JSONObject notice_info = new JSONObject();

		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;
		
		// ArrayList<LinkedHashMap> member_list2 = new ArrayList<LinkedHashMap>();

		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select *, Date(reg_dt) as rdt, Date(mod_dt) as mdt from notice "
				+ "order by reg_dt desc limit " +iStartPage+", "+iEndPage+" ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				notice_info = new JSONObject();
				notice_info.put("notice_idx", new Integer(rs.getInt("notice_idx")));
				notice_info.put("notice_title", new String(rs.getString("notice_title")));
				notice_info.put("notice_contents", new String(rs.getString("notice_contents")));
				notice_info.put("visit", new Integer(rs.getInt("visit")));
				notice_info.put("reg_dt", new String(rs.getString("reg_dt")));
				notice_info.put("mod_dt", new String(rs.getString("mod_dt")));
				
				notice_list.add(notice_info);
	
			
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return notice_list;
	}
	
	
	

	
	/**
	 * 게시글 정보 가져오기
	 * @param notice_idx
	 * @return
	 * @throws SQLException
	 */
	public JSONArray NoticeList2(int counter) throws SQLException {

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

		JSONArray notice_list = new JSONArray();
		JSONObject notice_info = new JSONObject();

		
		// ArrayList<LinkedHashMap> member_list2 = new ArrayList<LinkedHashMap>();

		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from notice "
				+ "order by reg_dt desc limit " +counter+" ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				notice_info.put("notice_idx", new Integer(rs.getInt("notice_idx")));
				notice_info.put("notice_title", new String(rs.getString("notice_title")));
				notice_info.put("notice_contents", new String(rs.getString("notice_contents")));
				notice_info.put("visit", new Integer(rs.getInt("visit")));
				notice_info.put("reg_dt", new String(rs.getString("reg_dt")));
				notice_info.put("mod_dt", new String(rs.getString("mod_dt")));
				
				notice_list.add(notice_info);
	
			
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return notice_list;
	}
	
	

	/**
	 * 공지사항 정보보기
	 * @param notice_idx
	 * @return
	 * @throws SQLException
	 */
	public JSONObject NoticeInfo(int notice_idx) throws SQLException {

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;

	
		JSONObject notice_info = new JSONObject();

		
		// ArrayList<LinkedHashMap> member_list2 = new ArrayList<LinkedHashMap>();

		try {
			conn = connectionDB.YesConnectionDB();
			sql =  "select * from notice where notice_idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_idx);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				notice_info.put("notice_idx", new Integer(rs.getInt("notice_idx")));
				notice_info.put("notice_title", new String(rs.getString("notice_title")));
				notice_info.put("notice_contents", new String(rs.getString("notice_contents")));
				notice_info.put("visit", new Integer(rs.getInt("visit")));
				notice_info.put("reg_dt", new String(rs.getString("reg_dt")));
				notice_info.put("mod_dt", new String(rs.getString("mod_dt")));
				
	
			
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return notice_info;
	}
	/**
	 * 공지사항 전체 개수
	 * 
	 * @return
	 * @throws SQLException
	 */

	public int NoticeTotal() throws SQLException {

		Connection conn = null;
		ConnectionDB  connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		
		int total_count = 0;
		
		
		try {

			conn = connectionDB.YesConnectionDB();
			sql ="select count(*) from notice";
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
	 * 공지사항 등록하기.
	 * 
	 * @param params
	 * @throws SQLException
	 */
	public void NoticeInsert(String notice_title, String notice_contents) throws SQLException {

	 
	      
	      Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      String sql = null;
	      PreparedStatement pstmt = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         sql = "insert into notice ("
	               + "notice_title, "
	               + "notice_contents, "
	               + "reg_dt, "
	               + "mod_dt) "
	               + "values (?, ?, now(), now())";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, notice_title);
	         pstmt.setString(2, notice_contents);
	     
	         pstmt.executeUpdate();
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	}
	
	
	  /**
	    * 공지사항 수정하기
	    * @param params
	    * @throws SQLException
	    */
	   public void NoticeModify(int notice_idx, String notice_title, String notice_contents) throws SQLException{
		
		  Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      String sql = null;
	      PreparedStatement pstmt = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         sql = "update notice set "
	               + "notice_title = ?, "
	               + "notice_contents = ?, "
	               + "mod_dt = now() where notice_idx=?";

	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, notice_title);
	         pstmt.setString(2, notice_contents);
	         pstmt.setInt(3, notice_idx);
	         pstmt.executeUpdate();
	         
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }

	
	
	/**
	 * 공지사항 삭제하기.
	 * @param notice_idx
	 * @throws SQLException
	 */
	
	public void NoticeDelete(int notice_idx) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			conn = connectionDB.YesConnectionDB();
			sql = "delete from notice where notice_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_idx);
			pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 게시물 방문자 업데이트.
	 * @param notice_idx
	 * @throws SQLException
	 */
	
	public void NoticeVisitUpdate(int notice_idx) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			
			conn = connectionDB.YesConnectionDB();
			sql = "update notice set visit=visit+1 where notice_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_idx);
			pstmt.executeUpdate();
			
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	


}
