package kr.co.megait.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.common.KakaoApi;
import kr.co.megait.dao.MemberDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	
	
	/**
	 * 첫번째 메인 홈
	 * @param request
	 * @param response
	 * @return
	 */
	
	// member_list의 값이 들어온다면 /Member/member_list로 페이지를 넘겨준다.
	@RequestMapping(value = "/member_list", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberDefault(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/Member/member_list");
		
		return mv;
	}
	
	

	/**
	 * 회원가입 페이지로 이동.
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/member_write_default", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberWriteDefault(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/Member/member_write_default");
		
		return mv;
	}
	
	
	/**
	 * 회원 가입 완료
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/member_write_ok", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberWriteOk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView("redirect:member_list");
		
		
		CommonUtil commonUtil = new CommonUtil();
		
		
		// request.setCharacterEncoding("utf-8");
		
		
		
		String member_id = request.getParameter("member_id");
		String member_pwd = request.getParameter("member_pwd");
		member_pwd =commonUtil.getEncrypt(member_pwd);
		
		
		String member_name = request.getParameter("member_name");
		String member_birth = request.getParameter("member_birth");
		String member_phone = request.getParameter("member_phone");
		String member_gender = request.getParameter("member_gender");
		String zipcode = request.getParameter("zipcode");
		String jaddress = request.getParameter("jaddress");
		String raddress = request.getParameter("raddress");
		String address = request.getParameter("address");
		

		String member_del_yn = request.getParameter("member_del_yn");
		
		HashMap<String , String> params = new HashMap();
		params.put("member_id",member_id);
		params.put("member_pwd",member_pwd);
		params.put("member_name",member_name);
		params.put("member_birth",member_birth);
		params.put("member_phone",member_phone);
		params.put("member_gender",member_gender);
		params.put("zipcode",zipcode);
		params.put("jaddress",jaddress);
		params.put("raddress",raddress);
		params.put("address",address);
		params.put("member_del_yn",member_del_yn);
	
		
		System.out.println(params);
		
		
		
		  MemberDAO MD = new MemberDAO();
	      try {
	         MD.MemberInsert(params);
	         
	      } catch (Exception e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	      
	      
	      
		return mv;
	}
	
	/**
	 * 회원 정보 보기
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value = "/member_view_default", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberViewDefault(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/Member/member_view_default");
		
		return mv;
	}
	
	/**
	 * 회원 정보 수정 페이지
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/member_modify_default", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberModifyDefault(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/Member/member_modify_default");
		
		return mv;
	}
	
	
	@RequestMapping(value = "/member_modify_ok", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MemberModifyOk(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelAndView mv = new ModelAndView("redirect:member_view_default");
		
		CommonUtil commonUtil = new CommonUtil();
		
		int current_page = Integer.parseInt(request.getParameter("current_page"));
		int member_idx = Integer.parseInt(request.getParameter("member_idx"));
		String member_id = request.getParameter("member_id");
		String member_pwd = request.getParameter("member_pwd");
		member_pwd =commonUtil.getEncrypt(member_pwd); // 비밀번호 암호화.
		String member_name = request.getParameter("member_name");
		String member_birth = request.getParameter("member_birth");
		String member_phone = request.getParameter("member_phone");
		String member_gender = request.getParameter("member_gender");
		String zipcode = request.getParameter("zipcode");
		String jaddress = request.getParameter("jaddress");
		String raddress = request.getParameter("raddress");
		String address = request.getParameter("address");
	
		// 위도 경도 만들기
		/******************************************************************************/
		String latitude ="";
		String longitude="";
		
		KakaoApi kakaoApi = new KakaoApi();
		
		double[] coords = {(double)0, (double)0};
		if(!raddress.equals("")&& raddress!=null && !raddress.isEmpty()) {
			coords = kakaoApi.AddrTocoord(raddress);
		}else {
			
			if(!jaddress.equals("")&& jaddress!=null && !jaddress.isEmpty()) {
				coords=kakaoApi.AddrTocoord(jaddress);
			}
			
			
		}
		
		latitude = Double.toString(coords[0]);
		longitude= Double.toString(coords[1]);
		
		System.out.println("latiude: "+ latitude+ ", longitude : "+ longitude);
		
		/******************************************************************************/
		
		String member_del_yn = null;
		
		if(request.getParameter("member_del_yn")!=null) {
			member_del_yn = "Y";
		}else {
			member_del_yn = "N";
		}
		System.out.println(member_del_yn);
		
		HashMap<String , String> params = new HashMap();
		params.put("member_idx", String.valueOf(member_idx));
		params.put("member_id",member_id);
		params.put("member_pwd",member_pwd);
		params.put("member_name",member_name);
		params.put("member_birth",member_birth);
		params.put("member_phone",member_phone);
		params.put("member_gender",member_gender);
		params.put("zipcode",zipcode);
		params.put("jaddress",jaddress);
		params.put("raddress",raddress);
		params.put("address",address);
		params.put("latitude",latitude);
		params.put("longitude",longitude);
		params.put("member_del_yn",member_del_yn);
	
		
		System.out.println(params);
		
		
		
		  MemberDAO MD = new MemberDAO();
		  MD.MemberModify(params);
		  
		  mv.addObject("current_page", current_page);
	      mv.addObject("member_idx", member_idx);
		  return mv;
	}
	
	
	
		/**
		 * 비밀번호 수정 페이지
		 * @param request
		 * @param response
		 * @return
		 */
		@RequestMapping(value = "/pwd_modify_default", method = {RequestMethod.GET,RequestMethod.POST})
		public ModelAndView PwdModifyDefault(HttpServletRequest request, HttpServletResponse response) {
			
			ModelAndView mv = new ModelAndView("/Member/pwd_modify_default");
			
			return mv;
		}
		
		
		@RequestMapping(value = "/pwd_modify_ok", method = { RequestMethod.GET, RequestMethod.POST })
		public void PwdModifyOk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		//	ModelAndView mv = new ModelAndView("/index");

			response.setContentType("text/html;charset=UTF-8");

			PrintWriter out = response.getWriter();

			// 세션을 만들기 위해
			HttpSession session = request.getSession();

			int member_idx=  Integer.parseInt(request.getParameter("member_idx"));
			String member_pwd0 = request.getParameter("member_pwd0");
			String member_pwd1 = request.getParameter("member_pwd1");
			
			CommonUtil commonUtil = new CommonUtil();
			member_pwd1 = commonUtil.getEncrypt(member_pwd1);
			
			
			try {	
				
				MemberDAO memberDAO = new MemberDAO();
				
				
				int nflag = memberDAO.MemberPwdCheck(member_idx, member_pwd0);
				
				
				// 
				if (nflag==1) {
					
					memberDAO.PwdUpdate(member_idx, member_pwd1);
					
					out.println("<script>");
					out.println("alert('회원님의 비밀번호가 수정되었습니다.');");
					out.println("location.href='/member_view_default.do'");
					out.println("</script>");
					
					
				}else {
					
					out.println("<script>");
					out.println("alert('회원님의 이전 비밀번호가 틀립니다.');");
					out.println("location.href='/pwd_modify_default.do'");
					out.println("</script>");
				}
				
			

			}	catch (Exception e) {
				e.printStackTrace();
				
			}

		
		}
		
}
