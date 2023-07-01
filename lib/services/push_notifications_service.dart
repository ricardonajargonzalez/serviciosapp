

//sha1 : EB:35:B0:26:CA:3A:24:A6:9E:9B:C9:2C:14:80:6F:AC:65:EE:8A:C5

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:serviciosapp/models/NotificacionLocal.dart';

class PushnotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;

  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream; // subscribirse al stream



    static Future _backgroundHandler( RemoteMessage message ) async {
     print( 'onBackground Handler ${ message.messageId }');
     _messageStream.add(message.notification?.title ?? '');
      NotificacionLocal.showNotification(title: 'titulo prueba', body: 'este es es el body de prueba');
      print( message.data );
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
     // print( 'onMessage Handler ${ message.messageId }');
     _messageStream.add(message.notification?.title ?? '');

      final json = jsonDecode(message.data.toString());
      final data = json["data"];
      final String payload = '${data["tipoNotificacion"]}';

      //print('json respuesta ${data["titulo"]}');

     // NotificacionLocal.showNotification(title: json['titulo'], body: json['message']);
      NotificacionLocal.showNotification(title: data["titulo"], body: data["message"],payload: payload);
    //  print( message.data );
  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {
    // print( 'onMessageOpenApp Handler ${ message.messageId }');
     _messageStream.add(message.notification?.title ?? '');
      NotificacionLocal.showNotification(title: 'titulo prueba', body: 'este es es el body de prueba', id: '123');
     // print( message.data );
  }

  static Future inicializarApp() async {

    //push notifications
    await Firebase.initializeApp();
     final String token = await FirebaseMessaging.instance.getToken() ?? '';

      // Create storage
     final _storage = new FlutterSecureStorage();
     await _storage.write(key: 'token_fcm', value: token); //guardamos token en local storage
     print("Token firebase device local:   ${token}");



    // Handlers
    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );

    //local notifactions

  }

  Future<bool> validarTokenFCM()async{


    return true;
  }




  static closeStreams(){
    _messageStream.close();
  }

}