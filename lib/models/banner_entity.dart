class BannerEntity {
	String image;
	String title;
	String url;

	BannerEntity({this.image, this.title, this.url});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}
