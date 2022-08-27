
import '../../../../../../auth/domain/models/user_model.dart';

class ConversationModel {
  final String? message, name, picture;
  final UserModel? user;
  final bool? isRead;
  final DateTime? createdAt;

  ConversationModel(
      {this.createdAt,
      this.name,
      this.picture,
      this.isRead,
      this.message,
      this.user});

  static ConversationModel fromJson(dynamic json) => ConversationModel(
      message: json['message'],
      name: json['name'],
      isRead: json['isRead'],
      picture: json['picture'],
      user: json['uuid'],
      createdAt: json['createdAt']);
}
