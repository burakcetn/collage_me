class UserSearchModel {
  String userName;
  String firstName;
  String lastName;
  String userId;

  UserSearchModel({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.userId,
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userId: json['userId'],
    );
  }
}
