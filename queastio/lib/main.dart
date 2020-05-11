import 'package:flutter/material.dart';
import 'package:queastio/screens/FAQ/faqhome.dart';
import 'package:queastio/screens/home/question_card.dart';
import 'package:queastio/screens/profileScreen/profile.dart';
import 'package:queastio/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/shared/constants.dart';
import 'models/user.dart';
import 'package:queastio/router/router.dart' as router;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        onGenerateRoute: router.generateRoute,
        initialRoute: HomeViewRoute,
      ),
    );
  }
}
