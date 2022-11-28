package kr.calender.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.Plan;

public class planSelectController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		int plan_seq = Integer.parseInt(request.getParameter("plan_seq"));
		
		Plan plan = dao.planSelect(plan_seq);
		Gson gson = new Gson();
		String result = gson.toJson(plan);

		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		
		return null;
	}

}
