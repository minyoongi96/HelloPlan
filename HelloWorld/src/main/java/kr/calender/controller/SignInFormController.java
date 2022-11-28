package kr.calender.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignInFormController implements Controller{

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		return "SignIn";	// main.jsp
	}
}
