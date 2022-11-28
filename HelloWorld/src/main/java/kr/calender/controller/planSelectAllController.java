package kr.calender.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.GsonBuilder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap; 

import kr.calender.dao.CalenderMyBatisDAO;
import kr.calender.entity.Plan;
import kr.calender.entity.User;

public class planSelectAllController implements Controller {

	@Override
	public String requestProcesser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String user_id = user.getUser_id();
		CalenderMyBatisDAO dao = new CalenderMyBatisDAO();
				
		JsonObject obj = new JsonObject();
		List<Plan> planList = dao.planSelectAll(user_id);
				
		
		JsonArray jArray = new JsonArray();
				
		for(Plan vo : planList) {
				
			JsonObject temp = new JsonObject();
			
			String start, end;
			boolean all_day;
				
			if(vo.getAll_day() == 1) {
				start = vo.getPlan_s_date().split(" ")[0] + "T00:01";
				end = vo.getPlan_e_date().split(" ")[0] + "T23:59";
			} else {
				start = vo.getPlan_s_date().split(" ")[0] + "T" + vo.getPlan_s_date().split(" ")[1];
				end = vo.getPlan_e_date().split(" ")[0] + "T" + vo.getPlan_e_date().split(" ")[1];
			}
			
			if(vo.getAll_day() == 1) {
				all_day = true;
			} else {
				all_day = false;
			}
			temp.addProperty("id", vo.getPlan_seq());
			temp.addProperty("title", vo.getPlan_title());
			temp.addProperty("start", start);
			temp.addProperty("end", end);
			temp.addProperty("allDay", all_day);
				
			jArray.add(temp);
					
		}
		obj.add("result", jArray);
		
		Gson gson = new Gson();
		String jsonOutput = gson.toJson(jArray);
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();				
		out.println(jsonOutput);
		
	return null;
}

}
