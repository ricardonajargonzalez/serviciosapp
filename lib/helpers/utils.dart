

import 'package:flutter/material.dart';

const boxShadowGeneral = BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                     topRight: Radius.circular(30),
                     topLeft: Radius.circular(30)),
                  boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 97, 95, 95),
                      //  offset: Offset(4.0, 1.0), //(x,y)
                      blurRadius: 3.0),
                ]
                 
                 );

 const TextStyle estiloTextboldWhite =  TextStyle(
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
        color: Colors.black);
const TextStyle estiloTextWhite = TextStyle(color: Colors.black, fontSize: 12);
const TextStyle estilotitulo = TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13);
const TextStyle estiloSubtitulos = TextStyle(color: Colors.black54);
const BoxDecoration decoration = BoxDecoration(color: Color(0xff002E53),borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)));


    SnackBar warningMensaje($msg) {
    return SnackBar(
                          backgroundColor: const Color(0xffe69b00),
                          content: Text( $msg,style: const TextStyle(color: Colors.white) ),
                          action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'OK',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
  }

    SnackBar successMensaje($msg) {
    return SnackBar(
                          backgroundColor: const Color(0xff002E53),
                          content: Text( $msg,style: const TextStyle(color: Colors.white) ),
                          action: SnackBarAction(
                          textColor: Colors.white,
                          label: 'Ok',
                            onPressed: (){
                              
                            },

                          ),
                        );
  }

  void showSnackBar(BuildContext context,SnackBar snackBar){
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}