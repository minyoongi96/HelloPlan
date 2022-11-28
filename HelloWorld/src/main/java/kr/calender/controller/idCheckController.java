package kr.calender.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.google.gson.Gson;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.User;

public class idCheckController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		String user_id = request.getParameter("user_id");
		
		
		int cnt = dao.userIDCheck(user_id);
		Gson gson = new Gson();
		String result = gson.toJson(cnt);
		
		PrintWriter out = response.getWriter();
		out.println(result);
		
		return null;
	}
}
