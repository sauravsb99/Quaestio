import 'package:flutter/material.dart';
import 'package:queastio/screens/newadmin/NewAdmin.dart';
import 'package:queastio/services/auth.dart';

class NewAdminHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
            child: AdminRegister(),
          ),
        );
//      ),
//    );
  }
}
