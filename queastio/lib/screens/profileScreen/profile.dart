
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:queastio/screens/home/home.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File _image;

  @override

  Widget build(BuildContext context) {


    Future getImage(bool isCamera) async{
      var image;
      if(isCamera) {

      }
      else {
        image = await ImagePicker.pickImage(source: ImageSource.gallery);
      }
      setState(() {
        _image=image;
        print('Image Path $_image');
      });
    }



    Future uploadPic(BuildContext context) async{
      String fileName=basename(_image.path);
      StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      setState(() {
        print("Data Updated");
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Data Updated")));
      });
    }


    return Scaffold(
//      appBar: AppBar(
//        leading:
//        title: Text('Profile'),
//      ),
      body: Builder(
        builder: (context)=>Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35,),
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
//              SizedBox(height: 0.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left:20),
                    child:CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.black26,
                      child:ClipOval(
                        child: SizedBox(
                          width: 140.0,
                          height: 140.0,

//                          child:(_image)



                          child:
                            _image==null? Image.network("https://vignette.wikia.nocookie.net/joke-battles/images/2/29/Catpixelated.jpg/revision/latest?cb=20160103222950",
                              fit:BoxFit.fill,
                            ): Image.file(_image,fit:BoxFit.fill),


                      ),

                    ),
                  ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:80.0),
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                    onPressed:(){
                        getImage(false);

                    },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:80.0),
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed:(){
                        getImage(true);

                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 200,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  SizedBox(width:10,),

                  Text("Name",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(width:15,),

//                  Expanded(
//                      child:
                      Container(

//                         : CrossAxisAlignment.center,
                        color: Colors.white,
                        child: SizedBox(

                          width:(MediaQuery.of(context).size.width-75)*0.7,
                          child: Align(
                            alignment: Alignment.centerRight,

                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8.0,15.0,8.0),
                              child: Text("hi",
                                  style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),
                        ),
                      ),
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        Navigator.pop(context);
                      }
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  SizedBox(width:10,),

                  Text("E-mail",
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(width:15,),

//                  Expanded(
//                      child:
                  Container(

//                         : CrossAxisAlignment.center,
                    color: Colors.blue,
                    child: SizedBox(

                      width:(MediaQuery.of(context).size.width-75)*0.7,
                      child: Align(
                        alignment: Alignment.centerRight,

                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0,8.0,15.0,8.0),
                          child: Text("hi",
                              style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.lock),
                      onPressed: (){},
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    splashColor: Colors.white,
                    textColor: Colors.white,
                    color:Colors.grey,
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16,),
                    ),
                  ),
                  SizedBox(width: 60,),
                  RaisedButton(
                    onPressed: (){
                      uploadPic(context);
                    },
                    splashColor: Colors.white,
                    textColor: Colors.white,
                    color:Colors.grey,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16,),
                    ),
                  )
                ],
              )

            ],
          )
        ),
      ),

    );
  }
}
