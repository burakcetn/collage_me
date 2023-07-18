class UserModel {
  String? userId;
  String? username;
  String? normalizedUserName;
  String? imgUrl;
  int? friendsCount;

  UserModel(
      {this.userId,
      this.username,
      this.normalizedUserName,
      this.imgUrl,
      this.friendsCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["userId"],
        username: json["username"],
        normalizedUserName: json["normalizedUserName"],
        imgUrl: json["imgUrl"],
        friendsCount: json["friendsCount"]);
  }
}
