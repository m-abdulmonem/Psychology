class MessageModel {
  Author? author;
  int? createdAt;
  String? id;
  String? status;
  String? text;
  String? type;

  MessageModel(
      {this.author,
        this.createdAt,
        this.id,
        this.status,
        this.text,
        this.type});

  MessageModel.fromJson(Map<String, dynamic> json) {
    author =
    json['author'] != null ? Author.fromJson(json['author']) : null;
    createdAt = json['createdAt'];
    id = json['id'];
    status = json['status'];
    text = json['text'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['status'] = status;
    data['text'] = text;
    data['type'] = type;
    return data;
  }
}

class Author {
  String? firstName;
  String? id;
  String? imageUrl;

  Author({this.firstName, this.id, this.imageUrl});

  Author.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    id = json['id'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    return data;
  }
}