import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:thorax_issues/services/api_service.dart';
import 'package:thorax_issues/ui/models/comment.dart';

import 'package:thorax_issues/ui/models/issue.dart';
import 'package:thorax_issues/ui/models/user.dart';

class IssuePageModel with ChangeNotifier {
  IssuePageModel({
    @required this.issue,
  }) {
    this.user = issue.user;
    this.isLoading = false;
    this.api = APIService();
    this.comments = [Comment.fromMap(issue.toMap())];
    fetchComments();
  }

  APIService api;
  Issue issue;
  User user;
  bool isLoading;
  List<Comment> comments;

  String getFormattedDate(DateTime date) {
    final DateFormat formatter = DateFormat("MMM d, y");
    return formatter.format(date);
  }

  void fetchComments() async {
    updateWith(isLoading: true);

    List<Comment> fetchedComments = await api.getComments(issue);

    if (fetchedComments.isEmpty) {
      updateWith(isLoading: false);
      return;
    }
    updateWith(comments: fetchedComments);
    updateWith(isLoading: false);
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
