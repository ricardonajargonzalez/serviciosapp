


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:serviciosapp/main.dart';
import 'dart:async';





class NotificacionLocal{


  static StreamController <Map<String,dynamic>> _selectNotificationStream = new StreamController.broadcast();
  static Stream<Map<String,dynamic>> get selectNotificationStream => _selectNotificationStream.stream; // subscribirse al stream



  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    final androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
    final iOsInitialize = new DarwinInitializationSettings();
    

    final initializationsSettings = new InitializationSettings(android: androidInitialize);
      flutterLocalNotificationsPlugin.initialize( initializationsSettings, onDidReceiveNotificationResponse: 
       (NotificationResponse notificationResponse) {
        print(notificationResponse.notificationResponseType.toString());
     
        if( notificationResponse.notificationResponseType == NotificationResponseType.selectedNotification ) {
               
               
               
              
               if(notificationResponse.payload == "1"){ //asignacion de reporte
                  print("agregar stream");

                  
                  _selectNotificationStream.add({
                    "Tiporoutes": true,
                    "route" : "asignados",
                    "arguments" : false,
                    "dataArgumentos" : []

                  });

                
               }
               
              // selectNotificationStream.add(notificationResponse.payload);
              //_selectNotificationStream.add(data);
        }

    }
      
     /* 
      (details) {
        print("details payload ${details.payload}");
        print("details actionId ${details.actionId}");
         print("details id ${details.id}");
         print("details input ${details.input}");
          print("details input ${details.notificationResponseType.name}");
      }
      */
      
       , );


  }






  static void showNotification({id = 0, required String title, required String body, String? payload}) {
 

  // Configuracion de  la notificación
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Id del canal de notificación
    'your_channel_name', // Nombre del canal de notificación
    importance: Importance.max,
    priority: Priority.high,
    playSound: true
    //sound: RawResourceAndroidNotificationSound('notification')
  );



  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Muestramos la notificación
  flutterLocalNotificationsPlugin.show(id, title, body, platformChannelSpecifics, payload: payload);

  
}



}