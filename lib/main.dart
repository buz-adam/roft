import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:compo/info.dart';
import 'package:flutter/material.dart';
import 'package:compo/vpager.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';

import 'cam.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyImagePicker(title: 'main'));
  }
}

class MyImagePicker extends StatefulWidget {
  MyImagePicker({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  PickedFile _imageFile;
  int _width, _height;

  String result = "-";
  final String uploadUrl = 'http://3579-178-247-31-196.ngrok.io/api/upload';
  final ImagePicker _picker = ImagePicker();
  String download = "";
  bool loading = false;
  Future<String> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var res = await request.send();

    final respStr = await res.stream.bytesToString();
    result = respStr;
    print('sonc ' + result);
    int a = 0;
    a++;
    return res.reasonPhrase;
  }

  var ff = [
    'İlgi merkezi, daha çok kırmızı bölgede olduğundan,' +
        'fotoğraf üçler kuralına uygun değildir.\n' +
        'ilgi merkezini, Fotoğraf üzerindeki yeşil alanlaradan' +
        ' birinin üzerine getiriniz.',
    'fotoğrafta ilgi merkezlerinde çok fazla öğe var.',
    'fotoğraf üçler kuralına uygundur.'
  ];
  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception.code);
    }
  }

  Widget _previewImage(bool loading) {
    if (download.length > 1) {
      return Center(
        child:
            Container(width: 200, height: 300, child: Image.network(download)),
      );
    } else if (_imageFile != null) {
      double a = 0, b = 0, x = 0;
      bool ctrl = MediaQuery.of(context).orientation == Orientation.portrait;
      if (ctrl) {
        a = 294;
        b = _height / (_width / 294);
        x = 45;
      } else {
        a = _width / (_height / 294);
        b = 294;
        x = 50;
      }
      int inx = 0;
      var colo = Colors.grey[200];
      if (result != '-') {
        colo = result.contains('not') || result.contains('mux')
            ? Colors.redAccent
            : Colors.lightGreen;
        if (colo == Colors.redAccent) {
          inx = result.contains('not') ? 0 : 1;
        } else {
          inx = 2;
        }
      }
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 300
                  : 630,
              height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 630
                  : 300,
              child: Card(
                  color: colo,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        //338<width=294
                        child: Image.file(
                          File(
                            _imageFile.path,
                          ),
                        ),
                      ),

                      //respon is not that excepted
                      Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Visibility(
                              visible: result == 'Mnot' ? true : false,
                              child: Container(
                                //a * 3 / 4.5 rnot or lnot
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Image.asset(
                                  'assets/oxo.png',
                                ),
                                width: x,
                                height: b,
                              ),
                            ),
                            Visibility(
                              visible: result == 'Rok' || result.contains('not')
                                  ? true
                                  : false,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(a / 3, 0, 0, 0),
                                child: Image.asset(
                                  'assets/xlx.png',
                                ),
                                width: x,
                                height: b,
                              ),
                            ),
                            Visibility(
                              visible: result == 'Lok' || result.contains('not')
                                  ? true
                                  : false,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, a / 3, 0),
                                child: Image.asset(
                                  'assets/xlx.png',
                                ),
                                width: x,
                                height: b,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/rot.png',
                                width: a,
                                height: b,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Visibility(
                                visible: loading,
                                child: Container(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator()))
                          ]),
                      Visibility(
                        visible: result == "-" ? false : true,
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: ctrl ? 50 : 10),
                              child: Container(
                                color: Colors.amber.withOpacity(0.4),
                                child: Text(
                                  ff[inx],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'times new roman',
                                      fontSize: 15),
                                ),
                              ),
                            )),
                      )
                    ],
                  )),
            ),
            // Container(
            //   width: 100, height: 100,
            //   child: CircularProgressIndicator(),),
          ]);
    } else {
      return const Text(
        'Herhangi bir fotoğraf yüklü değil.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      File image =
          new File(pickedFile.path); // Or any other way to get a File instance.
      var decodedImage = await decodeImageFromList(image.readAsBytesSync());
      _width = decodedImage.width;
      _height = decodedImage.height;
      setState(() {
        _imageFile = pickedFile;
        final pngSize =
            ImageSizeGetter.getSize(FileInput(File(_imageFile.path)));
        print("size  " +
            pngSize.toString() +
            ": " +
            _width.toString() +
            "-" +
            _height.toString());
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<void>(
        future: retriveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Text('Picked an image');
            case ConnectionState.done:
              return _previewImage(loading);
            default:
              return const Text('Picked an image');
          }
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              Directory appDocDir = await getApplicationDocumentsDirectory();
              String path = appDocDir.path;

              var real = await testCompressAndGetFile(
                  File(_imageFile.path), '$path/image1.jpg');

              var res = await uploadImage('$path/image1.jpg', uploadUrl);
              loading = false;
              print(res);
              setState(() {});
            },
            child: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                iconSize: 45.0,
                padding: EdgeInsets.only(left: 10),
                icon: Icon(Icons.photo_library),
                onPressed: () {
                  setState(() {
                    result = "-";
                    _pickImage();
                  });
                },
              ),
              IconButton(
                iconSize: 45.0,
                padding: EdgeInsets.only(left: 50),
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  setState(() {
                    result = "-";
                    _open_camera();
                  });
                },
              ),
              IconButton(
                iconSize: 45.0,
                padding: EdgeInsets.only(left: 50.0),
                icon: Icon(Icons.info),
                onPressed: () {
                   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Info(),
                ),
              ).then((value) => setState(() {}));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    print("testCompressAndGetFile");
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 300,
      minHeight: 300,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  _open_camera() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }
}
