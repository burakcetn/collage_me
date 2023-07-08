class UserSearchModel {
  String userName;
  String userId;

  UserSearchModel({
    required this.userName,
    required this.userId,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      userName: json['userName'],
      userId: json['userId'],
    );
  }
}
