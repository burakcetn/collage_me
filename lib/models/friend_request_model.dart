class FriendRequestModel {
  String? userId;

  FriendRequestModel({this.userId});

  factory FriendRequestModel.fromJson(String userId) {
    return FriendRequestModel(userId: userId);
  }
}
