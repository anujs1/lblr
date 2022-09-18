import 'dart:io';
import 'package:flutter/material.dart';

class MainDetail extends StatefulWidget {
  const MainDetail({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainDetailState createState() => _MainDetailState();
}

class _MainDetailState extends State<MainDetail> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map;
    File image = data['image'];
    List<String> labels = data['labels'];
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1488CC), Color(0xFF2B32B2)]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, size.width * 0.075, 0, size.width * 0.075),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.075),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: size.width * 0.75,
                              maxHeight: size.height * 0.4,
                            ),
                            child: Image.file(image),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.015),
                          child: Text(
                            'Our best guess:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.07,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.075),
                          child: Text(
                            labels[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.11,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              size.width * 0.125, 0, size.width * 0.125, 0),
                          // color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    width: size.width * 0.15,
                                    height: size.width * 0.15,
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
                                    onPressed: () => Navigator.pop(context),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: size.width * 0.09,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Container(
                                    width: size.width * 0.15,
                                    height: size.width * 0.15,
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
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/extraDetail',
                                        arguments: {
                                          'labels': labels,
                                        }),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: size.width * 0.09,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
    );
  }
}
