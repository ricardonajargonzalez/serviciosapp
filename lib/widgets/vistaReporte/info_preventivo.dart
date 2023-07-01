

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/checklist_provider.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:serviciosapp/models/checklist_response.dart';
import 'package:serviciosapp/helpers/utils.dart';
import 'package:serviciosapp/services/swf_request_provider.dart';


class InfoPreventivo extends StatefulWidget {
  const InfoPreventivo({
    super.key,
    required this.estiloTextboldWhite,
    required this.estiloTextWhite,
  });

  final TextStyle estiloTextboldWhite;
  final TextStyle estiloTextWhite;

  @override
  State<InfoPreventivo> createState() => _InfoPreventivoState();
}



class _InfoPreventivoState extends State<InfoPreventivo> {

  
  


  @override
  Widget build(BuildContext context) {
    final reporteActivo = Provider.of<ReporteActivoProvider>(context);



    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    //estilos para checklist
    const TextStyle estilotitulo = TextStyle(
        color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13);
    const TextStyle estiloSubtitulos = TextStyle(color: Colors.black54);
    const BoxDecoration decoration = BoxDecoration(
        color: Color(0xff002E53),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)));

    return Container(
      width: double.infinity,
      height: height - (height * 0.13) -100,
     // color: Colors.amber,
      child: Column(
        children: [
         const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
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
                              Text("Cliente: ", style: widget.estiloTextboldWhite ),
                              Expanded(
                                  child: Text(
                                      '${reporteActivo.preventivoActivo.cliente}',
                                      style: widget.estiloTextWhite,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                          //Sucursal
                          Row(
                            children: [
                              Text("Sucursal: ", style: widget.estiloTextboldWhite),
                              Expanded(
                                  child: Text(
                                      '${reporteActivo.preventivoActivo.sucursal}',
                                      style: widget.estiloTextWhite,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                          //ciudad
                          Row(
                            children: [
                              Text("Ciudad: ", style: widget.estiloTextboldWhite),
                              Expanded(
                                  child: Text(
                                      '${reporteActivo.preventivoActivo.ciudad}',
                                      style: widget.estiloTextWhite,
                                      overflow: TextOverflow.ellipsis))
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
                            Text("ID: ", style: widget.estiloTextboldWhite),
                            Text(
                              reporteActivo.preventivoActivo.idmtoprev,
                              style: widget.estiloTextWhite,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),

                        //Fecha Serie
                        Row(
                          children: [
                            Text("Serie: ", style: widget.estiloTextboldWhite),
                            Expanded(
                                child: Text(
                              '${reporteActivo.preventivoActivo.serie}',
                              style: widget.estiloTextWhite,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        //Fecha inicio
                        Row(
                          children: [
                            Text("Fecha: ", style: widget.estiloTextboldWhite),
                            Expanded(
                                child: Text(
                              '${reporteActivo.preventivoActivo.fechaInicio}',
                              style: widget.estiloTextWhite,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
           Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 70),
             //  color: Colors.blue,
              width: double.infinity,
              height: double.infinity,
              child: CheckList(),
            ),
          )
        ],
      ),
    );
  }
}

class CheckList extends StatelessWidget {
  const CheckList({
    super.key,
  });

 

  @override
  Widget build(BuildContext context) {

      final CheckListResponse checkList = Provider.of<CheckListProvider>(context).checkList;

    return ListView.builder(
     itemCount: checkList.informacion.length,
      scrollDirection: Axis.horizontal, 
      itemBuilder: (BuildContext context, int index) { 
          final itemModulo = checkList.informacion[index];
          int indexModulo = index + 1; // por cuestion de indice 0
          return ContenedorModulo(itemModulo: itemModulo, indexModulo: indexModulo);
       },
    );
  }
}

class ContenedorModulo extends StatelessWidget {

   final Informacion itemModulo;
   final int indexModulo;

  const ContenedorModulo({super.key, required this.itemModulo, required this.indexModulo});

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
     List<Datos> datos = itemModulo.datos;

 //print(itemModulo.datos.toString());
  
    return Card(
      elevation: 10,
      child: SizedBox(
          width: width * 0.90,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: decoration,
                width: double.infinity,
                child:  Text(itemModulo.modulo,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
               Expanded(
                child: SizedBox(
                  //  color: Colors.amber,
                  width: double.infinity,
                  child:  datosCheckList(listadoDatos:  itemModulo.datos, indexModulo : indexModulo )
                ),
              )
            ],
          )),
    );
  }
}

class datosCheckList extends StatelessWidget {

  final List<Datos> listadoDatos;
  final int indexModulo;
  const datosCheckList({required this.listadoDatos, required this.indexModulo});



 

  @override
  Widget build(BuildContext context) {

  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

    return Container(
     // color: Colors.red,
      width: double.infinity,
      height: height,
      child: ListView.builder(
       // physics: BouncingScrollPhysics(),
        itemCount: listadoDatos.length,
        itemBuilder: (BuildContext context, int index) { 
           // print('encabezadoo ${index}');
            final dato = listadoDatos[index];
            final int indexEncabezado = index; //por cuestion de indice 0
            return Column(
              children: [
                Text(dato.encabezado, style: estilotitulo),
                //controles (checkbox y Textfield)
                  Controles( 
                     opciones: dato.opciones,
                     //modulo 
                     indexModulo: indexModulo,
                     //indice
                     indexEncabezado: indexEncabezado
                  )
              ],
            );
         }),
    );
    
  }
}

class Controles extends StatelessWidget {
  final List<Opcione> opciones;
  final int indexModulo;
  final int indexEncabezado;
  const Controles({required this.opciones, required this.indexModulo, required this.indexEncabezado});

  @override
  Widget build(BuildContext context) {

     Provider.of<CheckListProvider>(context);


     
      return Container(
        width: double.infinity,
       // color: Colors.blue,
        //height: 125,
        child: GridView.count(
          crossAxisCount: 3,
         // childAspectRatio: (itemWidth / itemHeight),
        controller: new ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
          children: List.generate(
            opciones.length, (index) => Column(
              children: [
                Text(opciones[index].descripcion),
                opciones[index].tipoControl == 'C' 
                ? Checkbox(value: opciones[index].value == '1' ? true : false,
                   onChanged: (bool? value) async{
                      final indexControl = index;
                      final cklEncabezadoid = opciones[index].cklEncabezadoid;
                      final idcklDetalle = opciones[index].idcklDetalle;
                      final String requestid = await Provider.of<SwfRequestProvider>(context, listen: false).swfRequest.idswfRequest;

                      Provider.of<CheckListProvider>(context, listen: false).onChecked(
                        ord_enc_json: indexEncabezado, 
                        ord_mod_json: indexModulo - 1, 
                        modulo:  indexModulo, 
                        cklEncabezadoid: int.parse(cklEncabezadoid),
                        control: indexControl, 
                        value: value, 
                        requestid: int.parse(requestid),
                        idcklDetalle: int.parse(idcklDetalle));
                })
                : TextField()
              ],
            ))
        )
      );
  }
}