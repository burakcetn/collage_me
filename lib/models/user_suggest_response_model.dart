class UserSuggestModel {
  String userName;
  String firstName;
  String lastName;
  String userId;

  UserSuggestModel({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.userId,
  });
  factory UserSuggestModel.fromJson(Map<String, dynamic> json) {
    return UserSuggestModel(
      userName: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userId: json['userId'],
    );
  }
}
