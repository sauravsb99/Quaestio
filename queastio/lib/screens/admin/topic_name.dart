// import 'package:flutter/material.dart'
import 'package:flutter/material.dart';
import 'package:queastio/services/database.dart';

class TopicAdd extends StatefulWidget {
  final String category;
  TopicAdd({this.category});
  @override
  _TopicAddState createState() => _TopicAddState(category: category);
}

class _TopicAddState extends State<TopicAdd> {
  final String category;
  _TopicAddState({this.category});
  final _formKey = GlobalKey<FormState>();
  // print(category);
   String _currentName;
   String image;
  @override
  // print(category);
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            category,
            style: TextStyle(fontSize: 28.0),
          ),
          SizedBox(height: 30.0),
          Text(
            "Enter the Subject Name*",
            style: TextStyle(fontSize: 22.0),
          ),
          // SizedBox(height: 30.0),
          TextFormField(
            // decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please enter a Subject' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 30.0),
           Text(
            "Enter the Image url",
            style: TextStyle(fontSize: 22.0),
          ),
          TextFormField(
            // decoration: textInputDecoration,
            // validator: (val) => val.isEmpty ? 'Please enter ' : null,
            onChanged: (val) => setState(() => image = val),
          ),
          // SizedBox(height: 10.0),
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
            onPressed: () async {
              // String image;
              if(image == null)
                image = "https://firebasestorage.googleapis.com/v0/b/okkk-810ee.appspot.com/o/aptitude.jpg?alt=media&token=ee80431a-5377-4027-a853-9e6c3171c998";
              // else
                // image = "https://firebasestorage.googleapis.com/v0/b/okkk-810ee.appspot.com/o/aptitude.jpg?alt=media&token=ee80431a-5377-4027-a853-9e6c3171c998";
              await DatabaseService().addTopic(category, image, _currentName,'Pharma');
              Navigator.pop(context);
              // print(_currentName);
              // print(_currentSugars);
              // print(_currentStrength);
            }
          ),
        ],
      ),
    );
  }
}