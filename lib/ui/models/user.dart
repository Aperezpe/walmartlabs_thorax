import 'package:flutter/foundation.dart';

class User {
  User({
    @required this.id,
    @required this.login,
    @required this.avatarUrl,
  });

  int id;
  String login;
  String avatarUrl;

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      login: data['login'],
      avatarUrl: data['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
    };
  }
}
