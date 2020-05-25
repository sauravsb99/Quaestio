import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/models/user.dart';
import 'package:provider/provider.dart';

class QuestionAdd extends StatefulWidget {
  final String qTopic;
  final String qDescr;
  final String qName;
  // final String qCount;
  final String qTime;
  QuestionAdd({this.qTopic,this.qDescr,this.qName,this.qTime});
  @override
  _QuestionAddState createState() => _QuestionAddState(qTopic: qTopic,qDescr: qDescr,qName:qName,qTime: qTime);
}

class _QuestionAddState extends State<QuestionAdd> {
  File _image;
  String url;
final String qTopic;
  final String qDescr;
  final String qName;
  // final String qCount;
  final String qTime;
String type = 'Text';
Set<String> items;
_QuestionAddState({this.qTopic,this.qDescr,this.qName,this.qTime});
int time = 0;
  int qno=1;
    int groupValue = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  TextEditingController fiveController = TextEditingController();
  TextEditingController sixController = TextEditingController();
  var orderLines = <Map>[];
  @override
  Widget build(BuildContext context) {
    type = type == null ? 'Text' : type;
    items=Set.from(['Text']);
    items.add('Image');
    String err='You Can Choose a Picture from local > 200 KB';
    var image;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: titleController,
                      decoration: new InputDecoration.collapsed(
    hintText: 'Enter the question'
  ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: type,
                    underline: Container(
                      color: Color(0xff43b77d),
                      height: 2.0,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        type = newValue;
                      });
                    },
                    items: items.map((item) {
                      return DropdownMenuItem(
                          value: item, child: Text(item));
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                      onPressed: () async {
                        image = await ImagePicker.pickImage(
                            source: ImageSource.gallery
                        );

                        setState((){
                          if(image.lengthSync()<=204800){
                              _image = image;
                              print('Image Path $_image');
                          }else{
                              _image = null;
                              err='Choose An Image with less size';
                          }
                            }
                        );
                        print(err);
                      }
                    ),
                  ),
                  Text(err,style: TextStyle(color: Colors.red, fontSize: 16.0),),
                  Text(" "),
                  RaisedButton(child: Text("Up"),onPressed: () async {
                    print(err);
                    if ( _image != null ) {
//                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Wait"),));
//                    String err = "Photo Updated";
                    String fileName = basename(
                        'userData'
                    );
                    StorageReference firebaseStorageRef = FirebaseStorage
                        .instance.ref(
                    ).child(
                        fileName
                    );
                    StorageUploadTask uploadTask = firebaseStorageRef
                        .putFile(
                        _image
                    );
                    StorageTaskSnapshot taskSnapshot = await uploadTask
                        .onComplete;
                    var dowurl = await (
                        await uploadTask.onComplete
                    ).ref.getDownloadURL(
                    );
                    if ( uploadTask.isCanceled ) {
                      url = null;
                      err="There Was an Upload Error";
                      _image = null;
                      image = null;
                    }
                    url = dowurl.toString(
                    );
                    setState(() {
                      print("Data Updated");
                      titleController.text=url;
//                      Scaffold.of(context)
//                          .showSnackBar(SnackBar(
//                          content: Text(err),duration: Duration(milliseconds: 200)));
                    });
                  }
                    else{
                    titleController.text=err;
                    }
                    },),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 0,
                    title: TextField(
                      controller: oneController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 0;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 1,
                    title: TextField(
                      controller: twoController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 1;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 2,
                    title: TextField(
                      controller: threeController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 2;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 3,
                    title: TextField(
                      controller: fourController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 3;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 4,
                    title: TextField(
                      controller: fiveController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 4;
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: groupValue,
                    value: 5,
                    title: TextField(
                      controller: sixController,
                    ),
                    onChanged: (t) {
                      setState(() {
                        groupValue = 5;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      var map = {};
                      List<String> all = [];
                      map['qno'] = qno;
                      map['qType'] = type;
                      map['qText'] = titleController.text;
                      all.add(oneController.text);
                      all.add(twoController.text);
                      all.add(threeController.text);
                      all.add(fourController.text);
                      all.add(fiveController.text);
                      all.add(sixController.text);
                      var correct = all[groupValue];
                      // print(correct);
                      map['answer'] = correct;
                      map['options'] = all;
                      orderLines.add(map);
                      // all.removeAt(groupValue);
                      // QuizModel quizModel = QuizModel(
                      //   name: titleController.text,
                      //   correct: correct,
                      //   incorrect: all,
                      // );
                      // print(orderLines);
                      time = int.parse(qTime);
                      // widget.categoryModel.quizList.add(quizModel);
                      setState((){
                        qno = qno+1;
                      });
                      oneController.clear();
                      twoController.clear();
                      threeController.clear();
                      fourController.clear();
                      fiveController.clear();
                      sixController.clear();
                      titleController.clear();
                    },
                    child: Text("ADD"),
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  FlatButton(
                      onPressed: () async{
                        User user = Provider.of<User>(context, listen: false);
                        await DatabaseService(uid: user.uid)
                            .updateQuiz(qName, qTopic, qDescr, qno - 1, time, orderLines);
                        Navigator.pop(context);
                      },
                      child: Text("Submit"),
                      color: Color(0xff43b77d)),
                  Text('You must click ADD for the final Question Also')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}