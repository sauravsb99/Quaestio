import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'dart:collection';
import 'package:queastio/models/quiz.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:convert' show utf8;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/home.dart';
import 'package:queastio/services/database.dart';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:queastio/shared/constants.dart';

class AddQuiz extends StatefulWidget {
  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _loadingPath = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.custom;
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  void _openFileExplorer() async {
    setState(() => _loadingPath = true);
    try {
      if (_multiPick) {
        // _pickingType = "csv";
        _path = null;
        _paths = await FilePicker.getMultiFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      } else {
        _paths = null;
        _path = await FilePicker.getFilePath(
            type: _pickingType,
            allowedExtensions: (_extension?.isNotEmpty ?? false)
                ? _extension?.replaceAll(' ', '')?.split(',')
                : null);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null ? _paths.keys.toString() : '...';
    });
  }

  // Quizadd quiz;
  List<List<dynamic>> data = [];
  loadCsv(String path) async {
    print("kerii keriii");
    final x = new File(path).openRead();
    data = await x
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
    //  var jSondata = json.decode(x.toString());

    // List l;
    String name;
    String qTopic;
    String qDesc;
    int qCount;
    int duration;
    // Map m;
    var orderLines = <Map>[];
    var map = {};
    // map['answer'] = "506";
    print(orderLines);
    // int count =0;
    for (dynamic u in data) {
      if (u[0] == "quiz") {
        // var map={};
        name = u[1];
        qTopic = u[2];
        qDesc = u[3];
        qCount = u[4];
        duration = u[5];
        //   map['name'] = name;
        // map['qTopic'] = qTopic;
        // orderLines.add(map);
      } else {
        // Map<String,String> ma;

        var map = {};
        List la = [];
        la.add(u[1].toString());
        la.add(u[2].toString());
        la.add(u[3].toString());
        la.add(u[4].toString());
        print(la);

        map['answer'] = u[0].toString();
        map['options'] = la;
        // map['options']=u[2];
        // map['options']=u[3];
        // map['options']=u[4];
        map['qText'] = u[5];
        map['qType'] = u[6];
        map['qno'] = u[7];
        orderLines.add(map);
      }
    }
    await DatabaseService()
        .updateQuiz(name, qTopic, qDesc, qCount, duration, orderLines);
    // print(data);
    // print(orderLines);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.green,
          title: const Text('Upload .csv File'),
        ),
        body: new Center(
            child: new Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                new ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 200.0),
                  child: new SwitchListTile.adaptive(
                    title: new Text('Pick multiple files',
                        textAlign: TextAlign.right),
                    onChanged: (bool value) =>
                        setState(() => _multiPick = value),
                    value: _multiPick,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: Column(
                    children: <Widget>[
                      new RaisedButton(
                        onPressed: () => _openFileExplorer(),
                        child: new Text("Upload The File/Files"),
                      ),
                    ],
                  ),
                ),
                new Builder(
                  builder: (BuildContext context) => _loadingPath
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: const CircularProgressIndicator())
                      : _path != null || _paths != null
                          ? new Container(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              height: MediaQuery.of(context).size.height * 0.50,
                              child: new Scrollbar(
                                  child: new ListView.separated(
                                itemCount: _paths != null && _paths.isNotEmpty
                                    ? _paths.length
                                    : 1,
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isMultiPath =
                                      _paths != null && _paths.isNotEmpty;
                                  final String name = 'File $index: ' +
                                      (isMultiPath
                                          ? _paths.keys.toList()[index]
                                          : _fileName ?? '...');
                                  final path = isMultiPath
                                      ? _paths.values.toList()[index].toString()
                                      : _path;

                                  return new ListTile(
                                    title: new Text(
                                      name,
                                    ),
                                    subtitle: new Text(path),
                                    onTap: () async {
                                      await loadCsv(path);
                                      // print(data);
                                      //       setState((){
                                      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Quiz Updated")));
                                      // });
                                      // Navigator.pushNamed(context, HomeViewRoute);
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Quiz Updated")));
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        new Divider(),
                              )),
                            )
                          : new Container(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
