import 'package:flutter/material.dart';
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
        theme: _buildTheme(),
        onGenerateRoute: router.generateRoute,
        initialRoute: HomeViewRoute,
      ),
    );
  }
}
ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
//      accentColor: kUndaGreen,
//      scaffoldBackgroundColor: Colors.grey,
      cardColor: Colors.white,
      textSelectionColor: Colors.amberAccent,
//      errorColor: Colors.green,
      textSelectionHandleColor: Colors.black,
      appBarTheme:AppBarTheme(elevation: 0.0,
        color:Color(0xff43b77d),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      )
  );
}