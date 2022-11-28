package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.User;

public class UserDeleteController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String user_id = user.getUser_id();
		
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
		
		dao.userDelete(user_id);
		session.invalidate();

		return "redirect:/index.do";
	}
}

