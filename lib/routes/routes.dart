

import 'package:flutter/material.dart';
import 'package:serviciosapp/pages/asignados_page.dart';
import 'package:serviciosapp/pages/check_auth_screen.dart';
import 'package:serviciosapp/pages/consumibles_refacciones_page.dart';
import 'package:serviciosapp/pages/firma_electronica.dart';
import 'package:serviciosapp/pages/foto_detalle_page.dart';
import 'package:serviciosapp/pages/inbox_page.dart';
import 'package:serviciosapp/pages/loading_page.dart';
import 'package:serviciosapp/pages/login_page.dart';
import 'package:serviciosapp/pages/notificaciones_page.dart';
import 'package:serviciosapp/pages/perfil_page.dart';
import 'package:serviciosapp/pages/vista_reporte_read_only.dart';
import 'package:serviciosapp/pages/vista_reportev2.dart';

final Map<String,WidgetBuilder> appRoutes = {
  'loading'                   : ( _ ) => const LoadingPage(),
  'login'                     : ( _ ) => const LoginPage(),
  'asignados'                 : ( _ ) => const AsignadosPage(),
  'check-auth-screen'         : ( _ ) => const CheckAuthScreen(),
  'inbox'                     : ( _ ) => const InboxPage(),
 VistaReporteActivo.routeName : (context) =>  const VistaReporteActivo(),
 'firma'                      : ( _ ) => const FirmaElectronica(),
 'foto-detalle'               : ( _ ) =>  const FotoDetallePage(),
 'consumibles-refacciones'    : ( _ ) =>  const ConsumiblesRefaccionesPage(),
 'perfil'                     : ( _ ) =>  const PerfilPage(),
 'notificaciones'             : ( _ ) =>  const NotificacionesPage(),
 'vista_reporte_read_only'    : ( _ ) =>  const VistaReporteActivoReadOnly()

 
 };