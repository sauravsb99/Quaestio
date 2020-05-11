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
  final UserData user;
  final _formKey = GlobalKey<FormState>();

  _UserputState ( {this.user} );

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
  Widget build (BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: ( context, snapshot ) {
        if ( snapshot.hasData ) {

          UserData userData = snapshot.data;

          return Scaffold(
            body: Wrap(

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
                                    child: _image==null?Image.network(userData.image):Image.file(_image,fit: BoxFit.fill,),
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
                            SizedBox(
                              height: 10,
                            ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Name",style: TextStyle(fontSize: 17)),
                                  SizedBox(width: 15),
                                  Container(
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
                                  Icon(Icons.edit),
                                ],
                              ),
                            SizedBox(height: 10,),
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
                                  String url = await ref.getDownloadURL();
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
                                  String err= "Photo Updated";
                                  if(_image!=null){
                                    String fileName=basename(userData.uid);
                                    StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
                                    StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
                                    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
                                    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                    if(uploadTask.isCanceled) {
                                      err = "Error";
                                    }
                                    url = dowurl.toString();
                                    setState(() {
                                      print("Data Updated");
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(err)));
                                    });
                                  }
                                if (_formKey.currentState.validate()) {
                                  print(name);
                                  String i = url;
                                  if(name ==null)
                                    name = userData.name;
                                  if(i==null)
                                  i=userData.image;
                                  await DatabaseService(uid: user.uid).updateUserData(name,i);
                                setState((){
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Name Updated")));
                                });
                                }
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
