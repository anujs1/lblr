import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  
  @override
  void initState() {
    super.initState(); 
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  File image;
  final picker = ImagePicker();
  
  Future _getImage(ImageSource imageSource, {BuildContext popContext, BuildContext pushContext}) async {
    try {
      final pickedFile = await picker.getImage(source: imageSource);
      image = File(pickedFile.path);
      
      showDialog(
        context: pushContext,
        builder: (BuildContext alertContext) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1488CC)),
            ),
          );
        },
      );
      
      final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
      final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
      final List<ImageLabel> imageLabels = await labeler.processImage(visionImage);
      labeler.close();
      
      List<String> labels = [];
      String checkIfError = imageLabels[0].text.toString();
      for(var i=0; i<imageLabels.length && i<4; i++) labels.add(imageLabels[i].text.toString());
      
      Navigator.of(context, rootNavigator: true).pop('dialog');
      
      await Navigator.pushNamed(pushContext, '/mainDetail', arguments: {
        'image': image,
        'labels': labels,
      });
    }
    catch (err) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if(err.toString().substring(0, 17) != "NoSuchMethodError") {
        showDialog(
          context: popContext,
          builder: (BuildContext alertContext) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              title: Text('Error loading image'),
              content: Text('The image you have selected in not in a supported format or no predictions could be made.'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Color(0xFF1488CC),
                    ),
                  ),
                  onPressed: () {Navigator.of(alertContext).pop();},
                ),
              ],
            );
          },
        );
      }
    }
    setState(() {});
  }
  
  void _objectDetectionEditModalBottomSheet(BuildContext inContext) {
    
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    
    BorderRadius _roundedCornerSettings = BorderRadius.vertical(top: Radius.circular(30));
    
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: _roundedCornerSettings
      ),
      context: context, 
      builder: (BuildContext buildContext) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: _roundedCornerSettings,
        ),
        height: _height * 0.25,
        child: Padding(
          padding: EdgeInsets.only(left: _width/6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _getImage(ImageSource.camera, popContext: buildContext, pushContext: inContext),
                    child: Icon(
                      Icons.photo_camera,
                      // color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _width/25),
                    child: Text('Choose from camera'),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _getImage(ImageSource.gallery, popContext: buildContext, pushContext: inContext),
                    child: Icon(Icons.photo_library),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _width/20),
                    child: Text('Choose from photo gallery'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    var size  = MediaQuery.of(context).size;
    
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget child) {
                    return ClipPath(
                      clipper: DrawClip(_controller.value),
                      child: Container(
                        height: size.height * 0.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [const Color(0xFF1488CC), const Color(0xFF2B32B2)]
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Text(
                    'lblr',
                    style: TextStyle(
                      fontFamily: 'Raleway-SemiBold',
                      letterSpacing: 10.0,
                      fontSize: size.width*0.25,
                      color: Colors.white,
                    ),
                  ),
                ),
                 
              ],
            ),
            
            Expanded(
              child: Container(
                width: size.width,
                // color: Colors.green,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(size.width*0.1, 0, size.width*0.1, size.height*0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      
                      Expanded(
                        child: Container(
                          // color: Colors.blue,
                          child: Center(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, size.height*0.015, 0, size.height*0.02),
                                  child: Text(
                                    'Label your images with ease.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width*0.07,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Upload an image to get started.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: size.width*0.2,
                                height: size.width*0.2,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [const Color(0xFF1488CC), const Color(0xFF2B32B2)]
                                  ),
                                ),
                              ),
                              FlatButton(
                                onPressed: () => _objectDetectionEditModalBottomSheet(context),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: size.width*0.09,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
    );
  }
}

Widget input(String hint, {bool isPass = false}) {
  return TextField(
    obscureText: isPass,
    decoration: InputDecoration(
        hintText: 'Nick name or email',
        hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
        contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        )),
  );
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
