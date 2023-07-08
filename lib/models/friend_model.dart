class FriendModel {
  int friendshipId;
  String userId1;
  String? userId2;
  bool isRequest;

  FriendModel({
    required this.friendshipId,
    required this.userId1,
    required this.userId2,
    required this.isRequest,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      friendshipId: json['friendshipId'],
      userId1: json['userId1'],
      userId2: json['userId2'],
      isRequest: json['isRequest'],
    );
  }
}
