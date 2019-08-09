import 'user_model.dart';

class MessageModel {
  UserModel user;
  String content;
  int id;

  MessageModel({
    this.user,
    this.content,
    this.id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        user: UserModel.fromJson(json["user"]),
        content: json["content"],
        id: json["id"],
      );

  static List<MessageModel> fromJsonList(List jsonList) {
    if (jsonList == null)
      return null;
    else
      return jsonList
        .map((item) => MessageModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "content": content,
        "id": id,
      };
}
