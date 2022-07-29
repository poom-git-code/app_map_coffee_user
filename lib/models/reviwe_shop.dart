class ReviweShop {
  String? image;
  String? emailPath;
  String? name;
  String? comment;
  double? starType;

  ReviweShop(
      {this.image, this.emailPath, this.name, this.comment, this.starType});

  ReviweShop.fromJson(Map<String, dynamic> json) {
    image = json['Image'];
    emailPath = json['EmailPath'];
    name = json['Name'];
    comment = json['Comment'];
    starType = json['StarType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Image'] = this.image;
    data['EmailPath'] = this.emailPath;
    data['Name'] = this.name;
    data['Comment'] = this.comment;
    data['StarType'] = this.starType;
    return data;
  }
}