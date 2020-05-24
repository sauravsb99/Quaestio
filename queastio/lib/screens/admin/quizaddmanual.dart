import 'package:flutter/material.dart';
import 'package:queastio/router/router.dart';
import 'package:queastio/shared/constants.dart';

class QuizAddManual extends StatefulWidget {
  final String qTopic;
  QuizAddManual({this.qTopic});
  @override
  _QuizAddManualState createState() => _QuizAddManualState(qTopic : qTopic);
}

class _QuizAddManualState extends State<QuizAddManual> {
  final _formKey = GlobalKey<FormState>();
  final String qTopic;
  _QuizAddManualState({this.qTopic});
  // print(category);
   String _quizName;
   String _quizDesc;
  //  String _quizCount;
   String _quizTime;
  @override
  // print(category);
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
    body: Container(
      padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),
      child : Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            qTopic,
            style: TextStyle(fontSize:MediaQuery.of(context).size.height*0.05, fontWeight: FontWeight.bold)),
          // ),
          SizedBox(height: 30.0),
          Text(
            "Enter the Quiz Name",
            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          TextFormField(
            // decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a Quiz Name' : null,
            onChanged: (val) => setState(() => _quizName = val),
          ),
          SizedBox(height: 30.0),
          Text(
            "Enter the Quiz Description",
            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),
          ),
          TextFormField(
            // decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a Description' : null,
            onChanged: (val) => setState(() => _quizDesc = val),
          ),
          //  SizedBox(height: 30.0),
          // Text(
          //   "Enter the No of Questions",
          //   style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),
          // ),
          // TextFormField(
          //   // decoration: textInputDecoration,
          //   validator: (val) => val.isEmpty ? 'Please enter the No of Questions' : null,
          //   onChanged: (val) => setState(() => _quizCount = val),
          // ),
          SizedBox(height: 30.0),
          Text(
            "Enter the Time Limit",
            style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),
          ),
          TextFormField(
            // decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a Time Limit' : null,
            onChanged: (val) => setState(() => _quizTime = val),
          ),
          // DropdownButtonFormField(
          //   value: _currentSugars ?? '0',
          //   decoration: textInputDecoration,
          //   items: sugars.map((sugar) {
          //     return DropdownMenuItem(
          //       value: sugar,
          //       child: Text('$sugar sugars'),
          //     );
          //   }).toList(),
          //   onChanged: (val) => setState(() => _currentSugars = val ),
          // ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.green,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, QuestionsAddRoute,arguments: {
                'qTopic': qTopic,
                'qDescr': _quizDesc,
                'qName': _quizName,
                // 'qCount': _quizCount,
                'qTime': _quizTime,
      
              });
            }
          ),
        ],
      ),
    ),
    ),
    );
    // return Form(
    //   key: _formKey,
    //   child: Column(
    //     children: <Widget>[
    //       Text(
    //         "Enter Quiz Details",
    //         style: TextStyle(fontSize: 24.0),
    //       ),
    //       SizedBox(height: 10.0),
    //       Text(
    //         "Enter the Quiz Name",
    //         style: TextStyle(fontSize: 14.0),
    //       ),
    //       SizedBox(height: 10.0),
    //       TextFormField(
    //         // decoration: textInputDecoration,
    //         validator: (val) => val.isEmpty ? 'Please enter a Quiz Name' : null,
    //         onChanged: (val) => setState(() => _quizName = val),
    //       ),
    //       SizedBox(height: 10.0),
    //       Text(
    //         "Enter the Quiz Description",
    //         style: TextStyle(fontSize: 14.0),
    //       ),
    //       TextFormField(
    //         // decoration: textInputDecoration,
    //         validator: (val) => val.isEmpty ? 'Please enter a Description' : null,
    //         onChanged: (val) => setState(() => _quizDesc = val),
    //       ),
    //        SizedBox(height: 10.0),
    //       Text(
    //         "Enter the No of Questions",
    //         style: TextStyle(fontSize: 14.0),
    //       ),
    //       TextFormField(
    //         // decoration: textInputDecoration,
    //         validator: (val) => val.isEmpty ? 'Please enter the No of Questions' : null,
    //         onChanged: (val) => setState(() => _quizCount = val),
    //       ),
    //       SizedBox(height: 10.0),
    //       Text(
    //         "Enter the Time Limit",
    //         style: TextStyle(fontSize: 14.0),
    //       ),
    //       TextFormField(
    //         // decoration: textInputDecoration,
    //         validator: (val) => val.isEmpty ? 'Please enter a Time Limit' : null,
    //         onChanged: (val) => setState(() => _quizTime = val),
    //       ),
    //       // DropdownButtonFormField(
    //       //   value: _currentSugars ?? '0',
    //       //   decoration: textInputDecoration,
    //       //   items: sugars.map((sugar) {
    //       //     return DropdownMenuItem(
    //       //       value: sugar,
    //       //       child: Text('$sugar sugars'),
    //       //     );
    //       //   }).toList(),
    //       //   onChanged: (val) => setState(() => _currentSugars = val ),
    //       // ),
    //       SizedBox(height: 20.0),
    //       RaisedButton(
    //         color: Colors.green,
    //         child: Text(
    //           'Submit',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         onPressed: () async {
    //           // String image;
    //           // if(category == "Domain Specific")
    //           //   image = "https://firebasestorage.googleapis.com/v0/b/okkk-810ee.appspot.com/o/aptitude.jpg?alt=media&token=ee80431a-5377-4027-a853-9e6c3171c998";
    //           // else
    //           //   image = "https://firebasestorage.googleapis.com/v0/b/okkk-810ee.appspot.com/o/aptitude.jpg?alt=media&token=ee80431a-5377-4027-a853-9e6c3171c998";
    //           // await DatabaseService().addTopic(category, image, _currentName);
    //           // // print(_currentName);
    //           // // print(_currentSugars);
    //           // // print(_currentStrength);
    //         }
    //       ),
    //     ],
    //   ),
    // );
  }
}