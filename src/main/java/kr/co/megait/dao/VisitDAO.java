package kr.co.megait.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.web.multipart.commons.CommonsFileUploadSupport;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.common.ConnectionDB;
import net.sf.uadetector.UserAgentStringParser;
import net.sf.uadetector.service.UADetectorServiceFactory;

public class VisitDAO {
   
   /**
    * 공지사항 글 전체 가져오기
    * @return
    * @throws SQLException
    */
   public JSONArray VisitList(String type, String sdt, String edt) throws SQLException{
      
      //변수 선언
      Connection conn = null;
      ConnectionDB connectionDB = new ConnectionDB();
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      
      JSONArray visit_list = new JSONArray();
      JSONObject visit_info = new JSONObject();
        
      try {
         conn = connectionDB.YesConnectionDB();
         
         sql = "select visit_idx as rownum, "
               + "date(visit_reg_dt) as str_date, "
               + "count(*) as counter "
               + "from visit_tb ";
             
         if(!type.equals("A")) {
        	 sql += "where visit_reg_dt between str_to_date('"+sdt+"','%Y-%m-%d') and date(now()) ";
         }
             sql+="group by str_date "
               + "order by visit_reg_dt asc";
         System.out.println(sql);
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         
         while(rs.next()) {
            
            //게시글 정보
            visit_info = new JSONObject();
            visit_info.put("rownum", new Integer(rs.getInt("rownum")));
            visit_info.put("str_date", new String(rs.getString("str_date")));
            visit_info.put("counter", new Integer(rs.getInt("counter")));
            visit_list.add(visit_info);
         }
         
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         pstmt.close();
         rs.close();
         conn.close();
      }
      
      return visit_list;
   }
   

   
   /**
    * 방문자 전체 개수
    * @return
    * @throws SQLException
    */
   public int VisitTotal() throws SQLException{
      
      Connection conn = null;
      ConnectionDB connectionDB = new ConnectionDB();
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;

      int total_count = 0;
      try {
         conn = connectionDB.YesConnectionDB();
         sql = "select count(*) from visit_tb";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            total_count = rs.getInt(1);
         }
         
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         pstmt.close();
         rs.close();
         conn.close();
      }
      
      return total_count;
   }

   
   /**
    * 방문자 등록하기
    * @param params
    * @throws SQLException
    */
   public void VisitInsert(int member_idx, String type, int fidx, String page, String ip, String browser) throws SQLException{
      
      Connection conn = null;
      ConnectionDB connectionDB = new ConnectionDB();
      String sql = null;
      PreparedStatement pstmt = null;
      
      try {
         conn = connectionDB.YesConnectionDB();
         
         sql = "insert into visit_tb("
               + "member_idx, "
               + "type, "
               + "fidx, "
               + "page, "
               + "ip, "
               + "browser, "
               + "year, "
               + "month, "
               + "day, "
               + "hour, "
               + "minute, "
               + "visit_reg_dt "
               + ") values ("
               + "?,?,?,?,?,?,"
               + "date_format(now(), '%Y'), "
               + "date_format(now(), '%m'), "
               + "date_format(now(), '%d'), "
               + "date_format(now(), '%H'), "
               + "date_format(now(), '%i'), "
               + "now() "
               + ")";
         
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, member_idx);
         pstmt.setString(2, type);
         pstmt.setInt(3, fidx);
         pstmt.setString(4, page);
         pstmt.setString(5, ip);
         pstmt.setString(6, browser);
         pstmt.executeUpdate();
         
      } catch (Exception e) {
         e.printStackTrace();
      }finally {
         pstmt.close();
         conn.close();
      }
   }
   
   // request 에 방문자 정보를 받아 사용하겠다.
   public void VisitReg(HttpServletRequest request) throws Exception {
	   
	   CommonUtil commonUtil = new CommonUtil();
	   HttpSession session = request.getSession();
	   //세션에 있는 회원 idx를 받아와야하기 때문에 세션을 사용한다.
	   
	   int member_idx=0;
	   if (session.getAttribute("member_idx")!=null && session.getAttribute("member_idx")!="") {
		   
		   
		   member_idx = (Integer)session.getAttribute("member_idx");
		   
	   }
	   
	   int fidx = 0;
	   
	   
	   /* 브라우저와 다양한 정보 가져오기 */
	   
	   UserAgentStringParser userAgentStringParser = UADetectorServiceFactory.getResourceModuleParser();
	   String browser = null;
	   String browser1 = (userAgentStringParser.parse(request.getHeader("User-Agent"))).getName();
	   String browser2 = (userAgentStringParser.parse(request.getHeader("User-Agent"))).getOperatingSystem().getProducer();
	   String browser3 = (userAgentStringParser.parse(request.getHeader("User-Agent"))).getOperatingSystem().getFamilyName();
	   String browser4 = (userAgentStringParser.parse(request.getHeader("User-Agent"))).getOperatingSystem().getVersionNumber().getMajor();
	   
	   
	   browser = browser1+"/"+browser2+"/"+browser3+"/"+browser4;
	   
	   this.VisitInsert(member_idx, "K", fidx, commonUtil.getURL(request), commonUtil.getIp(request), browser);
	   
	   
   }
   
}