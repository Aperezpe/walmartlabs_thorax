import 'package:thorax_issues/ui/models/issue.dart';

abstract class Database {
  Future<List<Issue>> getIssues();
  Future<Issue> getIssue(int id);
}
