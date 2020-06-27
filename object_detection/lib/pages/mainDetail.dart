import 'dart:io';
import 'package:flutter/material.dart';

class MainDetail extends StatefulWidget {
  @override
  _MainDetailState createState() => _MainDetailState();
}

class _MainDetailState extends State<MainDetail> {
  
  Map data = {};
  
  @override
  Widget build(BuildContext context) {
    
    data = ModalRoute.of(context).settings.arguments;
    File image = data['image'];
    List<String> labels = data['labels'];
    var size  = MediaQuery.of(context).size;
    
    return Container(
      
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF1488CC), const Color(0xFF2B32B2)]
        ),
      ),
      
      child: Scaffold(
        
        backgroundColor: Colors.transparent,
        
        body: Center(
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                
                Container(
                  
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, size.width*0.075, 0, size.width*0.075),
                    child: Container(
                      // color: Colors.green,
                      child: Column(
                        
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Padding(
                            padding: EdgeInsets.only(bottom: size.height*0.075),
                            child: Container(
                              
                              constraints: BoxConstraints(
                                maxWidth: size.width*0.75,
                                maxHeight: size.height*0.4,
                              ),
                              
                              child: Image.file(image),
                              
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.only(bottom: size.height*0.015),
                            child: Text(
                              'Our best guess:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.07,
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.only(bottom: size.height*0.075),
                            child: Container(
                              child: Text(
                                labels[0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width*0.11,
                                ),
                              ),
                            ),
                          ),
                          
                          Container(
                            margin: EdgeInsets.fromLTRB(size.width*0.125, 0, size.width*0.125, 0),
                            // color: Colors.blue,
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              
                              children: <Widget>[
                                
                                Container(
                                  // color: Colors.red,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: size.width*0.15,
                                        height: size.width*0.15,
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
                                        onPressed: () => Navigator.pop(context),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: size.width*0.09,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                Container(
                                  // color: Colors.green,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: size.width*0.15,
                                        height: size.width*0.15,
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
                                        onPressed: () => Navigator.pushNamed(context, '/extraDetail', arguments: {
                                          'labels': labels,
                                        }),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                          size: size.width*0.09,
                                        ),
                                      ),
                                    ],
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
          ),
        ),
        
      ),
    );
  }
}
