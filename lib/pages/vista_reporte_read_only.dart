import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/accion_ejecutado_response.dart';
import 'package:serviciosapp/models/acciones_disponibles_response.dart';
import 'package:serviciosapp/models/pendientes_response.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/pages/asignados_page.dart';
import 'package:serviciosapp/services/acciones_disponibles_flujo.dart';
import 'package:serviciosapp/services/acciones_menu_button_provider.dart';
import 'package:serviciosapp/services/asignados_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/services/checklist_provider.dart';
import 'package:serviciosapp/services/flujo_wizard_provider.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';
import 'package:serviciosapp/widgets/app_bar_custom.dart';
import 'package:serviciosapp/widgets/vistaReporte/draggable_general.dart';
import 'package:serviciosapp/widgets/boton_azul.dart';

class VistaReporteActivoReadOnly extends StatefulWidget {
  const VistaReporteActivoReadOnly({super.key});

  @override
  State<VistaReporteActivoReadOnly> createState() =>
      _VistaReporteActivoReadOnlyState();
}

class _VistaReporteActivoReadOnlyState
    extends State<VistaReporteActivoReadOnly> {
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
    final reporteR = Provider.of<ReporteActivoProvider>(context, listen: false).getReporteActivo(parametros.reporte, parametros.tipo);
    //PROVIDER PARA CARGAR CHECKLIST
    Provider.of<CheckListProvider>(context, listen: false).obtenerCheckList();
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        minimumSize: const Size(88, 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: const StadiumBorder() //border redondos
        );

    return Scaffold(
        appBar: AppBarCustom(appBar: AppBar()),
        body: SingleChildScrollView(
          child: Container(
            // color: Colors.amber,
            width: width,
            height: heigh - 80,
            child: Stack(
              children: [
                DraggagleGeneral(
                    initialChildSize: 0.99,
                    maxChildSize: 0.99,
                    minChildSize: 0.99),
                Positioned(
                    bottom: 5,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: width,
                        height: 60,
                        // color: Colors.amber,
                        child: BottonAzul(
                            raisedButtonStyle: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xff002E53),
                                minimumSize: Size(88, 36),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                shape: StadiumBorder() //border redondos
                                ),
                            onPress: () {
                               final Usuario usuario = Provider.of<AuthService>(context,listen: false).usuario;
                               final item = ListaPendiente(idreporte: parametros.reporte, folio: '', cliente: '', fecha: DateTime.now(), tipo: parametros.tipo);
                               List<ListaPendiente>  lista = [];
                               lista.add(item);
                               Provider.of<AsignadosProvider>(context, listen: false).confirmarSingleReporte(idusuario: usuario.idusuario, listaSeleccionados: lista);
                            },
                            text: "CONFIRMAR")))
              ],
            ),
          ),
        ));
  }
}

class ContenedorAccionesDisponibles extends StatelessWidget {
  final ReporteActivoPreventivoCorrectivo reporte;
  const ContenedorAccionesDisponibles({
    super.key,
    required this.reporte,
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

    return acciones.isNotEmpty
        ? Positioned(
            bottom: accionMenu.isActive ? 10 : 60,
            right: accionMenu.isActive ? (width * 0.44) : 10,
            child: Container(
              // width: 50,
              // height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  final accionMenu =
                      Provider.of<AccionesMenuButton>(context, listen: false);
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
    required this.raisedButtonStyle,
    required this.reporte,
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
                              userid: accionDisponible.swfUserid,
                              reporte: reporte);

                  if (respuesta.status) {
                    Provider.of<SwfRequestProvider>(context, listen: false)
                        .getSwfRequest(
                            requestid: respuesta.idswfrequest.toString());
                    Provider.of<FlujoWizardProvider>(context, listen: false)
                        .cargarWizard(
                            idswf_request: respuesta.idswfrequest.toString());
                  } else {
                    final snackBar = SnackBar(
                      padding: EdgeInsets.all(13),
                      backgroundColor: const Color(0xff002E53),
                      content: Text(
                        respuesta.msg,
                        style: const TextStyle(color: Colors.white),
                      ),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );
                    showSnackBar(context, snackBar);
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
