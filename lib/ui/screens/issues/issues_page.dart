import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thorax_issues/ui/screens/issue/issue_page.dart';
import 'package:thorax_issues/ui/screens/issues/issues_page_model.dart';

class IssuesPage extends StatefulWidget {
  IssuesPage({@required this.model});

  final IssuesPageModel model;

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<IssuesPageModel>(
      create: (_) => IssuesPageModel(),
      child: Consumer<IssuesPageModel>(
        builder: (_, model, __) => IssuesPage(model: model),
      ),
    );
  }

  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  ScrollController _scrollController = ScrollController();
  IssuesPageModel get model => widget.model;

  Icon openStateIcon = Icon(Icons.error_outline, color: Colors.green);
  Icon closedStateIcon = Icon(Icons.cancel_sharp, color: Colors.red);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        model.fetchIssues();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Issues"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Walmart / Thorax", style: TextStyle(fontSize: 22)),
            Text(
              "Issues",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: model.issues.length,
                separatorBuilder: (context, index) => Divider(height: 0.5),
                itemBuilder: (BuildContext context, int index) {
                  return buildListTile(index, context);
                },
              ),
            ),
            model.isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(int index, BuildContext context) {
    return ListTile(
      title: Text(
        model.issues[index].title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('#${model.issues[index].number}'),
      leading:
          model.issues[index].state == "open" ? openStateIcon : closedStateIcon,
      trailing: Icon(Icons.chevron_right),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IssuePage.create(context, model.issues[index]),
        ),
      ),
    );
  }
}
