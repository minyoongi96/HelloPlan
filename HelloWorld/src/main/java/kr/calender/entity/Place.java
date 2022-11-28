package kr.calender.entity;

public class Place {
	private int place_seq;
	private String place_name;
	private double latitude;
	private double longitude;
	private String address;
	private String place_tel;
	private String category;
	private String photo1;
	private String photo2;
	private String photo3;
	private String photo4;
	
	public Place() {
		super();
	}

	public Place(int place_seq, String place_name, double latitude, double longitude, String address, String place_tel,
			String category, String photo1, String photo2, String photo3, String photo4) {
		super();
		this.place_seq = place_seq;
		this.place_name = place_name;
		this.latitude = latitude;
		this.longitude = longitude;
		this.address = address;
		this.place_tel = place_tel;
		this.category = category;
		this.photo1 = photo1;
		this.photo2 = photo2;
		this.photo3 = photo3;
		this.photo4 = photo4;
	}

	public int getPlace_seq() {
		return place_seq;
	}

	public String getPlace_name() {
		return place_name;
	}

	public double getLatitude() {
		return latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public String getAddress() {
		return address;
	}

	public String getPlace_tel() {
		return place_tel;
	}

	public String getCategory() {
		return category;
	}

	public String getPhoto1() {
		return photo1;
	}

	public String getPhoto2() {
		return photo2;
	}

	public String getPhoto3() {
		return photo3;
	}

	public String getPhoto4() {
		return photo4;
	}

	public void setPlace_seq(int place_seq) {
		this.place_seq = place_seq;
	}

	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setPlace_tel(String place_tel) {
		this.place_tel = place_tel;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setPhoto1(String photo1) {
		this.photo1 = photo1;
	}

	public void setPhoto2(String photo2) {
		this.photo2 = photo2;
	}

	public void setPhoto3(String photo3) {
		this.photo3 = photo3;
	}

	public void setPhoto4(String photo4) {
		this.photo4 = photo4;
	}

	@Override
	public String toString() {
		return "Place [place_seq=" + place_seq + ", place_name=" + place_name + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", address=" + address + ", place_tel=" + place_tel + ", category="
				+ category + ", photo1=" + photo1 + ", photo2=" + photo2 + ", photo3=" + photo3 + ", photo4=" + photo4
				+ "]";
	}
}
