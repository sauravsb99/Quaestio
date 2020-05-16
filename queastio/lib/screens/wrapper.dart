import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/authenticate/authenticate.dart';
import 'package:queastio/screens/authenticate/waiting.dart';
import 'package:queastio/screens/home/home.dart';
import 'package:queastio/screens/admin/adminhome.dart';
import 'package:queastio/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
//    print(user.uid);
      if(user == null){
        return Authenticate();
      }else {
       return StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,

          builder: (context, snapshot){
            if ( snapshot.hasData ) {
              UserData userData = snapshot.data;
              print(userData.uid);
              if ( userData.role == 'admin' ) {
                return AdminHome(
                );
              }
              else {
                print("ingatt nokkedo");
                // if(userData.)
                if(user.isactivated == false)
                  return Waiting();
                else{
                  return Home(

                );
                }
                
              }
            }
            else {
              return AdminHome(
              );
            }
          }
    );
      // return Authenticate();
  }
//    );
}
}