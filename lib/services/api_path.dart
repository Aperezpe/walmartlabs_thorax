import 'package:thorax_issues/ui/models/issue.dart';

class APIUrl {
  static String issues(int pageNumber, int perPage) =>
      'https://api.github.com/repos/walmartlabs/thorax/issues?page=$pageNumber&per_page=$perPage';

  static String comments(Issue issue) =>
      "https://api.github.com/repos/walmartlabs/thorax/issues/${issue.number}/comments";
}
