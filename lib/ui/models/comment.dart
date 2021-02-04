import 'package:flutter/foundation.dart';
import 'package:thorax_issues/ui/models/user.dart';

class Comment {
  Comment({
    @required this.id,
    @required this.user,
    @required this.createdAt,
    @required this.body,
  });

  int id;
  User user;
  DateTime createdAt;
  String body;

  factory Comment.fromMap(Map<String, dynamic> data) {
    final user = User.fromMap(data['user']);

    var date;
    if (data['created_at'].runtimeType == DateTime) {
      date = data['created_at'];
    } else {
      date = DateTime.parse(data['created_at']);
    }

    return Comment(
      id: data['id'],
      user: user,
      createdAt: date,
      body: data['body'],
    );
  }
}
