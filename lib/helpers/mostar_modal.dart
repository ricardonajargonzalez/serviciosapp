import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


mostrarModal( BuildContext context, {String titulo = '', Widget? contenido, VoidCallback? accionOk,VoidCallback? accionCancel} ) {

  if ( Platform.isAndroid ) {
    return showDialog(
      context: context,
      builder: ( _ ) => AlertDialog(
        title: Container(
          width: double.infinity,
          height: 50,
          child: Column(
            children: [
              Text( titulo ),
              Divider(color: Colors.grey)
            ],
          ),
        ),
        content: contenido,
        actions: <Widget>[
                MaterialButton(
            child: Text('Cancelar'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: accionCancel
          ),
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: accionOk
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text( titulo ),
      content: contenido,
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );

}

