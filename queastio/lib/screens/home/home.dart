import 'package:flutter/material.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/screens/home/landing.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/shared/constants.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    // Navigator.pop(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            print("ok");
            print(userData.uid);
            print(userData.batch);
    return StreamProvider<List<Topic>>.value(
      initialData: List(),
      value: DatabaseService().getTopicsBatch(userData.batch),

      child: Container(
        child: Scaffold(
            backgroundColor: Color(0xff1b1b1b),
            drawer: Drawer(
              child: MyDrawer(),
            ),
            appBar: AppBar(
//            title: Text('Quaestia'),
//            backgroundColor: Color(0xff1b1b1b),
//            backgroundColor: Color(0xff4e6c47),
                elevation: 0.0,
                actions: <Widget>[
                  MaterialButton(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: AppBar().preferredSize.height - 5,
//                      child: Image.network(
//                          "https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/logo_only_white.png?alt=media&token=85ab4b3d-777f-4983-af42-aceaaee6e2a1"),
//              SizedBox(height:2,)
                    ),
                    onPressed: () {
                      Drawer();
                    },
                  ),
                ]
//            actions:<Widget>[
//            Row(children:<Widget>[Image.network("https://firebasestorage.googleapis.com/v0/b/quaestio-bfc06.appspot.com/o/logo_EEE.png?alt=media&token=a3186033-a2f8-411b-8335-eabdf6a05c80"),],)
//          ],
                ),
            floatingActionButton: Container(
              height: 80.0,
              width: 80.0,
              child: FittedBox(
                child: FloatingActionButton(elevation:0.5,backgroundColor: Colors.transparent,onPressed: () {
                  Navigator.pushNamed(context, AboutUsRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset("assets/logo_ok.png"),
                  ),
                ),
              ),
            ),
            body: Landing()),
      ),
    );
  } else {
            return Container();
  }
});
  }
}
