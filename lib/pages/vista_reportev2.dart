import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/accion_ejecutado_response.dart';
import 'package:serviciosapp/models/acciones_disponibles_response.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/pages/asignados_page.dart';
import 'package:serviciosapp/services/acciones_disponibles_flujo.dart';
import 'package:serviciosapp/services/acciones_menu_button_provider.dart';
import 'package:serviciosapp/services/adjuntos_evidencias_provider.dart';
import 'package:serviciosapp/services/checklist_provider.dart';
import 'package:serviciosapp/services/comentarios_flujo_provider.dart';
import 'package:serviciosapp/services/flujo_wizard_provider.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:serviciosapp/widgets/app_bar_custom.dart';
import 'package:serviciosapp/widgets/vistaReporte/boton_consumibles_refacciones.dart';
import 'package:serviciosapp/widgets/vistaReporte/contenedor_background.dart';
import 'package:serviciosapp/widgets/vistaReporte/draggable_general.dart';
import 'package:serviciosapp/widgets/vistaReporte/wizard_status.dart';
import 'package:serviciosapp/widgets/boton_azul.dart';
import 'package:serviciosapp/widgets/vistaReporte/boton_firma.dart';

class VistaReporteActivo extends StatefulWidget {
  static const routeName = 'vista_reporte_activo';

  const VistaReporteActivo({super.key});

  @override
  State<VistaReporteActivo> createState() => _VistaReporteActivoState();
}

class _VistaReporteActivoState extends State<VistaReporteActivo> {
  ReporteActivoPreventivoCorrectivo parametros =
      ReporteActivoPreventivoCorrectivo(
          reporte: '', tipo: '', idswf_request: '');

  int status = 0;

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final heigh = MediaQuery.of(context).size.height;

       //PARAMETROS
    parametros = ModalRoute.of(context)!.settings.arguments
        as ReporteActivoPreventivoCorrectivo;
    //REPORTE ACTIVO ITEM
    final reporteR = Provider.of<ReporteActivoProvider>(context, listen: false)
        .getReporteActivo(parametros.reporte, parametros.tipo);
    final idswf_request = parametros.idswf_request;
    //PROVIDER ACCIONES/BOTONES ACTIVOS
    Provider.of<AccionesDisponiblesFlujo>(context, listen: false)
        .acciones(idswf_request: idswf_request);
    //PROVIDER PARA CARGAR LOS PASOS DEL WIZARD
    Provider.of<FlujoWizardProvider>(context, listen: false)
        .cargarWizard(idswf_request: idswf_request);
    //PROVIDER SWF REQUEST
    Provider.of<SwfRequestProvider>(context, listen: false)
        .getSwfRequest(requestid: idswf_request);
    //PROVIDER CARGAR IMAGENES/EVIDENCIAS
    Provider.of<AdjuntosEvidenciasProvider>(context, listen: false)
        .Imagenes(requestid: idswf_request);
    //PROVIDER PARA CARGAR LOS COMENTARIOS DEL FLUJO
     Provider.of<ComentariosflujoProvider>(context,listen: false).verObservaciones(requestid: parametros.idswf_request);
     //PROVIDER PARA CARGAR CHECKLIST
     Provider.of<CheckListProvider>(context,listen: false).obtenerCheckList();



    return Scaffold(
        appBar: AppBarCustom(appBar: AppBar()),
        body: SingleChildScrollView(
          child: SizedBox(
            // color: Colors.amber,
            width: width,
            height: heigh-80,
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  height: heigh,
                  child: Column(
                    children: [
                      //COMPONENTE WIZZARD PARA MOSTRAR EL ESTATUS 10%
                      SizedBox(
                         // color: Colors.blueAccent,
                          height: heigh * 0.10,
                          child: const WizardStatus()),
                      //COMPONTE MOSTRAR FOTOS, VIDEOS , COMENTARIOS ETC
                      SizedBox(
                            height: heigh * 0.77,
                           // color: Colors.grey,
                            child: const ContenedorBackground()
                      ),
                    ],
                  ),
                ),
                const DraggagleGeneral(initialChildSize: 0.19,  maxChildSize: 0.87,  minChildSize: 0.04 ), //CONTENEDOR DE HOJA GENERAL - INFO GENERAL Y CHECKLIST(preventivo)
                ContenedorAccionesDisponibles(reporte: parametros), //CONTENEDOR DE BOTONES DISPONIBLES DEL FLUJO
                const MenuFlotante(), //BOTON FLOTANTE QUE MUESTRA/OCULTA LAS ACCIONES DISPONIBLES
                const Botonfirma(), //BOTON PARA COMPONENTE DE FIRMA
                 BotonConsumiblesRefacciones(reporte: parametros) //BOTON PARA PANTALLA CONSUMIBLES/REFACCIONES
              ],
            ),
          ),
        ));
  }
}



class ContenedorAccionesDisponibles extends StatelessWidget {
  final ReporteActivoPreventivoCorrectivo reporte;
  const ContenedorAccionesDisponibles({
    super.key, required this.reporte,
  });

  @override
  Widget build(BuildContext context) {
    final accionMenu = Provider.of<AccionesMenuButton>(context);
    final width = MediaQuery.of(context).size.width;
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        minimumSize: const Size(88, 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: const StadiumBorder() //border redondos
        );

    return Positioned(
                  bottom: 15,
                  child: accionMenu.isActive
                      ? Container(
                          // color: Colors.grey,
                          width: width,
                          height: 40,
                          child: AccionesActivas(
                              raisedButtonStyle: raisedButtonStyle, reporte: reporte))
                      : Container(),
                );
  }
}

class MenuFlotante extends StatelessWidget {
  const MenuFlotante({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

     final accionMenu = Provider.of<AccionesMenuButton>(context);
     final width = MediaQuery.of(context).size.width;
     final acciones = Provider.of<AccionesDisponiblesFlujo>(context).onAcciones;

    return  
            acciones.isNotEmpty ?
              Positioned(
                    bottom: accionMenu.isActive ? 10 : 60,
                    right: accionMenu.isActive ? (width * 0.44) : 10,
                    child: Container(
                      // width: 50,
                      // height: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          final accionMenu = Provider.of<AccionesMenuButton>(
                              context,
                              listen: false);
                          accionMenu.setActive();
                        },
                        backgroundColor: Color(0xff002E53),
                        child: FaIcon(accionMenu.isActive
                            ? FontAwesomeIcons.xmark
                            : FontAwesomeIcons.barsStaggered),
                      ),
                    ))
            : Container();
  }
}

class AccionesActivas extends StatelessWidget {
  final ReporteActivoPreventivoCorrectivo reporte;
  const AccionesActivas({
    super.key,
    required this.raisedButtonStyle, required this.reporte,
  });

  final ButtonStyle raisedButtonStyle;

  @override
  Widget build(BuildContext context) {
    final accionesdisponibles =
        Provider.of<AccionesDisponiblesFlujo>(context).getAcciones;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: accionesdisponibles.length,
        itemBuilder: (BuildContext context, int index) {
          print(accionesdisponibles.length);
          final AccionesDisponiblesResponse accionDisponible =
              accionesdisponibles[index];

          return Container(
            height: 80,
            width: 200,
            margin: const EdgeInsets.only(right: 3),
            child: BottonAzul(
                raisedButtonStyle: raisedButtonStyle,
                text: accionDisponible.swfActionName,
                onPress: () async {
                 // print("here");
                  final AccionEjecutadoResponse respuesta =
                      await Provider.of<AccionesDisponiblesFlujo>(context,
                              listen: false)
                          .ejecutarAccion(
                              idswf_request: accionDisponible.idswfRequest,
                              actionid: accionDisponible.swfActionid,
                              transitionid: accionDisponible.swfTransitionid,
                              userid: accionDisponible.swfUserid, reporte: reporte);
                     

                  if (respuesta.status) {
                    Provider.of<SwfRequestProvider>(context, listen: false)
                        .getSwfRequest(
                            requestid: respuesta.idswfrequest.toString());
                    Provider.of<FlujoWizardProvider>(context, listen: false)
                        .cargarWizard(
                            idswf_request: respuesta.idswfrequest.toString());
                  }else{
                    
                    final snackBar = SnackBar(
                      padding: EdgeInsets.all(13),
                      backgroundColor: const Color(0xff002E53),
                      content:  Text(respuesta.msg ,style: const TextStyle(color: Colors.white),),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    showSnackBar(context,snackBar);
                  }
                }),
          );
        });
  }
}


/*
class InfoCorrectivo extends StatelessWidget {
  const InfoCorrectivo({
    super.key,
    required this.estiloTextboldWhite,
    required this.estiloTextWhite,
  });

  final TextStyle estiloTextboldWhite;
  final TextStyle estiloTextWhite;

  @override
  Widget build(BuildContext context) {
    final reporteActivo = Provider.of<ReporteActivoProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //columna 1
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Cliente
                      Row(
                        children: [
                          Text("Cliente: ", style: estiloTextboldWhite),
                          Expanded(
                              child: Text(
                                  '${reporteActivo.correctivoActivo.cliente}',
                                  style: estiloTextWhite,
                                  overflow: TextOverflow.ellipsis))
                        ],
                      ),
                      //Sucursal
                      Row(
                        children: [
                          Text("Sucursal: ", style: estiloTextboldWhite),
                          Expanded(
                              child: Text(
                                  '${reporteActivo.correctivoActivo.sucursal}',
                                  style: estiloTextWhite,
                                  overflow: TextOverflow.ellipsis))
                        ],
                      ),

                      //Fecha Inicio
                      Row(
                        children: [
                          Text("Fecha inicio: ", style: estiloTextboldWhite),
                          Expanded(
                              child: Text(
                            '${reporteActivo.correctivoActivo.fechaInicio}',
                            style: estiloTextWhite,
                            overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 7),
            //columna 2
            Expanded(
              child: Container(
                // color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ID
                    Row(
                      children: [
                        Text("Folio: ", style: estiloTextboldWhite),
                        Text(
                          reporteActivo.correctivoActivo.idreporte,
                          style: estiloTextWhite,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    //Fecha compromiso
                    Row(
                      children: [
                        Text("Fecha compromiso: ", style: estiloTextboldWhite),
                        Expanded(
                            child: Text(
                          '${reporteActivo.correctivoActivo.fechaCompromiso != null ? reporteActivo.correctivoActivo.fechaCompromiso : ''}',
                          style: estiloTextWhite,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    //Hora compromiso
                    Row(
                      children: [
                        Text("Hora compromiso: ", style: estiloTextboldWhite),
                        Expanded(
                            child: Text(
                          '${reporteActivo.correctivoActivo.horaCompromiso != null ? reporteActivo.correctivoActivo.horaCompromiso : ''}',
                          style: estiloTextWhite,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Motivo: ",
                style: estiloTextboldWhite,
              ),
              Expanded(
                  child: Text(reporteActivo.correctivoActivo.motivo,
                      style: estiloTextWhite, overflow: TextOverflow.ellipsis))
            ],
          ),
        )
      ],
    );
  }
}

*/
