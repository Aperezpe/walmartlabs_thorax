import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:thorax_issues/ui/models/issue.dart';

class IssuesPage extends StatefulWidget {
  @override
  _IssuesPageState createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  List<Issue> issues = List();
  int pageNumber = 1;
  int perPage = 10;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchTen();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchTen();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            // Heading
            Text("Walmart / Thorax", style: TextStyle(fontSize: 22)),
            Text(
              "Issues",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                itemCount: issues.length,
                separatorBuilder: (context, index) => Divider(height: 0.5),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(issues[index].title),
                    subtitle: Text('#${issues[index].number}'),
                    leading: issues[index].state == "open"
                        ? Icon(Icons.error_outline, color: Colors.green)
                        : Icon(Icons.cancel_sharp, color: Colors.red),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  );
                },
              ),
            ),

            isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),

            // TODO: Fetch Github Issues and show as List Tile
            // build
          ],
        ),
      ),
    );
  }

  void fetchTen() async {
    try {
      setState(() => isLoading = true);
      final response = await http.get(
          "https://api.github.com/repos/walmartlabs/thorax/issues?page=$pageNumber&per_page=$perPage",
          headers: {"Authorization": env["GIT_TOKEN"]});

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        setState(() {
          for (var data in jsonData) {
            issues.add(Issue.fromMap(data));
          }
        });
        pageNumber++;
      } else {
        throw Exception('Failed to load issues');
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() => isLoading = false);
    }
  }
}
