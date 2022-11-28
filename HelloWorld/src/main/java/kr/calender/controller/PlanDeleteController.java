package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.calender.dao.CalenderMyBatisDAO;

public class PlanDeleteController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		int plan_seq = Integer.parseInt(request.getParameter("plan_seq"));
		
		dao.planDelete(plan_seq);
		
		return "redirect:/index.do";
		//return null;
	}

}
