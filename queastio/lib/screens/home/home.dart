import 'package:flutter/material.dart';
import 'package:queastio/models/batch.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/drawer.dart';
import 'package:queastio/screens/home/landing.dart';
import 'package:queastio/services/auth.dart';
import 'package:queastio/services/database.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/shared/constants.dart';

class Home extends StatefulWidget {
  String batchval = '---';
  Set<String> items;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String batchval = '---';
  Set<String> items;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    // Navigator.pop(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            print(userData.batch);
            if(userData.batch!=''){
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
//            floatingActionButton:
                    body: Landing()),
              ),
            );
            }else{

              return StreamBuilder<List<Batch>>(
              stream: DatabaseService(uid:userData.uid).batches,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
    List<Batch> batches = snapshot.data;
    batchval = batchval == null ? '---' : batchval;
    items = Set.from(['---']);
    batches.forEach((element) {
      items.add(element.name);
    });
                return Container(
                child:  Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
//                  title: Text('My Scores'),
//                  backgroundColor: Color(0xff43b77d),
                ),
                drawer: MyDrawer(),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.radio_button_checked,
                        color: Colors.white,
                        size: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Set Your Batch Here.\n This is Permanent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          letterSpacing: 2.0,
                        ),textAlign: TextAlign.center,
                      ),

                      Container(
                        color: Colors.white,
                        child: DropdownButton<String>(
                          value: batchval,
                          underline: Container(
                            color: Color(0xff43b77d),
                            height: 2.0,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              batchval = newValue;
                            });
                          },
                          items: items.map((item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () async {
//                          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please Wait"),));
                          String err = "Photo Updated";
                          print(batchval);
                            await DatabaseService(uid: user.uid)
                                .updateUserData(userData.name, userData.image, userData.role,batchval);
                            setState(() {
                            });
                        },
                        splashColor: Colors.white,
                        textColor: Colors.white,
                        color: Color(0xff43b77d),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )




//                    await DatabaseService(
//                    uid: user.uid)
//                    .updateUserData(
//                    name, i, userData.role,userData.batch);
//                  setState(() {
//                Scaffold.of(context)
//                    .showSnackBar(SnackBar(
//                    content: Text(
//                        "Name Updated"),duration: Duration(milliseconds: 200)));
//              });
                    ],
                  ),
                ),
              )
                );
    }
    else{

      return Container();
    }
              }
              );
            }
          } else {
            return Container();
          }
        });
  }
}
