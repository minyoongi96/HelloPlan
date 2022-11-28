package kr.calender.frontController;

public class ViewResolver {
	public static String makeView(String nextPage) {
		return "/calender/" + nextPage + ".jsp";
	}
}
