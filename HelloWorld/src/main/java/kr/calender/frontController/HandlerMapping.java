package kr.calender.frontController;

import java.util.HashMap;
import kr.calender.controller.*;

public class HandlerMapping {
	private HashMap<String, Controller> mappings = new HashMap<String, Controller>();
	
	public HandlerMapping() {
		// 컨트롤러 추가하기
		mappings.put("/index.do", new IndexController());
		mappings.put("/login.do", new LoginController());
		mappings.put("/logout.do", new LogoutController());
		mappings.put("/userDelete.do", new UserDeleteController());
		mappings.put("/userInsert.do", new UserInsertController());
		mappings.put("/signIn.do", new SignInFormController());
		mappings.put("/planInsertForm.do", new PlanInsertFormController());
		mappings.put("/planInsert.do", new PlanInsertController());
		mappings.put("/planDelete.do", new PlanDeleteController());
		mappings.put("/idCheck.do", new idCheckController());
		mappings.put("/planSelectAll.do", new planSelectAllController());
		mappings.put("/planSelect.do", new planSelectController());
		mappings.put("/planUpdate.do", new planUpdateController());
	}
	
	public Controller getController(String command) {
		return mappings.get(command);
	}
}
