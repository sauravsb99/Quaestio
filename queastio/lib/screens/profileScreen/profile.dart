import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/screens/profileScreen/Userput.dart';
import 'package:queastio/services/database.dart';
//import 'Usercontroller.dart';


    class ProfileScreen extends StatelessWidget {
      @override


      Widget build(BuildContext context) {



        return StreamProvider<UserData>.value(

          value: DatabaseService().userData,
          child: Container(
            child: Scaffold(
              drawer: MyDrawer(),

              body: Userput(),
            ),
          ),
        );
        }
      }


