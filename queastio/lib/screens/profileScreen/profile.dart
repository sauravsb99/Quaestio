
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:queastio/screens/home/home.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                          width: 180.0,
                          height: 180.0,
                          child: Image.network(
                              "https://vignette.wikia.nocookie.net/joke-battles/images/2/29/Catpixelated.jpg/revision/latest?cb=20160103222950",
                            fit:BoxFit.fill,
                        ),
                      ),

                    ),
                  ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:60.0),
                    child: IconButton(
                      icon: Icon(Icons.insert_photo),
                    onPressed:(){

                    },
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),

            ],
          )
        ),
      ),

    );
  }
}
