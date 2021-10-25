package kr.co.megait.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.common.ConnectionDB;

public class LibraryDAO {

	/***
	 * 도서관 리스트 전체 가져오기
	 * 
	 * @return
	 * @throws SQLException
	 */
	
	public JSONArray LibraryList(int current_page) throws SQLException{
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;

		JSONArray library_list = new JSONArray();
		JSONObject library_info = new JSONObject();
		
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from library order by library_idx desc ";
			
			if(current_page!=0) {
				sql+= "limit "+iStartPage+", "+iEndPage+"";
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				library_info = new JSONObject();
				library_info.put("library_idx", rs.getInt("library_idx"));
				library_info.put("name", new String( rs.getString("name") ));
				library_info.put("address", new String( rs.getString("address") ));
				library_info.put("latitude", new String( rs.getString("latitude") ));
				library_info.put("longitude", new String( rs.getString("longitude") ));
				library_info.put("phone", new String( rs.getString("phone") ));
				library_info.put("url", new String( rs.getString("url") ));
				
				library_list.add(library_info);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		
		return library_list;
	}
	
	
	/**
	 * 도서관 정보 가져오기
	 * @param member_idx
	 * @return
	 * @throws SQLException
	 */
	public JSONObject LibraryInfo(int library_idx) throws SQLException{
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		JSONObject library_info = new JSONObject();
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from library where library_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, library_idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				library_info = new JSONObject();
				library_info.put("library_idx", rs.getInt("library_idx"));
				library_info.put("name", new String( rs.getString("name") ));
				library_info.put("address", new String( rs.getString("address") ));
				library_info.put("latitude", new String( rs.getString("latitude") ));
				library_info.put("longitude", new String( rs.getString("longitude") ));
				library_info.put("phone", new String( rs.getString("phone") ));
				library_info.put("url", new String( rs.getString("url") ));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		
		return library_info;
	}


	
	/**
	 * 도서관 전체 개수 가져오기
	 * @return
	 * @throws SQLException
	 */
	public int LibraryTotal() throws SQLException{

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int total_count = 0;
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select count(*) as total_count from library";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				total_count = rs.getInt(1);
//				total_count = rs.getInt("total_count");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			rs.close();
			pstmt.close();
			conn.close();
		}

		
		return total_count;
	}
	
	
	/**
	 * GPS 업데이트
	 * @param library_idx
	 * @param latitude
	 * @param longitude
	 * @throws Exception
	 */
	public void GPSUpdate(int library_idx, String latitude, String longitude) throws Exception{

		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = connectionDB.YesConnectionDB();
			
			sql = "update library set "
					+ "latitude = ?, "
					+ "longitude = ? "
					+ "where library_idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, latitude);
			pstmt.setString(2, longitude);
			pstmt.setInt(3, library_idx);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			pstmt.close();
			conn.close();
		}

	}


	public JSONArray LibraryApiList(int current_page) throws SQLException{
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;

		JSONArray library_list = new JSONArray();
		JSONObject library_info = new JSONObject();
		
		CommonUtil CU = new CommonUtil();
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from library order by library_idx desc ";
			
			if(current_page!=0) {
				sql+= "limit "+iStartPage+", "+iEndPage+"";
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				library_info = new JSONObject();
				library_info.put("library_idx", rs.getInt("library_idx"));
				library_info.put("name", new String( CU.StringToBase64Encoding(rs.getString("name")) ));
				library_info.put("address", new String( CU.StringToBase64Encoding(rs.getString("address") )));
				library_info.put("latitude", new String( CU.StringToBase64Encoding(rs.getString("latitude") )));
				library_info.put("longitude", new String(CU.StringToBase64Encoding (rs.getString("longitude")) ));
				library_info.put("phone", new String( CU.StringToBase64Encoding(rs.getString("phone")) ));
				library_info.put("url", new String(CU.StringToBase64Encoding( rs.getString("url") )));
				
				library_list.add(library_info);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		
		return library_list;
	}
	
	
	
	/**
	 * 도서관 api 리스트
	 * @param current_page
	 * @return
	 * @throws SQLException
	 */
	
	
	public JSONObject LibraryApiList2(int current_page) throws SQLException{
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;

		JSONArray positions = new JSONArray();
		JSONObject library_info = new JSONObject();
		JSONObject api_object = new JSONObject(); // 출력으로 낼것.
		
		CommonUtil CU = new CommonUtil();
		
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from library order by library_idx desc ";
			
			if(current_page!=0) {
				sql+= "limit "+iStartPage+", "+iEndPage+"";
			}
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				library_info = new JSONObject();
				library_info.put("lat", new String(rs.getString("latitude") ));
				library_info.put("lng", new String(rs.getString("longitude")) );
				
				positions.add(library_info);
				
			}
			
			api_object.put("positions",positions);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		
		return api_object;
	}


}
