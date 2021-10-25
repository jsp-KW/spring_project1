package kr.co.megait.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.common.ConnectionDB;

public class MemberDAO {

	/**
	 * 회원 정보 입력하기
	 * @param params
	 */
	public void MemberInsert(HashMap<String, String> params) {
		//변수 받아서 변수 처리
		String member_id = params.get("member_id");
		String member_pwd = params.get("member_pwd");
		String member_name = params.get("member_name");
		String member_birth = params.get("member_birth");
		String member_phone = params.get("member_phone");
		String member_gender = params.get("member_gender");
		String zipcode = params.get("zipcode");
		String jaddress = params.get("jaddress");
		String raddress = params.get("raddress");
		String address = params.get("address");
		String latitude =params.get("latitude");
		String longitude = params.get("longitude");
		String member_del_yn = params.get("member_del_yn");
		
		
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		String sql = null;

		
		
		try {
			conn= connectionDB.YesConnectionDB();
			
			sql = "insert into member("
					+ "member_id,"
					+ "member_pwd,"
					+ "member_name,"
					+ "member_birth,"
					+ "member_phone,"
					+ "member_gender,"
					+ "zipcode,"
					+ "jaddress,"
					+ "raddress,"
					+ "address,"
					+ "latitude,"
					+ "longitude,"
					+ "member_del_yn,"
					+ "reg_dt,"
					+ "mod_dt ) values ("
					+ "?,?,?,?,?,?,?,?,?,?,?,?,?, now(), now() )";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, member_pwd);
			pstmt.setString(3, member_name);
			pstmt.setString(4, member_birth);
			pstmt.setString(5, member_phone);
			pstmt.setString(6, member_gender);
			pstmt.setString(7, zipcode);
			pstmt.setString(8, jaddress);
			pstmt.setString(9, raddress);
			pstmt.setString(10, address);
			pstmt.setString(11, latitude);
			pstmt.setString(12, longitude);
			pstmt.setString(13, member_del_yn);
			pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		
	}
	/***
	 * 회원 리스트 전체 가져오기
	 * @return
	 * @throws SQLException
	 */
	public LinkedHashMap MemberList(int current_page) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		LinkedHashMap member_info = new LinkedHashMap();
		LinkedHashMap member_list= new LinkedHashMap();
		
		
		int iEndPage = 10;
		int iStartPage = (current_page*iEndPage)-10;
		
		
		
		ArrayList<LinkedHashMap> member_list2 = new ArrayList<LinkedHashMap>();
	
		try {
			conn = connectionDB.YesConnectionDB();
			sql = "select * from member "
					+ "order by member_idx desc limit "+iStartPage+","+iEndPage+" ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				member_info.put("member_idx",rs.getInt("member_idx"));
				member_info.put("member_id",new String(rs.getString("member_id")));
				member_info.put("member_pwd",new String(rs.getString("member_pwd")));
				member_info.put("member_name",new String(rs.getString("member_name")));
				member_info.put("member_birth",new String(rs.getString("member_birth")));
				member_info.put("member_phone",new String(rs.getString("member_phone")));
				member_info.put("member_gender",new String(rs.getString("member_gender")));
				member_info.put("zipcode",new String(rs.getString("zipcode")));
				member_info.put("jaddress",new String(rs.getString("jaddress")));
				member_info.put("raddress",new String(rs.getString("raddress")));
				member_info.put("address",new String(rs.getString("address")));
				member_info.put("latitude",new String(rs.getString("latitude")));
				member_info.put("longitude",new String(rs.getString("longitude")));
				member_info.put("member_del_yn",new String(rs.getString("member_del_yn")));
				member_info.put("reg_dt",new String(rs.getString("reg_dt")));
				member_info.put("mod_dt",new String(rs.getString("mod_dt")));
				member_list.put(String.valueOf(rs.getInt("member_idx")), new LinkedHashMap(member_info));
				member_list2.add(member_info);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return member_list;
	}
	
	/**
	 * 회원 정보 가져오기
	 * @param member_idx
	 * @return
	 * @throws SQLException
	 */
	public LinkedHashMap MemberInfo(int member_idx) throws SQLException {
		Connection conn = null;
		ConnectionDB connectionDB = new ConnectionDB();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		LinkedHashMap member_info = new LinkedHashMap();
		try {
			conn =connectionDB.YesConnectionDB();
			sql = "select * from member where member_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_idx);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				member_info.put("member_id",new String(rs.getString("member_id")));
				member_info.put("member_pwd",new String(rs.getString("member_pwd")));
				member_info.put("member_name",new String(rs.getString("member_name")));
				member_info.put("member_birth",new String(rs.getString("member_birth")));
				member_info.put("member_phone",new String(rs.getString("member_phone")));
				member_info.put("member_gender",new String(rs.getString("member_gender")));
				member_info.put("zipcode",new String(rs.getString("zipcode")));
				member_info.put("jaddress",new String(rs.getString("jaddress")));
				member_info.put("raddress",new String(rs.getString("raddress")));
				member_info.put("address",new String(rs.getString("address")));
				member_info.put("latitude",new String(rs.getString("latitude")));
				member_info.put("longitude",new String(rs.getString("longitude")));
				member_info.put("member_del_yn",new String(rs.getString("member_del_yn")));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return member_info;
	}
	
	
	/**
	 * 
	 * @param member_id
	 * @param member_pwd
	 * @return
	 * @throws SQLException
	 */
	   
	   
	   public LinkedHashMap MemberInfo2(String member_id, String member_pwd) throws SQLException {
			Connection conn = null;
			ConnectionDB connectionDB = new ConnectionDB();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			
			LinkedHashMap member_info = new LinkedHashMap();
			try {
				conn =connectionDB.YesConnectionDB(); //db에 연결
				
				// 실행할  sql문  저장
				sql = "select * from member where member_id=? and member_pwd=?";
				// PreparedStatement는 메서드와 "?"를 이용하여
				//sql문 안에 있는 ?에 데이터를 전달해 줄 수 있다.
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member_id);
				pstmt.setString(2, member_pwd);
				
				// 쿼리문을 처리한후 ResultSet 객체를 반환한다.
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					member_info.put("member_idx", new Integer(rs.getInt("member_idx")));  // 이거 한 줄 안해줘서 member_idx값 안나와서 게시물 등록하러가는거 안됫엇음 ㅇ.
					member_info.put("member_id",new String(rs.getString("member_id")));
					member_info.put("member_pwd",new String(rs.getString("member_pwd")));
					member_info.put("member_name",new String(rs.getString("member_name")));
					member_info.put("member_birth",new String(rs.getString("member_birth")));
					member_info.put("member_phone",new String(rs.getString("member_phone")));
					member_info.put("member_gender",new String(rs.getString("member_gender")));
					member_info.put("zipcode",new String(rs.getString("zipcode")));
					member_info.put("jaddress",new String(rs.getString("jaddress")));
					member_info.put("raddress",new String(rs.getString("raddress")));
					member_info.put("address",new String(rs.getString("address")));
					member_info.put("member_del_yn",new String(rs.getString("member_del_yn")));
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			return member_info;
		}
	/**
	 * 회원 전체 개수 가져오기.
	 * @return
	 * @throws SQLException
	 */
	 public int MemberTotal () throws SQLException{
		 int total_count = 0;
		 
			Connection conn = null;
			ConnectionDB connectionDB = new ConnectionDB();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
		 
		 try {
				conn =connectionDB.YesConnectionDB();
				sql = "select count(*) as total_count from member";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					total_count = rs.getInt(1);
				//	total_count = rs.getInt("total_count");
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		 
		 return total_count;
	 }
	 
	   /**
	    * 회원 정보 수정
	    * @param params
	    * @throws Exception
	    */
	   public void MemberModify(HashMap<String, String> params) throws Exception{
	      
	      //변수 받아서 변수 처리
	      int member_idx = Integer.parseInt(params.get("member_idx"));
	      String member_id = params.get("member_id");
	      String member_pwd = params.get("member_pwd");
	      String member_name = params.get("member_name");
	      String member_birth = params.get("member_birth");
	      String member_phone = params.get("member_phone");
	      String member_gender = params.get("member_gender");
	      String zipcode = params.get("zipcode");
	      String jaddress = params.get("jaddress");
	      String raddress = params.get("raddress");
	      String address = params.get("address");
			String latitude =params.get("latitude");
			String longitude = params.get("longitude");
	      String member_del_yn = params.get("member_del_yn");

	      Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      PreparedStatement pstmt = null;
	      String sql = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         
	         sql = "update member set "
	               + "member_id = ?, "
	               + "member_pwd = ?, "
	               + "member_name = ?, "
	               + "member_birth = ?, "
	               + "member_phone = ?, "
	               + "member_gender = ?, "
	               + "zipcode = ?, "
	               + "raddress = ?, "
	               + "jaddress = ?, "
	               + "address = ?, "
	               + "latitude = ?, "
	               + "longitude = ?, "
	               + "member_del_yn = ?, "
	               + "mod_dt = now() "
	               + "where member_idx = ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, member_id);
	         pstmt.setString(2, member_pwd);
	         pstmt.setString(3, member_name);
	         pstmt.setString(4, member_birth);
	         pstmt.setString(5, member_phone);
	         pstmt.setString(6, member_gender);
	         pstmt.setString(7, zipcode);
	         pstmt.setString(8, jaddress);
	         pstmt.setString(9, raddress);
	         pstmt.setString(10, address);
			 pstmt.setString(11, latitude);
			 pstmt.setString(12, longitude);
	         pstmt.setString(13, member_del_yn);
	         pstmt.setInt(14, member_idx);
	         pstmt.executeUpdate();
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }

	   }
	   
	   
	   /**
	    * 회원 삭제
	    * @param member_idx
	    * @throws Exception
	    */
	   public void MemberDelete(int member_idx) throws Exception{
		      
		   
		      Connection conn = null;
		      ConnectionDB connectionDB = new ConnectionDB();
		      PreparedStatement pstmt = null;
		      String sql = null;
		      
		      try {
		         conn = connectionDB.YesConnectionDB();
		         
		         sql= "delete from member where member_idx = ?";
		         
		    
		         pstmt = conn.prepareStatement(sql);
		         pstmt.setInt(1,member_idx);
		         pstmt.executeUpdate();
		         
		      } catch (SQLException e) {
		         // TODO Auto-generated catch block
		         e.printStackTrace();
		      }

		   }
	   

	   
	   /**
	    * 회원 비밀번호 체크
	    * @param member_idx
	    * @param member_pwd
	    * @return
	    * @throws SQLException
	    */
	   
	   
	  public int MemberPwdCheck (int member_idx, String member_pwd) throws SQLException{
			   
				Connection conn = null;
				ConnectionDB connectionDB = new ConnectionDB();
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				
				int nflag = 0;
				
				CommonUtil commonUtil = new CommonUtil();
				member_pwd = commonUtil.getEncrypt(member_pwd);
				
				
				try {
					conn =connectionDB.YesConnectionDB();
					sql = "select count(*) as total_count from member "
							+ "where member_idx=? and member_pwd=? ";
					
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, member_idx);
					pstmt.setString(2, member_pwd);
					rs = pstmt.executeQuery();
					
					while (rs.next()) {
						nflag = rs.getInt(1);
					//	total_count = rs.getInt("total_count");
					}
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				
				// nflag 가 1이 나오면 아이디 비번 맞는거임.
			 
			 return nflag;
		 }
	  
	  
	  
	  
	  
	  
	  /**
	   * 비밀번호 수정
	   * @param member_idx
	   * @param member_pwd
	   * @throws Exception
	   */
	   public void PwdUpdate(int member_idx, String member_pwd) throws Exception{
	      
	     
	      Connection conn = null;
	      ConnectionDB connectionDB = new ConnectionDB();
	      PreparedStatement pstmt = null;
	      String sql = null;
	      
	      try {
	         conn = connectionDB.YesConnectionDB();
	         
	         sql = "update member set "
	         		+ "member_pwd = ? "
	         		+ "where member_idx =? ";
	           
	         
	         pstmt = conn.prepareStatement(sql);
	   
	         pstmt.setString(1, member_pwd);
	         pstmt.setInt(2, member_idx);
	         pstmt.executeUpdate();
	         
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }finally {
	    	  
	    	  // 안해주면 사람들이 많이 접속했을때 다운된다.
	    	  pstmt.close();
	    	  conn.close();
	    	  
	      }
	      

	   }
	   
		

}
