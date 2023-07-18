class CommentModel {
  int? id;
  String? content;
  String? writer;
  DateTime? createdAt;

  CommentModel({
    this.id,
    this.content,
    this.writer,
    this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'],
        content: json['content'],
        writer: json['writer'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'writer': writer,
        'createdAt': createdAt?.toIso8601String(),
      };
}
