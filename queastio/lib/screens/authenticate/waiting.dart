import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/models/user.dart';
import 'package:provider/provider.dart';
import 'package:queastio/router/router.dart';
import 'package:queastio/shared/constants.dart';

class Waiting extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);
    void inputData() async {
      print("keri keri");
    final FirebaseUser users = await _auth.currentUser();
    // await users.sendEmailVerification();
    // while(users.isEmailVerified == false){
    // }
    if(users.isEmailVerified){
      print("Ingott verunnillaaaaaa");
      user.isactivated = true;
      // Navigator.pushNamed(context, HomeRoute);
    }
    
  }

    return Scaffold(backgroundColor: Colors.green,
    body: Wrap(
      
      children: <Widget>[Center(),
        Text('A confirmation mail is sent to your mail id please confirm your account'),
      // )
        
        ],
    ),
    floatingActionButton: FloatingActionButton(
      child: Text("Send Confirmation"),
      backgroundColor: Colors.indigo,
      onPressed: (){
      inputData();
    },
    ),
  
    );
  }
}