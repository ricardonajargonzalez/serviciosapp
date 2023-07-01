import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/NotificacionLocal.dart';
import 'package:serviciosapp/routes/routes.dart';
import 'package:serviciosapp/services/acciones_disponibles_flujo.dart';
import 'package:serviciosapp/services/acciones_menu_button_provider.dart';
import 'package:serviciosapp/services/adjuntos_evidencias_provider.dart';
import 'package:serviciosapp/services/all_notificaciones_provider.dart';
import 'package:serviciosapp/services/asignados_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:serviciosapp/services/checklist_provider.dart';
import 'package:serviciosapp/services/comentarios_flujo_provider.dart';
import 'package:serviciosapp/services/consumibles_refacciones_provider.dart';
import 'package:serviciosapp/services/flujo_wizard_provider.dart';
import 'package:serviciosapp/services/push_notifications_service.dart';
import 'package:serviciosapp/services/reasignar_usuario_provider.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:serviciosapp/services/correctivos_provider.dart';
import 'package:serviciosapp/services/preventivos_provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future main()  async{
  //variables globales, entornos
  await dotenv.load(fileName: ".env");
  
  //inicializat FireBase para push
  WidgetsFlutterBinding.ensureInitialized(); // linea para asegurarnos de tener un context antes de ejecutar todo
  await PushnotificationService.inicializarApp();

  runApp(const MyApp());


}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
   final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //inicializar notificaciones locales
    NotificacionLocal.initialize(flutterLocalNotificationsPlugin);

    PushnotificationService.messageStream.listen((mesaage) { 
        print("myApp: ${mesaage}");
    });




    NotificacionLocal.selectNotificationStream.listen((event)  {

       navigatorKey.currentState?.pushNamed('asignados');
      
    });

  }





  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(create: ( _ ) => AsignadosProvider(),lazy: false ),
        ChangeNotifierProvider(create: ( _ ) => PreventivosProvider(),lazy: false ),
        ChangeNotifierProvider(create: ( _ ) => CorrectivosProvider()),
        ChangeNotifierProvider(create: ( _ ) => ReporteActivoProvider(),lazy: false ),
        ChangeNotifierProvider(create: ( _ ) => AccionesMenuButton()),
        ChangeNotifierProvider(create: ( _ ) => AccionesDisponiblesFlujo()),
        ChangeNotifierProvider(create: ( _ ) => FlujoWizardProvider()),
        ChangeNotifierProvider(create: ( _ ) => SwfRequestProvider()),
        ChangeNotifierProvider(create: ( _ ) => AdjuntosEvidenciasProvider()),
        ChangeNotifierProvider(create: ( _ ) => ComentariosflujoProvider()),
        ChangeNotifierProvider(create: ( _ ) => CheckListProvider()),
        ChangeNotifierProvider(create: ( _ ) => ReasignarUsuarioProvider()),
        ChangeNotifierProvider(create: ( _ ) => ConsumiblesRefaccionesProvider()),
        ChangeNotifierProvider(create: ( _ ) => AllNotificacionesProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Servicios App',
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldKey,
        initialRoute: 'check-auth-screen',
       //initialRoute: 'loading',
        routes: appRoutes,
        theme: ThemeData(
          fontFamily: 'Raleway',
        ),
        //home: AsignadosPage()
      ),
    );
  }
}
