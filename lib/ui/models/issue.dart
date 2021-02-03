import 'package:flutter/foundation.dart';

class Issue {
  Issue({
    @required this.id,
    @required this.title,
    @required this.state,
    @required this.number,
    // @required this.user,
  });

  int id;
  String title;
  String state;
  int number;
  // DateTime createdAt;
  // String body;
  // String commentsURL;
  // User user;

  factory Issue.fromMap(Map<String, dynamic> data) {
    return Issue(
      id: data['id'],
      title: data['title'],
      state: data['state'],
      number: data['number'],
    );
  }
}
