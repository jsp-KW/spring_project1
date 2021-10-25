package kr.co.megait.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class WebProjectController {
	
	private static final Logger logger = LoggerFactory.getLogger(WebProjectController.class);

	
	
	/**
	 * 첫번째 메인 홈
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView WebProjectDefault1(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mv = new ModelAndView("/index");
		
		return mv;
	}
	
	/**
	 * 두번째 메인 홈
	 * @param request
	 * @param response
	 * @return
	 */
	
	@RequestMapping(value = "/index", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView WebProjectDefault2(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView("/index");
		
		return mv;
	}
	
	
	@RequestMapping(value = "/main_index", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView MainIndexDefault(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView("/main_index");
		
		return mv;
	}
	
	
}
