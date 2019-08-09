
class UserModel {
    String email;
    int id;
    String name;
    String picture;

    UserModel({
        this.email,
        this.id,
        this.name,
        this.picture,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
        "name": name,
        "picture": picture,
    };
    
  static List<UserModel> fromJsonList(List jsonList) {
    if (jsonList == null)
      return null;
    else
      return jsonList.map((item) => UserModel.fromJson(item)).toList();
  }
}
