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
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	/**
	 * 공지사항 리스트 페이지
	 * 
	 * @param request
	 * @param response
	 * @return
	 */

	@RequestMapping(value = "/notice_default", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView NoticeDefault(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView("/notice/notice_default");

		return mv;
	}

	
	
	/**
	 * 공지사항 정보보기
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value = "/notice_view", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView NoticeViewDefault(HttpServletRequest request, HttpServletResponse response) {

		ModelAndView mv = new ModelAndView("/notice/notice_view");

		return mv;
	}
	

}
