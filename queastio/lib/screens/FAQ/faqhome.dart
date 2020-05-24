import 'package:flutter/material.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/screens/FAQ/faq_list.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class FaqHome extends StatefulWidget {
  @override
  _FaqHomeState createState() => _FaqHomeState();
}

class _FaqHomeState extends State<FaqHome> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String _question;
  String _answer;
  void _addFaq(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Enter the question: '),
                  SizedBox(height: 30.0),
                  TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    // decoration: InputDecoration(
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a Batch name' : null,
                    onChanged: (val) {
                      setState(() => _question = val);
                    },
                  ),
                  SizedBox(height: 50.0),
                  Text('Enter the answer: '),
                  SizedBox(height: 30.0),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a Batch name' : null,
                    onChanged: (val) {
                      setState(() => _answer = val);
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService()
                            .addFaq(_question, _answer)
                            .then((result) {
                          Navigator.pop(context);
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return StreamProvider<List<Faq>>.value(
      initialData: List(),
      value: DatabaseService().faqs,
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            UserData userData = snapshot.data;
            return Container(
              child: Scaffold(
                appBar: AppBar(
                  actions: <Widget>[
                    userData.role == 'admin'
                        ? IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _addFaq(context);
                            },
                          )
                        : Container()
                  ],
                ),
                backgroundColor: Colors.white,

//          drawer: MyDrawer(),

                body: Container(
                  padding: const EdgeInsets.all(4.0),
                  child: FaqList(),
                ),
              ),
            );
          }),
    );
  }
}
