package kr.co.megait.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;

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
import kr.co.megait.dao.LoginDAO;
import kr.co.megait.dao.MemberDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	/**
	 * 로그인 페이지
	 * 
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/login_default", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView LoginDefault(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView("/Login/login_default");

		return mv;
	}

	/**
	 * 로그인 성공시 홈으로
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException 
	 */

	@RequestMapping(value = "/login_ok", method = { RequestMethod.GET, RequestMethod.POST })
	public void LoginOk(HttpServletRequest request, HttpServletResponse response) throws IOException {

	//	ModelAndView mv = new ModelAndView("/index");

		// html을 만들기 위해
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		// 세션을 만들기 위해
		HttpSession session = request.getSession();

		// 로그인 완료
		String member_id = request.getParameter("member_id");
		String member_pwd = request.getParameter("member_pwd");
		
		CommonUtil CU = new CommonUtil();
		member_pwd = CU.getEncrypt(member_pwd);
		
		int nflag = 0;
		try {
			LoginDAO loginDAO = new LoginDAO();
			nflag = loginDAO.LoginCheck(member_id, member_pwd);
			System.out.println(nflag);

			if (nflag==2) {

				MemberDAO memberDAO = new MemberDAO();
				LinkedHashMap member_info = new LinkedHashMap();
				member_info = memberDAO.MemberInfo2(member_id, member_pwd);

				System.out.println("로그인 성공");
				session.setAttribute("member_idx", (Integer) member_info.get("member_idx"));
				session.setAttribute("member_id", member_id);
				session.setAttribute("member_pwd", member_pwd);
				session.setAttribute("member_name", (String) member_info.get("member_name"));
				session.setAttribute("member_phone", (String) member_info.get("member_phone"));
				session.setAttribute("member_birth", (String) member_info.get("member_birth"));

			
				
				response.sendRedirect("/");
				
			}else if (nflag==1) { // 비밀번호가 틀린경우
				
				System.out.println("로그인 실패: 비밀번호가 틀립니다.");
				out.println("<script>");
				out.println("alert('비밀번호가 틀립니다. 확인해 주세요.');");
				out.println("location.href='/login_default.do'");
				out.println("</script>");
				
			
			}else { // 아이디 비번 다 틀린경우
			
				System.out.println("로그인 실패 : 회원 아이디가 틀립니다.");
				out.println("<script>");
				out.println("alert('아이디 틀립니다. 확인해 주세요.');");
				out.println("location.href='/login_default.do'");
				out.println("</script>");
				
			//	response.sendRedirect("/login_default.do");
			}

		}	catch (Exception e) {
			e.printStackTrace();
			
		}

	
	}
	
	/**
	 * 로그아웃
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	
	// 로그아웃은 db하고 상관없음. 그냥 세션과의 문제 
	@RequestMapping(value = "/logout_ok", method = { RequestMethod.GET, RequestMethod.POST })
	public void LoginOut(HttpServletRequest request, HttpServletResponse response) throws IOException {

	//	ModelAndView mv = new ModelAndView("/index");

		response.setContentType("text/html;charset=UTF-8");

		PrintWriter out = response.getWriter();

		// 세션을 만들기 위해
		HttpSession session = request.getSession();

	
		
		int nflag = 0;
		try {	
			
			session.invalidate(); // 세션 정보 삭제.
			System.out.println("로그아웃 되었습니다.");
			out.println("<script>");
			out.println("alert('로그아웃 되었습니다.');");
			out.println("location.href='/'");
			out.println("</script>");
		

		}	catch (Exception e) {
			e.printStackTrace();
			
		}

	
	}

}
