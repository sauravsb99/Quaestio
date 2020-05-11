import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AddQuiz extends StatefulWidget {
  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  // String _fileName;
  // String _path;
  // Map<String, String> _paths;
  // String _extension;
  // bool _loadingPath = false;
  // bool _multiPick = false;
  // bool _hasValidMime = true;
  // FileType _pickingType;
  // void _openFileExplorer() async {
  //   if (_hasValidMime) {
  //     setState(() => _loadingPath = true);
  //     // try {
  //     //   if (_multiPick) {
  //     //     _path = null;
  //     //     _paths = await FilePicker.getMultiFilePath(
  //     //         type: _pickingType, fileExtension: _extension);
  //     //   } else {
  //     //     _paths = null;
  //     //     _path = await FilePicker.getFilePath(
  //     //         type: _pickingType, fileExtension: _extension);
  //     //   }
  //     // }  catch (e) {
  //     //   print("Unsupported operation" + e.toString());
  //     // }
  //     if (!mounted) return;
  //     setState(() {
  //       _loadingPath = false;
  //       _fileName = _path != null
  //           ? _path.split('/').last
  //           : _paths != null ? _paths.keys.toString() : '...';
  //     });
  //   }
  // }
  Future getFile (bool isFile) async {
    var file;
    if ( isFile ) {
      file = await FilePicker.getFile();
    }
    // else {
    //   file = await ImagePicker.pickImage(
    //       source: ImageSource.gallery
    //   );
    // }
    setState(() {
          _file = file;
          print(
              'File Path $_file'
          );
        }
    );
  }
  File _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
          child: Center(
              child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: new RaisedButton(
                  onPressed: () async{
                    // File file = await FilePicker.getFile();
                    getFile(true);
                    print(_file);
                  },
                ),
              ),
            ]
          ),
        ),
      ),
      // body: Container(
      //     child: Center(
      //         child: Column(
      //       children: <Widget>[
      //         new Padding(
      //           padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
      //           child: new RaisedButton(
      //             onPressed: () => _openFileExplorer(),
      //             child: new Text("Open file picker"),
      //           ),
      //         ),
      //         new Builder(
      //           builder: (BuildContext context) => _loadingPath
      //               ? Padding(
      //                   padding: const EdgeInsets.only(bottom: 10.0),
      //                   child: const CircularProgressIndicator())
      //               : _path != null || _paths != null
      //                   ? new Container(
      //                       padding: const EdgeInsets.only(bottom: 30.0),
      //                       height: MediaQuery.of(context).size.height * 0.50,
      //                       child: new Scrollbar(
      //                           child: new ListView.separated(
      //                         itemCount: _paths != null && _paths.isNotEmpty
      //                             ? _paths.length
      //                             : 1,
      //                         itemBuilder: (BuildContext context, int index) {
      //                           final bool isMultiPath =
      //                               _paths != null && _paths.isNotEmpty;
      //                           final String name = 'File $index: ' +
      //                               (isMultiPath
      //                                   ? _paths.keys.toList()[index]
      //                                   : _fileName ?? '...');
      //                           final path = isMultiPath
      //                               ? _paths.values.toList()[index].toString()
      //                               : _path;

      //                           return new ListTile(
      //                             title: new Text(
      //                               name,
      //                             ),
      //                             subtitle: new Text(path),
      //                           );
      //                         },
      //                         separatorBuilder:
      //                             (BuildContext context, int index) =>
      //                                 new Divider(),
      //                       )),
      //                     )
      //                   : new Container(),
      //         ),
      //       ],
      //     )),
      //   ),
      // ),
    );
  }
}