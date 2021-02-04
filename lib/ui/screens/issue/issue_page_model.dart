import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thorax_issues/services/api_service.dart';
import 'package:thorax_issues/ui/models/comment.dart';

import 'package:thorax_issues/ui/models/issue.dart';
import 'package:thorax_issues/ui/models/user.dart';

class IssuePageModel with ChangeNotifier {
  IssuePageModel({
    @required this.issue,
    @required this.context,
  }) {
    this.user = issue.user;
    this.isLoading = false;
    this.api = APIService();
    this.comments = [Comment.fromMap(issue.toMap())];
    fetchComments(context);
  }

  APIService api;
  Issue issue;
  User user;
  bool isLoading;
  List<Comment> comments;
  BuildContext context;

  String getFormattedDate(DateTime date) {
    final DateFormat formatter = DateFormat("MMM d, y");
    return formatter.format(date);
  }

  Future<void> fetchComments(BuildContext context) async {
    try {
      updateWith(isLoading: true);
      List<Comment> fetchedComments = await api.getComments(issue);
      if (fetchedComments.isEmpty) return;
      updateWith(comments: fetchedComments);
    } catch (e) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        },
      );
    } finally {
      updateWith(isLoading: false);
    }
  }

  void updateWith({
    Issue issue,
    bool isLoading,
    List<Comment> comments,
  }) {
    if (comments != null) this.comments.addAll(comments);
    this.isLoading = isLoading ?? this.isLoading;
    notifyListeners();
  }
}
