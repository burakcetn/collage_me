class UserSuggestModel {
  String userName;
  String userId;
  String? imgUrl;

  UserSuggestModel({required this.userName, required this.userId, this.imgUrl});
  factory UserSuggestModel.fromJson(Map<String, dynamic> json) {
    return UserSuggestModel(
        userName: json['userName'],
        userId: json['userId'],
        imgUrl: json['imgUrl']);
  }
}
