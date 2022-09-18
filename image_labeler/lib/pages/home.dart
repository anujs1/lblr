import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  File? image;
  String? imagePath;

  Future _getImage(ImageSource imageSource,
      {BuildContext? popContext, BuildContext? pushContext}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: imageSource);
      imagePath = pickedFile!.path;
      image = File(pickedFile.path);

      showDialog(
        context: pushContext!,
        builder: (BuildContext alertContext) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1488CC)),
            ),
          );
        },
      );

      InputImage inputImage = InputImage.fromFilePath(imagePath!);
      ImageLabeler labeler =
          ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.75));
      final List<ImageLabel> imageLabels =
          await labeler.processImage(inputImage);
      labeler.close();

      List<String> labels = [];
      String checkIfError = imageLabels[0].label.toString();
      for (var i = 0; i < imageLabels.length && i < 4; i++) {
        labels.add(imageLabels[i].label.toString());
      }

      Navigator.of(context, rootNavigator: true).pop('dialog');

      await Navigator.pushNamed(pushContext, '/mainDetail', arguments: {
        'image': image,
        'labels': labels,
      });
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (err.toString().substring(0, 17) != "NoSuchMethodError") {
        showDialog(
          context: popContext!,
          builder: (BuildContext alertContext) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              title: const Text('Error loading image'),
              content: const Text(
                  'The image you have selected in not in a supported format or no predictions could be made.'),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Color(0xFF1488CC),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(alertContext).pop();
                  },
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    BorderRadius roundedCornerSettings =
        const BorderRadius.vertical(top: Radius.circular(30));

    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: roundedCornerSettings),
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: roundedCornerSettings,
            ),
            height: height * 0.25,
            child: Padding(
              padding: EdgeInsets.only(left: width / 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _getImage(ImageSource.camera,
                            popContext: buildContext, pushContext: inContext),
                        child: const Icon(
                          Icons.photo_camera,
                          // color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 25),
                        child: const Text('Choose from camera'),
                      ),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => _getImage(ImageSource.gallery,
                            popContext: buildContext, pushContext: inContext),
                        child: const Icon(Icons.photo_library),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width / 20),
                        child: const Text('Choose from photo gallery'),
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget? child) {
                  return ClipPath(
                    clipper: DrawClip(controller.value),
                    child: Container(
                      height: size.height * 0.5,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF1488CC), Color(0xFF2B32B2)]),
                      ),
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(
                  'lblr',
                  style: TextStyle(
                    fontFamily: 'Raleway-SemiBold',
                    letterSpacing: 10.0,
                    fontSize: size.width * 0.25,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              width: size.width,
              // color: Colors.green,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.1, 0, size.width * 0.1, size.height * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,
                                  size.height * 0.015, 0, size.height * 0.02),
                              child: Text(
                                'Label your images with ease.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.07,
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
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.2,
                            height: size.width * 0.2,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF1488CC),
                                    Color(0xFF2B32B2)
                                  ]),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                _objectDetectionEditModalBottomSheet(context),
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: size.width * 0.09,
                            ),
                          ),
                        ],
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
    decoration: const InputDecoration(
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
