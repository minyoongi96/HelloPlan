package kr.calender.entity;

public class Plan {
	private int plan_seq;
	private String plan_title;
	private String plan_s_date;
	private String plan_e_date;
	private String plan_desc;
	private String user_id;
	private double plan_lat;
	private double plan_lon;
	private int all_day;
	
	public Plan() {
		super();
	}

	public Plan(int plan_seq, String plan_title, String plan_s_date, String plan_e_date, String plan_desc,
			String user_id, double plan_lat, double plan_lon, int all_day) {
		super();
		this.plan_seq = plan_seq;
		this.plan_title = plan_title;
		this.plan_s_date = plan_s_date;
		this.plan_e_date = plan_e_date;
		this.plan_desc = plan_desc;
		this.user_id = user_id;
		this.plan_lat = plan_lat;
		this.plan_lon = plan_lon;
		this.all_day = all_day;
		
	}

	public int getPlan_seq() {
		return plan_seq;
	}

	public String getPlan_title() {
		return plan_title;
	}

	public String getPlan_s_date() {
		return plan_s_date;
	}

	public String getPlan_e_date() {
		return plan_e_date;
	}

	public String getPlan_desc() {
		return plan_desc;
	}

	public String getUser_id() {
		return user_id;
	}

	public double getPlan_lat() {
		return plan_lat;
	}

	public double getPlan_lon() {
		return plan_lon;
	}
	
	public int getAll_day() {
		return all_day;
	}

	public void setPlan_seq(int plan_seq) {
		this.plan_seq = plan_seq;
	}

	public void setPlan_title(String plan_title) {
		this.plan_title = plan_title;
	}

	public void setPlan_s_date(String plan_s_date) {
		this.plan_s_date = plan_s_date;
	}

	public void setPlan_e_date(String plan_e_date) {
		this.plan_e_date = plan_e_date;
	}

	public void setPlan_desc(String plan_desc) {
		this.plan_desc = plan_desc;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setPlan_lat(double plan_lat) {
		this.plan_lat = plan_lat;
	}

	public void setPlan_lon(double plan_lon) {
		this.plan_lon = plan_lon;
	}
	
	public void setAll_day(int all_day) {
		this.all_day = all_day;
	}

	@Override
	public String toString() {
		return "Plan [plan_seq=" + plan_seq + ", plan_title=" + plan_title + ", plan_s_date=" + plan_s_date
				+ ", plan_e_date=" + plan_e_date + ", plan_desc=" + plan_desc + ", user_id=" + user_id + ", plan_lat="
				+ plan_lat + ", plan_lon=" + plan_lon + ", all_day=" + all_day + "]";
	}

	
}
