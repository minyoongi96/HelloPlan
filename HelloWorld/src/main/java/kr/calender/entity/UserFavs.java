package kr.calender.entity;

public class UserFavs {
	private int favs_seq;
	private String user_id;
	private int reco_seq;
	private String favs_date;
	
	public UserFavs() {
		super();
	}

	public UserFavs(int favs_seq, String user_id, int reco_seq, String favs_date) {
		super();
		this.favs_seq = favs_seq;
		this.user_id = user_id;
		this.reco_seq = reco_seq;
		this.favs_date = favs_date;
	}

	public int getFavs_seq() {
		return favs_seq;
	}

	public String getUser_id() {
		return user_id;
	}

	public int getReco_seq() {
		return reco_seq;
	}

	public String getFavs_date() {
		return favs_date;
	}

	public void setFavs_seq(int favs_seq) {
		this.favs_seq = favs_seq;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setReco_seq(int reco_seq) {
		this.reco_seq = reco_seq;
	}

	public void setFavs_date(String favs_date) {
		this.favs_date = favs_date;
	}

	@Override
	public String toString() {
		return "UserFavs [favs_seq=" + favs_seq + ", user_id=" + user_id + ", reco_seq=" + reco_seq + ", favs_date="
				+ favs_date + "]";
	}
}
