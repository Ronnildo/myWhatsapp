class UserModel {
  String? name;
  String? email;
  String? password;

  UserModel(
    this.name,
    this.email,
    this.password,
  );

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
    };
    return map;
  }
}
