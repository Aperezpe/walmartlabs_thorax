import 'package:flutter/material.dart';
import 'package:thorax_issues/services/api_path.dart';
import 'package:thorax_issues/ui/models/comment.dart';
import 'package:thorax_issues/ui/models/issue.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class APIService {
  Future<List<Issue>> getIssues(int pageNumber, int perPage) async =>
      await getData(
        apiUrl: '${APIUrl.issues(pageNumber, perPage)}',
        headers: {"Authorization": env["GIT_TOKEN"]},
        errMsg: "Failed to load issues",
        builder: (data) => Issue.fromMap(data),
      );

  Future<List<Comment>> getComments(Issue issue) async => await getData(
        apiUrl: '${APIUrl.comments(issue)}',
        headers: {"Authorization": env["GIT_TOKEN"]},
        errMsg: "Failed to load comments",
        builder: (data) => Comment.fromMap(data),
      );

  Future<List<T>> getData<T>({
    @required String apiUrl,
    Map<String, String> headers,
    String errMsg: "Faild to load data",
    @required T builder(Map<String, dynamic> data),
  }) async {
    final response = await http.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      if (jsonData.isEmpty) return [];

      return jsonData.map((data) => builder(data)).toList();
    } else {
      throw Exception(errMsg);
    }
  }
}