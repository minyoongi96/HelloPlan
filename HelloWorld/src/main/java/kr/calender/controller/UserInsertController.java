package kr.calender.controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.User;
public class UserInsertController implements Controller {
	
	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		
		CalenderMyBatisDAO dao= new CalenderMyBatisDAO();
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_nick = request.getParameter("user_nick");
		String user_hp = request.getParameter("user_hp");
		String user_email = request.getParameter("user_email");
		
		User vo = new User();
		
		vo.setUser_id(user_id);
		vo.setUser_pw(user_pw);
		vo.setUser_nick(user_nick);
		vo.setUser_hp(user_hp);
		vo.setUser_email(user_email);
		
			
		dao.userInsert(vo);
			
		return "redirect:/index.do";
	}
}