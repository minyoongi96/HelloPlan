package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.User;

public class LogoutController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/index.do";
	}

}