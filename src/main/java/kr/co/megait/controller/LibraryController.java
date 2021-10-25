package kr.co.megait.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.common.KakaoApi;
import kr.co.megait.common.LocalValue;
import kr.co.megait.dao.LibraryDAO;
import kr.co.megait.dao.MemberDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LibraryController {
	
	private static final Logger logger = LoggerFactory.getLogger(LibraryController.class);

	
	
	/**
	 * 첫번째 메인 홈
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value = "/library_default", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView LibraryDefault(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/library/library_list");
		
		return mv;
	}
	
	/**
	 * 주소를 GPS 로 변경
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */


	   @RequestMapping(value = "/gps_write_default", method = {RequestMethod.GET, RequestMethod.POST})
	   public ModelAndView GPSWriteDefault(HttpServletRequest request, HttpServletResponse respone) throws Exception {
	      ModelAndView mv = new ModelAndView("/Kakao/library_list");
	      
	      CommonUtil CU = new CommonUtil();
	      LocalValue lValue = new LocalValue();
	      KakaoApi KA = new KakaoApi();
	      
	      JSONArray library_list = new JSONArray();
	      JSONObject library_info = new JSONObject();
	      
	      LibraryDAO LD = new LibraryDAO();
	      
	      library_list = LD.LibraryList(0);
	      
	      //위도 경도 만들기
	      /***********************************************************************/
	      
	      int library_idx;
	      String address = "";
	      
	      String latitude = "";
	      String longitude = "";
	      
	      KakaoApi kakaoApi = new KakaoApi();
	      
	      for(int i=0;i<library_list.size();i++) {
	         library_info = (JSONObject)library_list.get(i);
	         
	         library_idx = (Integer)library_info.get("library_idx");
	         address = (String)library_info.get("address");
	         latitude = (String)library_info.get("latitude");
	         
	         
	         double[] coords = {(double)0, (double)0};
	         if(!address.equals("") && address!=null && !address.isEmpty()) {
	            coords = kakaoApi.AddrTocoord(address);
	         }

	         if(latitude.equals("0.0")|| latitude.equals("")|| latitude.isEmpty() || latitude==null ) {
	        	 
	        	 latitude = Double.toString(coords[0]);
	        	 longitude = Double.toString(coords[1]);
	        	 
	        	 LD.GPSUpdate(library_idx, latitude, longitude);
	         }
	         System.out.println(library_idx+"--> latitude : "+latitude+", longitude : "+longitude);
	         
	      }
	      
	      /***********************************************************************/
	      
	      return mv;
	      
	   }
	   
	   
	   /**
	    * 공공 도서관 리스트 api(jsp 연결)
	    * @param request
	    * @param response
	    * @return
	    */
	   
	   
		@RequestMapping(value = "/library_api_default", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView LibraryApiDefault(HttpServletRequest request, HttpServletResponse response) {
			
			ModelAndView mv = new ModelAndView("/library/library_api_default");
			
			return mv;
		}
		
		
		
		/**
		 * 공공 도서관 리스트 api(jsp 없음)
		 * @param request
		 * @param respone
		 * @return
		 * @throws Exception 
		 */
		@ResponseBody
		@RequestMapping(value = "/library_api_default2", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=utf-8")
		public String LibarayApiDefault2(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			
			JSONObject jsonResponse = new JSONObject();
			JSONObject result = new JSONObject();
			JSONObject data_temp = new JSONObject();
			JSONArray data = new JSONArray();
			String msg = null;
			
			CommonUtil CU = new CommonUtil();
			
			try {
				
				msg = CU.StringToBase64Encoding("데이터 전송에 성공하였습니다.");

				LibraryDAO libraryDAO = new LibraryDAO();
				data = libraryDAO.LibraryApiList(1);
				
				int total_count;
				total_count = libraryDAO.LibraryTotal();
				
				result.put("CD", "100");
				result.put("MSG", msg);
				
				jsonResponse.put("RESULT",result);
				jsonResponse.put("TOTAL_COUNT", total_count);
				jsonResponse.put("DATA", data);
				
				
			} catch (Exception e) {
				e.printStackTrace();
				msg = CU.StringToBase64Encoding("서버쪽 문제로 데이터 전송에 실패했습니다.");
				
				result.put("CD", "200");
				result.put("MSG", msg);
				
				jsonResponse.put("RESULT",result);
				jsonResponse.put("TOTAL_COUNT", 0);
				jsonResponse.put("DATA", data);
				
				
			}
			
			return jsonResponse.toJSONString() ;
		}
		
		
		/**
		 * 도서관 위치 클러스터링
		 * @param request
		 * @param response
		 * @return
		 * @throws Exception
		 */
		@ResponseBody
		@RequestMapping(value = "/library_api_default3", method = {RequestMethod.GET, RequestMethod.POST}, produces = "text/plain;charset=utf-8")
		public String LibarayApiDefault3(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			
			JSONObject data = new JSONObject();
			String msg = null;
			
			CommonUtil CU = new CommonUtil();
			
			try {
				
				msg = CU.StringToBase64Encoding("데이터 전송에 성공하였습니다.");

				LibraryDAO libraryDAO = new LibraryDAO();
				data = libraryDAO.LibraryApiList2(0);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return data.toJSONString() ;
		}

		
	    /**
	     * 공공 도서관 상세 페이지 이동
	     * @param request
	     * @param response
	     * @return
	     */
	    
		@RequestMapping(value = "/library_view_default", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView LibraryViewDefault(HttpServletRequest request, HttpServletResponse response) {
			
			ModelAndView mv = new ModelAndView("/library/library_view_default");
			
			return mv;
		}
	    
		
	
}
