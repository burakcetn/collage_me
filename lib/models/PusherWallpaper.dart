class PusherWallpaper {
  String? userName;
  String? token;
  String? photoBase64;

  PusherWallpaper({this.userName, this.token, this.photoBase64});

  PusherWallpaper.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    token = json['token'];
    photoBase64 = json['photoBase64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['token'] = this.token;
    data['photoBase64'] = this.photoBase64;
    return data;
  }
}
