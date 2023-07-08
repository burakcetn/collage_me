class UserSuggestModel {
  String userName;
  String userId;

  UserSuggestModel({
    required this.userName,
    required this.userId,
  });
  factory UserSuggestModel.fromJson(Map<String, dynamic> json) {
    return UserSuggestModel(
      userName: json['userName'],
      userId: json['userId'],
    );
  }
}
