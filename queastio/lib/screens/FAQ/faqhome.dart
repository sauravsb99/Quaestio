import 'package:flutter/material.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/screens/FAQ/faq_list.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';

class FaqHome extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Faq>>.value(
      initialData: List(),
      value: DatabaseService().faqs,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.black26,

//          drawer: MyDrawer(),

          body: FaqList(),
        ),
      ),
    );
  }
}
