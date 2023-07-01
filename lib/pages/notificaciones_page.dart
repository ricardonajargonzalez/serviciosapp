

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/all_notificaciones_response.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/all_notificaciones_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';

class NotificacionesPage extends StatelessWidget {
  const NotificacionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    Usuario usuario = Provider.of<AuthService>(context,listen: false).usuario;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff002E53),
        elevation: 0,
      ),
      body: Container(
       // padding: const EdgeInsets.symmetric(horizontal: 5),
        width: double.infinity,
        child: ContenedorNotificaciones(usuario: usuario)
        ),
    );
  }
}

class ContenedorNotificaciones extends StatelessWidget {

  final Usuario usuario;
  const ContenedorNotificaciones({
    super.key, required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
            future: Provider.of<AllNotificacionesProvider>(context, listen: false).notificacionesRecientes(idUsuario: usuario.idusuario),
            builder: (BuildContext context,
                AsyncSnapshot<AllNotificacionesResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras el Future está en progreso
                return const SizedBox(child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                // Maneja cualquier error que ocurra durante la carga del Future
                return Text('Error: ${snapshot.error}');
              } else {
                // Muestra los datos cargados una vez que el Future se completa
                if (snapshot.data!.results.isNotEmpty) {
                  final notificaciones = snapshot.data;
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                   // color: Colors.amber,
                    child: ListView.builder(
                      itemCount: notificaciones?.results.length,
                      itemBuilder: (BuildContext context, int index) { 
                        final itemNotificacion = notificaciones!.results[index].datos;
                        final int visto = notificaciones.results[index].visto;
                        final int idNotificacion = int.parse( notificaciones.results[index].idNotificacion );
                         //print(itemNotificacion);
                         return Notificacion(data: jsonDecode(itemNotificacion), visto: visto, idNotificacion: idNotificacion);
                     },),
                  );
                 // return ListadoFotos(adjuntos: adjuntos, width: width);
                } else {
                  return Container(
                   // child: Image.asset('assets/no-image.png'),
                  );
                }
              }
            }),
    );
  }
}

class Notificacion extends StatelessWidget {
  final dynamic data;
  final int visto;
  final int idNotificacion;
  const Notificacion({
    super.key, required this.data, required this.visto, required this.idNotificacion
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Provider.of<AllNotificacionesProvider>(context, listen: false).marcarNotificacionVisto(idNotificacion: idNotificacion);
        // Navigator.of(context).pushNamed('asignados');
         Navigator.pushNamed(context, 'vista_reporte_read_only',arguments: ReporteActivoPreventivoCorrectivo(tipo: "correctivo" , reporte: "4898", idswf_request: "0")); 
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
             decoration: BoxDecoration(
                 
                borderRadius: BorderRadius.circular(5.0),
                color: visto == 0 ? Colors.blueGrey[80] : Colors.grey[100],
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffE7E7E7),
                    offset: Offset(3.0, 1.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
              ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 60,
                  color: const Color(0xff002E53),
                  child:  Stack(
                    children: [
                       const Center(child: FaIcon(FontAwesomeIcons.bell,color: Colors.white, size: 18)),
                       visto == 0 ?
                       const Positioned(
                        top: 20,
                        right: 15,
                        child: FaIcon(FontAwesomeIcons.solidCircle, size: 10,color: Colors.red,))
                        : Container()
                    ],
                  ),
                ),
                Expanded(child: 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text("${data['fecha']}", style: TextStyle(fontSize: 9))),
                        Text("${data['titulo']}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff002E53)),),
                        Text("${data['message']}", style: TextStyle(fontSize: 10)),
                        
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}