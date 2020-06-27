import 'package:flutter/material.dart';

class ExtraDetail extends StatefulWidget {
  @override
  _ExtraDetailState createState() => _ExtraDetailState();
}

class _ExtraDetailState extends State<ExtraDetail> {
  
  Map data = {};
  
  @override
  Widget build(BuildContext context) {
    
    data = ModalRoute.of(context).settings.arguments;
    List<String> labels = data['labels'];
    var size  = MediaQuery.of(context).size;
    
    String moreGuesses = labels[0];
    if(labels.length>1) {
      moreGuesses = labels[1];
      for(var i=2; i<labels.length; i++) moreGuesses += '\n\n' + labels[i];
    }
    
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
                  // height: _getColumnHeight()+size.width*0.15,
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
                            padding: EdgeInsets.only(bottom: size.height*0.015),
                            child: Text(
                              'Other guesses:\n',
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
                                moreGuesses,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width*0.11,
                                  height: 0.9,
                                ),
                              ),
                            ),
                          ),
                          
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
