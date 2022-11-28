package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.Plan;
import kr.calender.entity.User;

public class planUpdateController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		int plan_seq = Integer.parseInt(request.getParameter("plan_seq"));
		String plan_title = request.getParameter("edit_title");
		String plan_s_date = request.getParameter("edit_s_date");
		String plan_e_date = request.getParameter("edit_e_date");
		String plan_desc = request.getParameter("edit_desc");
		//String user_id = user.getUser_id();
		double plan_lat = 0;
		double plan_lon = 0;
		if(request.getParameter("plan_lat") != null && request.getParameter("plan_lat") != "" && request.getParameter("plan_lon") != null && request.getParameter("plan_lon") != "") {
			plan_lat = Double.parseDouble(request.getParameter("plan_lat"));
			plan_lon = Double.parseDouble(request.getParameter("plan_lon"));
		}
		int all_day = Integer.parseInt(request.getParameter("edit_YN"));
		String plan_s_time = request.getParameter("edit_s_time");
		String plan_e_time = request.getParameter("edit_e_time");
		
		if(all_day == 0) {
			plan_s_date += (" " + plan_s_time);
			plan_e_date += (" " + plan_e_time);
		} else {
			plan_s_date += " 00:00";
			plan_e_date += " 23:59";
		}
		
		Plan vo = new Plan();
		vo.setPlan_seq(plan_seq);
		vo.setPlan_title(plan_title);
		vo.setPlan_s_date(plan_s_date);
		vo.setPlan_e_date(plan_e_date);
		vo.setPlan_desc(plan_desc);
		//vo.setUser_id(user_id);
		vo.setPlan_lat(plan_lat);
		vo.setPlan_lon(plan_lon);

		// 하루동안의 종일 스케줄이면 all_day그대로, 이틀이상의 종일 스케줄이면 all_day는 0으
		if(plan_s_date.split(" ")[0].equals(plan_e_date.split(" ")[0])) {			
			vo.setAll_day(all_day);
		} else {
			vo.setAll_day(0);
		}
		
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		dao.planUpdate(vo);
		
		return "redirect:/index.do";
	}

}
