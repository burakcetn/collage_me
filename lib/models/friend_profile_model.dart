class FriendUserModel {
  CollageDtoList? collageDtoList;
  List<String?>? listProfile;
  List<CollageFriendPhoto>? collageFriendPhotos;
  int? friendsCount;
  bool? checkFriend;
  bool? checkRequest;
  List<Comment>? comments;

  FriendUserModel({
    this.collageDtoList,
    this.listProfile,
    this.collageFriendPhotos,
    this.friendsCount,
    this.checkFriend,
    this.checkRequest,
    this.comments,
  });
}

class CollageDtoList {
  int? collageId;
  dynamic userId;
  String? collageName;
  int? collageStyle;
  dynamic photos;

  CollageDtoList({
    this.collageId,
    this.userId,
    this.collageName,
    this.collageStyle,
    this.photos,
  });
}

class CollageFriendPhoto {
  int? collageId;
  int? index;
  dynamic photoUrl;

  CollageFriendPhoto({
    this.collageId,
    this.index,
    this.photoUrl,
  });
}

class Comment {
  int? id;
  String? content;
  String? writer;
  DateTime? createdAt;

  Comment({
    this.id,
    this.content,
    this.writer,
    this.createdAt,
  });
}
