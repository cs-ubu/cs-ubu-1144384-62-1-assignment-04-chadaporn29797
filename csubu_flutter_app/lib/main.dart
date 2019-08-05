import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new CSUBUFlutterApp());

}

class CSUBUFlutterApp extends StatelessWidget {

  final appTitle = 'CSUBU App Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: AppHomePage(title: appTitle),
    );
  }

}

class AppHomePage extends StatefulWidget {

  AppHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppHomePageState createState() => _AppHomePageState();

}

class _AppHomePageState extends State<AppHomePage> {

  int _counter = 0;
  var _courses = <dynamic>[ ];




  Future<dynamic> getStudents()async{
    final url = 'http://cs.sci.ubu.ac.th:7512/topic-1/student/_search';
    final query = {
      "query":{
        "match_all": {}
      }
    };
    final respones = await http.post(url, body:query);

    final result = json.decode(respones.body);
    print("---------Result-------");
    print(result);
    return result;


  }

  void _incrementCounter() {
    getStudents();
    setState(() {
      _counter++;
      _courses.add({
        'title': 'Chadaporn netwong',
        'instructor': 'avatar',
        'description': '60114440042'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: _courses.length,
          padding: const EdgeInsets.all(8.0),
          separatorBuilder: (context, i) => const Divider(),
          itemBuilder: (context, i) {
            final course = _courses[i];
            return ListTile(
              title: Row(
                    children: <Widget>[
                      Image.asset('assets/images/csubu-bw.png', width: 48, height: 48),
                      Expanded(child: Text(course['title']))
                    ]
                  ),
              subtitle: Text(course['description'])
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}