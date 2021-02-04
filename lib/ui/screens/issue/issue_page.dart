import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thorax_issues/ui/models/comment.dart';
import 'package:thorax_issues/ui/models/issue.dart';
import 'package:thorax_issues/ui/screens/issue/issue_page_model.dart';

class IssuePage extends StatelessWidget {
  IssuePage({@required this.model});

  final IssuePageModel model;

  static Widget create(BuildContext context, Issue issue) {
    return ChangeNotifierProvider<IssuePageModel>(
      create: (_) => IssuePageModel(context: context, issue: issue),
      child: Consumer<IssuePageModel>(
        builder: (_, model, __) => IssuePage(model: model),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Issue #${model.issue.number}"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Walmart / Thorax", style: TextStyle(fontSize: 22)),
            buildHeader(),
            Divider(thickness: 2),
            model.isLoading
                ? Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
                    child: Container(
                      height: 200.0,
                      child: ListView.separated(
                        itemCount: model.comments.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 2,
                          thickness: 1.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return buildCommentBox(model.comments[index]);
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: RichText(
            text: TextSpan(
              text: model.issue.title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: " #${model.issue.number}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Container(
            padding: EdgeInsets.all(5),
            width: 80,
            decoration: BoxDecoration(
              color: model.issue.state == "open" ? Colors.green : Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(model.stateIcon, color: Colors.white),
                Text(model.issue.state, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCommentBox(Comment comment) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15),
                  height: 50,
                  child: ClipOval(
                    child: Image.network(comment.user.avatarUrl),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${comment.user.login}",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    children: <TextSpan>[
                      TextSpan(
                        text: " - ${model.getFormattedDate(comment.createdAt)}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(comment.body),
        ],
      ),
    );
  }
}
