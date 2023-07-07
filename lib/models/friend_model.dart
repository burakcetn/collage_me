class FriendModel {
  int friendshipId;
  String userId1;
  String userId2;

  FriendModel({
    required this.friendshipId,
    required this.userId1,
    required this.userId2,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      friendshipId: json['friendshipId'],
      userId1: json['userId1'],
      userId2: json['userId2'],
    );
  }
}
