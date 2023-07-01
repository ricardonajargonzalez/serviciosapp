import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/helpers/mostar_modal.dart';
import 'package:serviciosapp/models/adjuntos_response.dart';
import 'package:serviciosapp/models/comentarios_flujo_response.dart';
import 'package:serviciosapp/models/swf_request_response.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/adjuntos_evidencias_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/services/comentarios_flujo_provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:intl/intl.dart';
import 'package:serviciosapp/widgets/vistaReporte/observaciones.dart';

class ContenedorBackground extends StatefulWidget {
  const ContenedorBackground({super.key});

  @override
  State<ContenedorBackground> createState() => _ContenedorBackgroundState();
}

class _ContenedorBackgroundState extends State<ContenedorBackground> {
  final _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
  }

  final controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigh = MediaQuery.of(context).size.height;
    final swfRequest = Provider.of<SwfRequestProvider>(context).swfRequest;
    final adjuntos = Provider.of<AdjuntosEvidenciasProvider>(context).adjuntos;
    final Usuario usuario = Provider.of<AuthService>(context).usuario;

    return Container(
      // color: Colors.amber,
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Botones(
                picker: _picker,
                swfRequest: swfRequest,
                usuario: usuario,
                controllerText: controllerText,
                width: width),
          ),
          SizedBox(
            height: 120,
            child: ContenedorFotos(width: width, adjuntos: adjuntos),
          ),
          const Expanded(
            child: ContenedorComentarios())
        ],
      ),
    );
  }
}



class Comentarios extends StatelessWidget {
  const Comentarios({
    super.key,
    required this.comentarios,
  });

  final ComentariosResponse comentarios;

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(top: 5),
      width: double.infinity,
     //   color: Colors.amber,
      height: height,
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
          }),
    );
  }
}

class ContenedorFotos extends StatelessWidget {
  const ContenedorFotos({
    super.key,
    required this.width,
    required this.adjuntos,
  });

  final double width;
  final AdjuntosResponse adjuntos;

  @override
  Widget build(BuildContext context) {
    final request = Provider.of<SwfRequestProvider>(context, listen: false).swfRequest;

    return Container(
       // padding: const EdgeInsets.symmetric(horizontal: 5),
        width: width,
        child: FutureBuilder(
            future: Provider.of<AdjuntosEvidenciasProvider>(context)
                .ImagenesFuture(requestid: request.idswfRequest),
            builder: (BuildContext context,
                AsyncSnapshot<AdjuntosResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras el Future está en progreso
                return Container(child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                // Maneja cualquier error que ocurra durante la carga del Future
                return Text('Error: ${snapshot.error}');
              } else {
                // Muestra los datos cargados una vez que el Future se completa
                if (snapshot.data!.results.isNotEmpty) {
                  final adjuntos = snapshot.data;
                  return ListadoFotos(adjuntos: adjuntos, width: width);
                } else {
                  return Container(
                   // child: Image.asset('assets/no-image.png'),
                  );
                }
              }
            })
        );
  }
}

class ListadoFotos extends StatelessWidget {
  const ListadoFotos({
    super.key,
    required this.adjuntos,
    required this.width,
  });

  final AdjuntosResponse? adjuntos;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: adjuntos?.results.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final Adjunto? adjunto = adjuntos?.results[index];
          initializeDateFormatting('es-MX', '');
          final formattedDate =
              DateFormat('d MMMM yyyy').format(adjunto!.created);
          final formattedTime = DateFormat.jms().format(adjunto.created);
          return Container(
              // color: Colors.amber,
              margin: const EdgeInsets.only(left: 5),
              width: adjuntos!.results.length > 1 ? width * 0.8 : width,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      final request = Provider.of<SwfRequestProvider>(context, listen: false).swfRequest;
                      Provider.of<ComentariosflujoProvider>(context,listen: false).comentariosEnFoto(idadjunto: adjunto.idadjunto, requestid: request.idswfRequest );
          
                      Navigator.pushNamed(context, 'foto-detalle', arguments: adjunto);
                      },
                    child: Hero(
                      tag: 'adjunto${adjunto.idadjunto}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/no-image.png'),
                          image: NetworkImage('${adjunto.url}'),
                          width: adjuntos!.results.length > 1 ? width * 0.8 : width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      decoration: const BoxDecoration(
                          color: Color(0xff002E53),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
                      width: 100,
                      height: 25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formattedDate,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'Roboto')),
                          Text(formattedTime,
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'Roboto')),
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

class Botones extends StatelessWidget {
  const Botones({
    super.key,
    required ImagePicker picker,
    required this.swfRequest,
    required this.usuario,
    required this.controllerText,
    required this.width,
  }) : _picker = picker;

  final ImagePicker _picker;
  final SwfRequestResponse swfRequest;
  final Usuario usuario;
  final TextEditingController controllerText;
  final double width;



  @override
  Widget build(BuildContext context) {


  Future<Map<String,dynamic>> onAdjuntarFoto(XFile pickedImage) async{

                  final Map<String,dynamic> isok = await Provider.of<AdjuntosEvidenciasProvider>(context,
                              listen: false)
                          .subirAdjunto(
                              file: pickedImage,
                              processInstanceid: swfRequest.swfStateProcessid,
                              requestid: swfRequest.idswfRequest,
                              userid: usuario.idusuario);

                              return isok;
  }

  void cargarImagenes(){
    Provider.of<AdjuntosEvidenciasProvider>(context,listen: false).Imagenes(requestid: swfRequest.idswfRequest);
  }

  void agregarcomentarioFoto(String foto, String idadjunto){
                    mostrarModal(context,
                    accionOk: ()async{
                          final isOk = await Provider.of<ComentariosflujoProvider>(
                              context,
                              listen: false)
                          .addComentarioConFoto(
                              comentario: controllerText.text,
                              processInstanceid: swfRequest.swfStateProcessid,
                              requestid: swfRequest.idswfRequest,
                              userid: usuario.idusuario,idadjunto: int.parse(idadjunto));
                          if(isOk){
                            controllerText.text = '';
                            Navigator.pop(context);
                          }
                    },
                    accionCancel: () {  controllerText.text = ''; Navigator.pop(context);},
                    titulo: 'Comentario y/u observación',
                    contenido: Container(
                       width: 400,
                      child: Column(
                        children: [
                          ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                                        width: double.infinity,
                                        child: FadeInImage(
                                          placeholder: const AssetImage('assets/no-image.png'),
                                          image: NetworkImage(foto),
                                          fit: BoxFit.cover,
                                          height: 200,
                                        ),
                                      ),
                          ),
                          Container(
                            width: width,
                            height: 100,
                            child: Card(
                                color: const Color(0xffD9D9D9),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: 
                                      TextField(
                                        controller: controllerText,
                                        maxLines: 2,
                                        keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.done,
                                        autofocus: true,
                                        onSubmitted: (value) {
                                          //TO-DO realizar guardado
                                        },
                                        decoration: const InputDecoration.collapsed(
                                            hintText: "Ingrese comentario"),
                                      ),
                                )),
                          ),
                        ],
                      ),
                    ));
  }


    return SizedBox(
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                final XFile? pickedImage = await _picker.pickImage(
                    source: ImageSource.camera,
                    maxHeight: 480,
                    maxWidth: 640,
                    imageQuality: 50);

                if (pickedImage != null) {
                     final isok = await  onAdjuntarFoto(pickedImage);
                  if (isok['status']) {
                      //RECARGAR IMAGENES
                       cargarImagenes();
                      //ABRIMOS MODAL PARA GUARDAR COMENTARIO
                      agregarcomentarioFoto(isok['foto'], isok['idadjunto']);
                  }
                }
              },
              icon: const FaIcon(FontAwesomeIcons.camera,size: 20)),
          IconButton(
              onPressed: () {
                mostrarModal(context,
                    accionOk: () async {
                      final isOk = await Provider.of<ComentariosflujoProvider>(
                              context,
                              listen: false)
                          .addComentario(
                              comentario: controllerText.text,
                              processInstanceid: swfRequest.swfStateProcessid,
                              requestid: swfRequest.idswfRequest,
                              userid: usuario.idusuario);
                      if (isOk) {
                        // print("comentario agregado");
                        controllerText.text = '';
                      }
                    },
                   accionCancel: () {  controllerText.text = ''; Navigator.pop(context);},
                    titulo: 'Comentario',
                    contenido: Container(
                      width: width,
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
              icon: const FaIcon(FontAwesomeIcons.solidCommentDots,size: 20)),
        ],
      ),
    );
  }
}
