import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/helpers/utils.dart';
import 'package:serviciosapp/models/consumibles_agregados_response.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/search/consumiblesRefacciones_delegate.dart';
import 'package:serviciosapp/services/consumibles_refacciones_provider.dart';

class ConsumiblesRefaccionesPage extends StatelessWidget {
  const ConsumiblesRefaccionesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReporteActivoPreventivoCorrectivo reporte = ModalRoute.of(context)!
        .settings
        .arguments as ReporteActivoPreventivoCorrectivo;
    Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false)
        .consumiblesAgregados(
            idReporte: int.parse(reporte.reporte), tipo: reporte.tipo);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff002E53),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate:
                          ConsumiblesRefaccionesDelegate(reporte: reporte));
                },
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                ))
          ],
        ),
        body: ListaConsumiblesAgregados(reporte: reporte));
  }
}

class ListaConsumiblesAgregados extends StatefulWidget {

         
  final ReporteActivoPreventivoCorrectivo reporte;

  const ListaConsumiblesAgregados({
    super.key,
    required this.reporte
  });

  @override
  State<ListaConsumiblesAgregados> createState() =>
      _ListaConsumiblesAgregadosState();
}

class _ListaConsumiblesAgregadosState extends State<ListaConsumiblesAgregados> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ConsumiblesAgregadosResponse consumiblesAgregados = Provider.of<ConsumiblesRefaccionesProvider>(context).getconsumiblesAgregados;
    List<TextEditingController> _controllers = [];

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: consumiblesAgregados.result.length,
          itemBuilder: (BuildContext context, int index) {
            final consumibleAgregado = consumiblesAgregados.result[index];
            TextEditingController textcontroller = TextEditingController(text: consumibleAgregado.cantidad);
            _controllers.add(textcontroller);
            return GestureDetector(
              onTap: () {
                print(consumibleAgregado.cantidad);
              },
              child: Card(
                child: Dismissible(
                  onDismissed: (direction)async {
                    final bool isDelete = await  Provider.of<ConsumiblesRefaccionesProvider>(context,listen: false).deleteconsumible(idReporte: int.parse( widget.reporte.reporte) , idConsumible: int.parse( consumibleAgregado.idconsumiblerep ), tipo : widget.reporte.tipo);
                  },
                  direction: DismissDirection.startToEnd,
                  background: Container(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            "Eliminar",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      color: Colors.red),
                  key: Key(consumibleAgregado.codigo),
                  child: Container(
                    width: double.infinity,
                    //color: Colors.amber,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID consumible: ${consumibleAgregado.idconsumible}'),
                              Row(
                                children: [
                                  const Text('Codigo: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(consumibleAgregado.codigo),
                                ],
                              ),
                              Text(
                                consumibleAgregado.descripcion,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Container(
                            width: 150,
                            //color: Colors.blue,
                            child: Row(
                              children: [
                                Expanded(
                                  child: IconButton(
                                      onPressed: ()async {
                                          final bool isOk = await disminuirConsumible( idReporte: int.parse( widget.reporte.reporte), idConsumible: int.parse( consumibleAgregado.idconsumible ), tipo: widget.reporte.tipo );
                                          
                                          if(isOk){
                                                cargarConsumibles(idReporte: int.parse( widget.reporte.reporte), tipo: widget.reporte.tipo);
                                          }else{
                                              final SnackBar snackBar = warningMensaje('Ocurrio un error al quitar el consumible');
                                              crearSnackBar(snackBar: snackBar);
                                          }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.circleMinus,
                                          size: 18)),
                                ),
                                Container(
                                  width: 50,
                                  child: TextFormField(
                                    controller: _controllers[index],
                                    textAlign: TextAlign.center,
                                    //initialValue:  consumibleAgregado.cantidad,
                                  decoration:  InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                   border: InputBorder.none,
                                   focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                     borderRadius: BorderRadius.circular(2.0),
                                     gapPadding: 0.0
                                   )
                                  ),
                                      ),
                                ),
                                Expanded(
                                  child: IconButton(
                                      onPressed: ()async {
                                          final bool isOk = await agregarCantidadConsumible( idReporte: int.parse( widget.reporte.reporte), idConsumible: int.parse( consumibleAgregado.idconsumible ), tipo: widget.reporte.tipo );
                                          
                                          if(isOk){
                                                cargarConsumibles(idReporte: int.parse( widget.reporte.reporte), tipo: widget.reporte.tipo);
                                          }else{
                                              final SnackBar snackBar = warningMensaje('Ocurrio un error al agregar el consumible');
                                              crearSnackBar(snackBar: snackBar);
                                          }
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.circlePlus,
                                          size: 18)),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  //metodos void

  void cargarConsumibles({required int idReporte, required String tipo}){
    Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false).consumiblesAgregados(idReporte: idReporte, tipo: tipo );  
  }

  Future<bool> agregarCantidadConsumible({required int idReporte, required String tipo, required int idConsumible}) async{
    
     final bool isOk = await  Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false).agregarconsumible( idReporte: idReporte, idConsumible: idConsumible, tipo: tipo);
     return isOk;
  }

  Future<bool> disminuirConsumible({required int idReporte, required String tipo, required int idConsumible}) async{
    
     final bool isOk = await  Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false).dismunuirConsumible( idReporte: idReporte, idConsumible: idConsumible, tipo: tipo);
     return isOk;
  }

  void crearSnackBar({required SnackBar snackBar}){
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showSnackBar(context,snackBar);
  }



}
