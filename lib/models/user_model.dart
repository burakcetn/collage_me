class UserModel {
  String? userId;
  String? username;
  String? normalizedUserName;
  String? imgUrl;

  UserModel({
    this.userId,
    this.username,
    this.normalizedUserName,
    this.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["userId"],
        username: json["username"],
        normalizedUserName: json["normalizedUserName"],
        imgUrl: json["imgUrl"]);
  }
}
