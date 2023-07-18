class CollageModel {
  List<CollageDtoList>? collageDtoList;
  List<CollagePhoto>? collagePhotos;

  CollageModel({
    this.collageDtoList,
    this.collagePhotos,
  });
}

class CollageDtoList {
  int? collageId;
  String? userId;
  String? collageName;
  int? collageStyle;
  int? collageSize;

  CollageDtoList({
    this.collageId,
    this.userId,
    this.collageName,
    this.collageStyle,
    this.collageSize,
  });
}

class CollagePhoto {
  int? collageId;
  int? index;
  String? photoUrl;

  CollagePhoto({
    this.collageId,
    this.index,
    this.photoUrl,
  });
}
