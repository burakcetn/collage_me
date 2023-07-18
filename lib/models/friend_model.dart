class FriendModel {
  String? userId;

  FriendModel({this.userId});

  factory FriendModel.fromJson(String userId) {
    return FriendModel(userId: userId);
  }
}
