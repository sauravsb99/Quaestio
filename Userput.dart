import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/screens/home/home.dart';
import 'package:queastio/services/database.dart';

class Userput extends StatefulWidget {
//  DatabaseService data;
  final UserData user;
  Userput({this.user});
  @override
  _UserputState createState() => _UserputState();
}

class _UserputState extends State<Userput> {
//  FirebaseAuth _auth=FirebaseAuth.instance;
  final UserData user;
  final _formKey = GlobalKey<FormState>();

  _UserputState ( {this.user} );

//  String get name => _formKey.currentState.name;
//  // ignore: non_constant_identifier_names
//  Future Loadpic(uid) async {
//    final ref = FirebaseStorage.instance.ref().child(uid);
//    var url = await ref.getDownloadURL();
//// no need of the file extension, the name will do fine.
//    return url;
//  }

  Future getImage (bool isCamera) async {
    var image;
    if ( isCamera ) {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera
      );
    }
    else {
      image = await ImagePicker.pickImage(
          source: ImageSource.gallery
      );
    }
    setState(() {
          _image = image;
          print(
              'Image Path $_image'
          );
        }
    );
  }
  String name;
  File _image;
  String url;
  @override
  Widget build (
      BuildContext context
      ) {
    User user = Provider.of<User>(
        context
    );
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: ( context, snapshot ) {
        if ( snapshot.hasData ) {

          UserData userData = snapshot.data;



          DatabaseService data=DatabaseService();
//          String password = '';
//          String email = '';
//          url=Loadpic(user.uid).toString();

          return Scaffold(
            //      appBar: AppBar(
            //        leading:
            //        title: Text('Profile'),
            //      ),
            body:
  //      Builder(
  //        builder: (context) =>
            Wrap(

              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 35,
                      ),
                      IconButton(
                          icon: Icon(
                              Icons.arrow_back
                          ),
                          onPressed: (
                              ) {
                            Navigator.pop(
                                context
                            );
                          }
                      ),
                      //              SizedBox(height: 0.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.20),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.black26,
                                child: ClipOval(
                                  child: SizedBox(width: 140.0, height: 140.0,
                                    child: _image==null?((userData.image==null)?(Image.network("https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg")):(Image.network(userData.image))):Image.file(_image,fit: BoxFit.fill,),
                                    //                          child:(_image)
//                                    child: url!=null?Image.network(url):Image.network(user.uid),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 80.0
                            ),
                            child: IconButton(
                              icon: Icon(Icons.insert_photo),
                              onPressed: () {getImage(false);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: IconButton(
                              icon: Icon(Icons.camera),
                              onPressed: () {
                                getImage(true);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      Container(
                        child:Form(
                          key: _formKey,
                          child:Column(
                            children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    "UID",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    //                         : CrossAxisAlignment.center,
                                    color: Colors.white,
                                    child: SizedBox(width: (MediaQuery.of(context).size.width - 75) * 0.7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
                                          child: TextFormField(
                                            initialValue:userData.uid,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                            validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                            onChanged: (val) {
                                              String uid;
                                              setState(() => uid = val);
                                            },

                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                          Icons.edit
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }
                                  ),
                                ],
                              ),

                            SizedBox(
                              height: 10,
                            ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),

                                  Text(
                                    "Name",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    //                         : CrossAxisAlignment.center,
                                    color: Colors.white,
                                    child: SizedBox(width: (MediaQuery.of(context).size.width - 75) * 0.7,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 15.0, 8.0),
                                          child: TextFormField(
                                            initialValue:userData.name,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),
                                            validator: (val) => val.isEmpty ? 'Enter name' : null,
                                            onChanged: (val) {

                                              setState(() => name = val);
                                            },

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                          Icons.edit
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }
                                  ),
                                ],
                              ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),

                                Text("E-mail", style: TextStyle(fontSize: 17),),
                                SizedBox(
                                  width: 15,
                                ),
                              Container(
                                //                         : CrossAxisAlignment.center,
                                color: Colors.blue,
                                child: SizedBox(
                                  width: (MediaQuery.of(context).size.width-75)*0.7,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(8.0,8.0,15.0,8.0),
                                      child: Text(userData.uid==null?"email not available":userData.uid,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.lock),
                                onPressed: () {},
                              ),
                            ],
                          ),
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                              RaisedButton(
                                onPressed: () async {
                                  final ref = FirebaseStorage.instance.ref().child(user.uid);
                                  var url = await ref.getDownloadURL();
                                  print(url);
                                },
                                splashColor: Colors.white,
                                textColor: Colors.white,
                                color: Colors.grey,
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              RaisedButton(
                                onPressed: () async {

                                  if(_image!=null){
                                    String fileName=basename(userData.uid);
                                    StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
                                    StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
                                    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
                                    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                    url = dowurl.toString();
                                    setState(() {
                                      print("Data Updated");
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("${url}")));
                                    });
                                  }
                                if (_formKey.currentState.validate()) {
                                  print(name);
                                await data.updateUserData(name,url);
                                setState((){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("url")));
                                });
                                }



    //                          };
                                },
                                splashColor: Colors.white,
                                textColor: Colors.white,
                                color: Colors.grey,
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          )
                                  ],
                          )
                          )
                          )
                        ],
                      ),
                    ),
              ],
//            ),
              ),
          );
            }
        else {
          return Home();
        }
      }
    );
  }
}
