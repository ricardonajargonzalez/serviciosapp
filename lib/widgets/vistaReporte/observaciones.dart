import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/comentarios_flujo_response.dart';
import 'package:serviciosapp/services/comentarios_flujo_provider.dart';

class ContenedorComentarios extends StatelessWidget {
  const ContenedorComentarios({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final comentarios =
        Provider.of<ComentariosflujoProvider>(context).observaciones;
    final height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 10,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Column(
          children: [
           // Comentarios( comentarios: comentarios),
           Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              children: const [
                FaIcon(FontAwesomeIcons.solidComments, size: 15, color: Color(0xff002E53)),
                SizedBox(width: 5),
                Text("Observaciones", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )),
            const Divider(height: 1, color: Color(0xff002E53),),
           Expanded(
            child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: comentarios.results.length,
          itemBuilder: (BuildContext context, int index) {
            final Comentario comentario = comentarios.results[index];
            initializeDateFormatting('es-MX', '');
            final formattedDate = DateFormat('d MMMM yyyy')
                .format(comentario.swfComentariosCreated);
            final formattedTime =
                DateFormat.jms().format(comentario.swfComentariosCreated);
    
            return Container(
             // color: Colors.amber,
                padding: const EdgeInsets.all(5),
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                              children: [
                                ClipOval(
                                child: FadeInImage(
                            placeholder: const AssetImage('assets/no-image.png'),
                            image: NetworkImage(comentario.foto),
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          )),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(comentario.nombre,
                                      overflow: TextOverflow.clip, style: const TextStyle(fontWeight: FontWeight.bold),),
                                  Text(formattedDate,style: const TextStyle(fontSize: 12, fontFamily: 'Roboto'))
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(width: double.infinity, child: Text(comentario.swfComentariosDes, style: const TextStyle(fontSize: 15),)),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                          fontSize: 9,
                          fontFamily: 'Roboto',
                          color: Colors.black54),
                    ),
                    const Divider()
                  ],
                ));
          })
            )
          ],
        ),
      ),
    );
  }
}