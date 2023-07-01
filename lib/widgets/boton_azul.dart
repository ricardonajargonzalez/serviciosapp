


import 'package:flutter/material.dart';

class BottonAzul extends StatelessWidget {
  final ButtonStyle? raisedButtonStyle;
  final String text;
  final Function()? onPress;
  final bool progressbar;
  final width;



  const BottonAzul({ Key? key,  this.raisedButtonStyle, required this.text, this.onPress, this.progressbar = false, this.width = double.infinity }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return Container(
              width: this.width,
              child: ElevatedButton(
                style: this.raisedButtonStyle == null ?  ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:  Color(0xff002E53),
        minimumSize:  Size(88, 36),
        padding:  EdgeInsets.symmetric(vertical: 20),
        shape:  StadiumBorder() //border redondos
        ) : raisedButtonStyle,
                onPressed: this.onPress,
                child: progressbar ? SizedBox( 
                                         height:30, width:30,
                                         child: CircularProgressIndicator(
                                           backgroundColor: Colors.orange[100],
                                           valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                                         ),
                                       ): Text(this.text),
              ));
  }
}

