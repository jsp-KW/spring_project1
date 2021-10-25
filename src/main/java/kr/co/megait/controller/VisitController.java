package kr.co.megait.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.megait.common.CommonUtil;
import kr.co.megait.dao.LoginDAO;
import kr.co.megait.dao.MemberDAO;
import kr.co.megait.dao.VisitDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class VisitController {

	private static final Logger logger = LoggerFactory.getLogger(VisitController.class);

	/**
	 * 방문자 데이터 가져오기.
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/visit_statistics_default", method = { RequestMethod.GET,
			RequestMethod.POST }, produces = "text/plain;charset=utf-8")
	public String VisitStatisticsDefault(HttpServletRequest request, HttpServletResponse response) throws Exception {

		CommonUtil commonUtil = new CommonUtil();
		VisitDAO visitDAO = new VisitDAO();
		JSONArray visit_list = new JSONArray();

		String type = request.getParameter("type");

		//날짜 구하기
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar  currentCalendar  = Calendar.getInstance();
		String result = null;
		
		if (type.equals("7")) {
			
			currentCalendar.add(currentCalendar.DATE, -7);
			String strYear =  Integer.toString(currentCalendar.get(Calendar.YEAR));
			String strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
			String strDay = df.format(currentCalendar.get(Calendar.DATE));
			String strDate = strYear + "-" + strMonth+"-"+strDay;
			
			visit_list = visitDAO.VisitList("7", strDate , "");

		} else if (type.equals("30")) {
			
			currentCalendar.add(currentCalendar.MONTH, -1);
			String strYear =  Integer.toString(currentCalendar.get(Calendar.YEAR));
			String strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
			String strDay = df.format(currentCalendar.get(Calendar.DATE));
			String strDate = strYear + "-" + strMonth+"-"+strDay;
			
			visit_list = visitDAO.VisitList("30", strDate , "");

		} else if (type.equals("180")) {
			currentCalendar.add(currentCalendar.MONTH, -6);
			String strYear =  Integer.toString(currentCalendar.get(Calendar.YEAR));
			String strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
			String strDay = df.format(currentCalendar.get(Calendar.DATE));
			String strDate = strYear + "-" + strMonth+"-"+strDay;
			
			visit_list = visitDAO.VisitList("180", strDate , "");

		} else if (type.equals("365")) {
			currentCalendar.add(currentCalendar.YEAR, -1);
			String strYear =  Integer.toString(currentCalendar.get(Calendar.YEAR));
			String strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
			String strDay = df.format(currentCalendar.get(Calendar.DATE));
			String strDate = strYear + "-" + strMonth+"-"+strDay;
			
			visit_list = visitDAO.VisitList("365", strDate , "");

		} else {
			visit_list = visitDAO.VisitList("A", "", "");

		}

		

		return visit_list.toJSONString();
	}

}
