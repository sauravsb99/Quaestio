import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/services/database.dart';
import 'package:queastio/shared/constants.dart';

class Submission extends StatefulWidget {
  @override
  _SubmissionState createState() => _SubmissionState();
}

class _SubmissionState extends State<Submission> {
  File uploadFile;
  StorageUploadTask uploadTask;
  String type;
   showAlertDialog(String message, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.home,
            //     color: Color(0xff43b77d),
            //   ),
            //   onPressed: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, HomeViewRoute, (route) => false);
            //   },
            // )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar:AppBar(
          title: const Text('Submissions'),
        ),
      // backgroundColor: Colors.green,
    body:Container(
      color: Colors.green,
      // alignment: ,
      child:Column(
      children:<Widget>[ SizedBox(height: 50,),
        Card(
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              
              leading: Icon(Icons.album),
              title: Text('Upload Your Resume'),
              subtitle: Text('in pdf format'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Upload',textAlign: TextAlign.center,),
                  onPressed: () async{
                    File file = await FilePicker.getFile(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf']);
                                if (file != null)
                                  setState(() {
                                    uploadFile = file;
                                    type = 'pdf';
                                  });
                                  StorageReference storageReference =
                                        FirebaseStorage.instance.ref().child(
                                            'fileSubmissions/${Path.basename(user.uid)}.pdf');
                                    setState(() {
                                      uploadTask =
                                          storageReference.putFile(uploadFile);
                                    });
                                    try {
                                      await uploadTask.onComplete;
                                      String myUrl = await storageReference
                                          .getDownloadURL();
                                      await DatabaseService(uid: user.uid)
                                          .addSubmission("Resume", myUrl,uploadFile.path);
                                      showAlertDialog(
                                          'Your file has been uploaded!',
                                          context);
                                    } catch (err) {
                                      setState(() {
                                        uploadTask = null;
                                        uploadFile = null;
                                      });
                                      showAlertDialog(err.toString(), context);
                                    }

                  },
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 50,),
        Card(
        child: Column(
          
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              
              leading: Icon(Icons.album),
              title: Text('Video Submission'),
              subtitle: Text('in mp4 format'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Upload',textAlign: TextAlign.center,),
                  onPressed: () async{
                    File file = await FilePicker.getFile(
                                    type: FileType.custom,
                                    allowedExtensions: ['mp4']);
                                if (file != null)
                                  setState(() {
                                    uploadFile = file;
                                    type = 'video';
                                  });
                                  StorageReference storageReference =
                                        FirebaseStorage.instance.ref().child(
                                            'fileSubmissions/${Path.basename(user.uid)}.mp4');
                                    setState(() {
                                      uploadTask =
                                          storageReference.putFile(uploadFile);
                                    });
                                    try {
                                      await uploadTask.onComplete;
                                      String myUrl = await storageReference
                                          .getDownloadURL();
                                      await DatabaseService(uid: user.uid)
                                          .addSubmission("Video", myUrl,uploadFile.path);
                                      showAlertDialog(
                                          'Your file has been uploaded!',
                                          context);
                                    } catch (err) {
                                      setState(() {
                                        uploadTask = null;
                                        uploadFile = null;
                                      });
                                      showAlertDialog(err.toString(), context);
                                    }

                  },


                  // },
                ),
              ],
            ),],),),
      ],
    ),
    ),
    );
}
}