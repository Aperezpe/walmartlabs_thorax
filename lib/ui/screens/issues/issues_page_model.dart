import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:thorax_issues/services/api_service.dart';

import 'package:thorax_issues/ui/models/issue.dart';

class IssuesPageModel with ChangeNotifier {
  IssuesPageModel({
    this.issues,
    this.pageNumber: 1,
    this.perPage: 10,
    this.isLoading: false,
  }) {
    this.issues = List<Issue>();
    this.api = APIService();
    fetchIssues();
  }

  APIService api;
  List<Issue> issues;
  int pageNumber;
  int perPage;
  bool isLoading;

  void fetchIssues() async {
    updateWith(isLoading: true);
    List<Issue> fetchedIssues = await api.getIssues(pageNumber, perPage);
    if (fetchedIssues.isEmpty) {
      updateWith(isLoading: false);
      return;
    }
    updateWith(issues: fetchedIssues);
    updateWith(pageNumber: ++pageNumber);
    updateWith(isLoading: false);
  }

  void updateWith({
    List<Issue> issues,
    int pageNumber,
    bool isLoading,
  }) {
    if (issues != null) this.issues.addAll(issues);
    this.pageNumber = pageNumber ?? this.pageNumber;
    this.isLoading = isLoading ?? this.isLoading;

    notifyListeners();
  }
}