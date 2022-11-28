package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.User;

public class LoginController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		User vo = new User();
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		
		vo.setUser_id(user_id);
		vo.setUser_pw(user_pw);
		
		User user = dao.userLogin(vo);
		
		if(user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
		}
		
		return "redirect:/index.do";
	}
}

