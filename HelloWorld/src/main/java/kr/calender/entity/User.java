package kr.calender.entity;

public class User {
	private String user_id;
	private String user_pw;
	private String user_nick;
	private String user_hp;
	private String user_email;
	private String user_joindate;
	private char user_type;
	
	public User() {
		super();
	}

	public User(String user_id, String user_pw, String user_nick, String user_hp, String user_email,
			String user_joindate, char user_type) {
		super();
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_nick = user_nick;
		this.user_hp = user_hp;
		this.user_email = user_email;
		this.user_joindate = user_joindate;
		this.user_type = user_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public String getUser_nick() {
		return user_nick;
	}

	public String getUser_hp() {
		return user_hp;
	}

	public String getUser_email() {
		return user_email;
	}

	public String getUser_joindate() {
		return user_joindate;
	}

	public char getUser_type() {
		return user_type;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}

	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public void setUser_joindate(String user_joindate) {
		this.user_joindate = user_joindate;
	}

	public void setUser_type(char user_type) {
		this.user_type = user_type;
	}

	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", user_pw=" + user_pw + ", user_nick=" + user_nick + ", user_hp=" + user_hp
				+ ", user_email=" + user_email + ", user_joindate=" + user_joindate + ", user_type=" + user_type + "]";
	}
}
