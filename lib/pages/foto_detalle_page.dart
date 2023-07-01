

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/helpers/mostar_modal.dart';
import 'package:serviciosapp/models/adjuntos_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/services/comentarios_flujo_provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:serviciosapp/widgets/fotoDetalle/comentariosFoto.dart';



class FotoDetallePage extends StatefulWidget {
  const FotoDetallePage({super.key});

  @override
  State<FotoDetallePage> createState() => _FotoDetallePageState();
}

class _FotoDetallePageState extends State<FotoDetallePage> {

   final controllerText = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Adjunto foto = ModalRoute.of(context)?.settings.arguments as Adjunto;
  
    

    return  SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
        heroTag: '123',
              onPressed: () {
                mostrarModal(context,
                    accionOk: () async {
                          final request = Provider.of<SwfRequestProvider>(context, listen: false).swfRequest;
                          final Usuario usuario = Provider.of<AuthService>(context, listen: false).usuario;

                          final isOk = await Provider.of<ComentariosflujoProvider>(
                              context,
                              listen: false)
                          .addComentarioConFoto(
                              comentario: controllerText.text,
                              processInstanceid: request.swfStateProcessid,
                              requestid: request.idswfRequest,
                              userid: usuario.idusuario,idadjunto: int.parse(foto.idadjunto));
                          if(isOk){
                            Provider.of<ComentariosflujoProvider>(
                              context,
                              listen: false).comentariosEnFoto(requestid: request.idswfRequest, idadjunto: foto.idadjunto);
                            controllerText.text = '';
                            Navigator.pop(context);
                          }
                    },
                   accionCancel: () {  controllerText .text = ''; Navigator.pop(context);},
                    titulo: 'Comentario',
                    contenido: Container(
                      width: 300,
                      height: 100,
                      child: Card(
                          color: const Color(0xffD9D9D9),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: controllerText,
                              maxLines: 2,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (value) {
                                //TO-DO realizar guardado
                              },
                              decoration: const InputDecoration.collapsed(
                                  hintText: "Ingrese comentario"),
                            ),
                          )),
                    ));
              },
              backgroundColor: const Color(0xff002E53),
              child: const FaIcon(  FontAwesomeIcons.plus),
            ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
                _CustomAppBar(foto: foto),
                 SliverList(
                delegate: SliverChildListDelegate(
                  
                  [
                  const ComentariosFoto()
        
        
                  
                ])
                )
            ],
          ),
        )
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
 final Adjunto foto;

  const _CustomAppBar({super.key, required this.foto});

  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
      pinned: true,
      floating: true,
      excludeHeaderSemantics: true,
      expandedHeight: 300,
     // toolbarHeight: 100,
         backgroundColor: const Color(0xff002E53),
         flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('ID ${foto.idadjunto}'),
          background: Hero(
            tag: 'adjunto${foto.idadjunto}',
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.png'), image: NetworkImage(foto.url),
              fit: BoxFit.cover,
              ),
          ),
         ),
    );
  }
}

