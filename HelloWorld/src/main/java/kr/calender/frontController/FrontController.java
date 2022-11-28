package kr.calender.frontController;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.calender.controller.Controller;

@WebServlet("*.do")
public class FrontController extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		// 1. 어떤 요청인지 확인(command 구하기)
		String reqPath = request.getRequestURI();
		String cpath = request.getContextPath();
		String command = reqPath.substring(cpath.length());
		String nextPage = null;
		
		// 2. command에 따른 분기작업 (Handler Mapping)
		request.setCharacterEncoding("utf-8");
		Controller controller = null;			// POJO역할을 하는 컨트롤러 인터페이스 선언
		HandlerMapping mapping = new HandlerMapping();
		
		controller = mapping.getController(command);
		nextPage = controller.requestProcesser(request, response);
		
		//3. View(forward) or 다른 컨트롤러(redirect)로 경로 변경 작업(View Resolver)
		if (nextPage != null) {
			if(nextPage.indexOf("redirect:") == -1) {
				// forward
				RequestDispatcher rd = request.getRequestDispatcher(ViewResolver.makeView(nextPage));
				rd.forward(request, response);
			} else {
				// redirect
				response.sendRedirect(cpath + nextPage.split(":")[1]);
			}
		}
	}

}
