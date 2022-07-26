class MapCoffeeUser {
  String? image;
  String? userID;
  String? password;
  String? name;
  String? email;

  MapCoffeeUser(
      {this.image, this.userID, this.password, this.name, this.email});

  MapCoffeeUser.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    userID = json['userID'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}