class LogedUserModel {
  String? userId;

  LogedUserModel({
    this.userId,
  });

  factory LogedUserModel.fromJson(Map<String, dynamic> json) {
    return LogedUserModel(
      userId: json['userId'],
    );
  }
}
