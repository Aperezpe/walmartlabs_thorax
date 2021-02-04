import 'package:flutter/foundation.dart';
import 'package:thorax_issues/ui/models/user.dart';

class Issue {
  Issue({
    @required this.id,
    @required this.title,
    @required this.state,
    @required this.number,
    @required this.user,
    @required this.createdAt,
    @required this.body,
    @required this.commentsURL,
  });

  int id;
  String title;
  String state;
  int number;
  User user;
  DateTime createdAt;
  String body;
  String commentsURL;

  factory Issue.fromMap(Map<String, dynamic> data) {
    final user = User.fromMap(data['user']);
    final date = DateTime.parse(data['created_at']);

    return Issue(
      id: data['id'],
      title: data['title'],
      state: data['state'],
      number: data['number'],
      user: user,
      createdAt: date,
      body: data['body'],
      commentsURL: data['comments_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'state': state,
      'number': number,
      'user': user.toMap(),
      'created_at': createdAt,
      'body': body,
      'comments_url': commentsURL,
    };
  }
}
