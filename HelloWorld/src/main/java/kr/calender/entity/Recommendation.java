package kr.calender.entity;

public class Recommendation {
	private int reco_seq;
	private int plan_seq;
	private int place_seq;
	private String reco_date;
	
	public Recommendation() {
		super();
	}

	public Recommendation(int reco_seq, int plan_seq, int place_seq, String reco_date) {
		super();
		this.reco_seq = reco_seq;
		this.plan_seq = plan_seq;
		this.place_seq = place_seq;
		this.reco_date = reco_date;
	}

	public int getReco_seq() {
		return reco_seq;
	}

	public int getPlan_seq() {
		return plan_seq;
	}

	public int getPlace_seq() {
		return place_seq;
	}

	public String getReco_date() {
		return reco_date;
	}

	public void setReco_seq(int reco_seq) {
		this.reco_seq = reco_seq;
	}

	public void setPlan_seq(int plan_seq) {
		this.plan_seq = plan_seq;
	}

	public void setPlace_seq(int place_seq) {
		this.place_seq = place_seq;
	}

	public void setReco_date(String reco_date) {
		this.reco_date = reco_date;
	}

	@Override
	public String toString() {
		return "Recommendation [reco_seq=" + reco_seq + ", plan_seq=" + plan_seq + ", place_seq=" + place_seq
				+ ", reco_date=" + reco_date + "]";
	}
}
