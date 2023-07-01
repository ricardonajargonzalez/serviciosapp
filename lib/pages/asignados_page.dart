
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/confirmados_response.dart';
import 'package:serviciosapp/models/pendientes_response.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/services/asignados_provider.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/widgets/app_bar_custom.dart';
import 'package:animate_do/animate_do.dart';
import 'package:serviciosapp/widgets/menu.dart';
import 'package:serviciosapp/widgets/sin_resultados.dart';

class AsignadosPage extends StatefulWidget {
  const AsignadosPage({super.key});

  @override
  State<AsignadosPage> createState() => _AsignadosPageState();
}

class _AsignadosPageState extends State<AsignadosPage> {
  int listaPorconfirmar = 0;


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final asignadosPendientes = Provider.of<AsignadosProvider>(context,listen: false);

    final Usuario usuario = Provider.of<AuthService>(context, listen: false).usuario;
    Provider.of<AsignadosProvider>(context,listen: false).getPendingList( idusuario: usuario.idusuario );
    final bool autenticado  = Provider.of<AuthService>(context, listen: false).autenticado;


    return Scaffold(
        drawer: const Menu(),
        //appBar: AppBarCustom(appBar: AppBar()),
        appBar: AppBarCustom(appBar: AppBar(automaticallyImplyLeading: false )),
        body: Container(
          color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: width,
            height: height,
            child:  const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("REPORTES ASIGNADOS",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                 SizedBox(
                  height: 5,
                ),
                 Expanded(child: ListadoPendientesWidget())
              ],
            )),
             floatingActionButton: asignadosPendientes.totalSeleccionados == 0   ? null  // no mostrar boton
              : BotonConfirmar(asignadosPendientes: asignadosPendientes)                    // Mostrar boton flotante
            );
  }
}

class BotonConfirmar extends StatelessWidget {
  const BotonConfirmar({
    super.key,
    required this.asignadosPendientes,
  });

  final AsignadosProvider asignadosPendientes;
  

  @override
  Widget build(BuildContext context) {

    final Usuario usuario = Provider.of<AuthService>(context).usuario;

    return SlideInUp(
      child: Bounce(
        child: FloatingActionButton.extended(
            onPressed: () async {
              //CONFIRMAR TODOS LOS REPORTES SELECCIONADOS
              final ConfirmadosResponse respAsignados    = await asignadosPendientes.confirm(idusuario: usuario.idusuario); 
              final totalSeleccionados =  asignadosPendientes.totalSeleccionados;
              final totalConfirmados =  asignadosPendientes.totalconfirmados;

              // print(asignado.toString());
              // print(totalConfirmados.toString());

              //SI SOLO SE CONFIRMA UNO, NOS DIRIGIMOS AL REPORTE ACTIVO
              if( respAsignados.result == true && respAsignados.process.length == 1){
                  // print(respAsignados.process[0].acciones[0].swfRequestid); // TODO =========================================================$%&$%&



                   final ListaPendiente reporte = asignadosPendientes.listaConfirmados[0];
                   Navigator.pushNamed(context, 'vista_reporte_activo',arguments: ReporteActivoPreventivoCorrectivo(tipo: reporte.tipo , reporte: reporte.idreporte, idswf_request: respAsignados.process[0].acciones[0].swfRequestid));            
              }

              //MOSTRAR MENSAJE
              if (respAsignados.result && respAsignados.process.length > 1) { 
                final snackBar = SnackBar(
                  backgroundColor: const Color(0xff002E53),
                  content: const Text('Se asiginaron los reportes correctamente!',style: const TextStyle(color: Colors.white),),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                showSnackBar(context,snackBar);
              }
              
              
              if(respAsignados.result == false){
                final snackBar = SnackBar(
                  backgroundColor: Colors.red[400],
                  content: Text('Ocurrio un error',style: const TextStyle(color: Colors.white),),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                showSnackBar(context,snackBar);
              }
                 
              
            },
            label: Text(
                'Confirmar ${asignadosPendientes.totalSeleccionados}'),
            icon: const Icon(Icons.check),
            backgroundColor: const Color(0xff002E53),
          ),
      ),
    );
  }
}

void showSnackBar(BuildContext context,SnackBar snackBar){
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class ListadoPendientesWidget extends StatefulWidget {
  const ListadoPendientesWidget({super.key});

  @override
  State<ListadoPendientesWidget> createState() =>
      _ListadoPendientesWidgetState();
}

class _ListadoPendientesWidgetState extends State<ListadoPendientesWidget> {
  @override
  void initState() {
    super.initState();
   // final Usuario usuario = Provider.of<AuthService>(context, listen: false).usuario;
    //Provider.of<AsignadosProvider>(context, listen: false).getPendingList(idusuario: usuario.idusuario);
  }

  Future<void> onRefresh()async{
    final Usuario usuario = Provider.of<AuthService>(context, listen: false).usuario;
    await Provider.of<AsignadosProvider>(context,listen: false).getPendingList(idusuario: usuario.idusuario);
  }

  @override
  Widget build(BuildContext context) {
    final listaAsignados =
        Provider.of<AsignadosProvider>(context).onDisplayListaPendings;
    List<ListaPendiente> listTemp = listaAsignados;

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final asignadosPendientes = Provider.of<AsignadosProvider>(context);

    return RefreshIndicator(
        color: const Color(0xff002E53),
        onRefresh: onRefresh,
      child: SizedBox(
        width: width,
        height: height,
        child: 
         listaAsignados.isEmpty ? 
           ListView(
            children: [
               SizedBox(
                width: width,
                height: height,
                child: const SinResultados(msg: "No cuenta con reportes asignados!")
               )
            ])
        :
      ListView.builder(
          padding: const EdgeInsets.only(bottom: 50, top: 20), //
          itemCount: listaAsignados.length,
          itemBuilder: (BuildContext context, int index) {
            final listaItem = listTemp[index];
        
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffE7E7E7),
                        offset: Offset(3.0, 1.0), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CustomPaint(
                      painter: _HeaderCurvoWavesPainter(),
                      child: SizedBox(
                        height: 100,
                        //color: Colors.amber,
                        child: Row(
                          children: [
                            InfoItem(itemPendiente: listaItem),
                            Container(
                              alignment: Alignment.center,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                                checkColor: Colors.black,
                                //fillColor: MaterialStateProperty.resolveWith(getColor),
                                activeColor: Colors.white,
                                hoverColor: Colors.white,
                                value: listaItem.isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    listTemp[index].isChecked = value!;
                                    if (value == true) {
                                      asignadosPendientes
                                          .addSeleccion(listaItem);
                                    } else {
                                      asignadosPendientes
                                          .decreaseSeleccion(listaItem.folio);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
      ),
    );
  }
}

class _HeaderCurvoWavesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //propiedades
    final paint = Paint();
    paint.color = const Color(0xff002E53);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    //Dibuajar con path y lapis
    final path = Path();
    path.moveTo(size.width * 0.87, 0);

    path.lineTo(size.width * 0.87, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    //aplicamos lo dibujado
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class InfoItem extends StatelessWidget {
  final ListaPendiente itemPendiente;
  const InfoItem({
    super.key,
    required this.itemPendiente,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle estiloTextbold = TextStyle(fontWeight: FontWeight.bold);

    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(left: 5.0),
      // color: Colors.amberAccent,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                    //id
          Row(children: [
            Text("ID: ", style: estiloTextbold),
            Text(itemPendiente.idreporte)
          ]),
          //folio
          Row(children: [
            Text("Folio: ", style: estiloTextbold),
            Text(itemPendiente.folio)
          ]),
          //cliente
          Row(children: [
            Text("Cliente: ", style: estiloTextbold),
            Text(itemPendiente.cliente)
          ]),
          //Tipo
          Row(children: [
            Text("Tipo: ", style: estiloTextbold),
            Text(itemPendiente.tipo)
          ]),
        ],
      ),
    ));
  }
}
