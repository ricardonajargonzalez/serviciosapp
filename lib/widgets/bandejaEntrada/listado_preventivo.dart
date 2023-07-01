import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/services/auth_service.dart';
import 'package:serviciosapp/services/preventivos_provider.dart';
import 'package:serviciosapp/widgets/sin_resultados.dart';

class ListaPreventivos extends StatefulWidget {
  const ListaPreventivos({super.key});

  @override
  State<ListaPreventivos> createState() => _ListaPreventivosState();
}

class _ListaPreventivosState extends State<ListaPreventivos> {
  @override
  void initState() {
    super.initState();
    final Usuario = Provider.of<AuthService>(context, listen: false).usuario;
    Provider.of<PreventivosProvider>(context, listen: false)
        .getListaPreventivos(idusuario: Usuario!.idusuario);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final listPreventivos = Provider.of<PreventivosProvider>(context);
    TextStyle estiloTextbold = const TextStyle(fontWeight: FontWeight.bold);

    return Container(
        width: width,
        height: height,
        // color: Colors.amber,
        child: 
        
         listPreventivos.preventivos.isNotEmpty ?
        ListView.builder(
          physics: const BouncingScrollPhysics(),
            itemCount: listPreventivos.preventivos.length,
            itemBuilder: (BuildContext context, int index) {
              final item_lista = listPreventivos.preventivos[index];
              return GestureDetector(
                onTap: (){
                 // Navigator.pushNamed(context, 'vista_reporte',arguments: ReporteActivoPreventivoCorrectivo(tipo: 'preventivo', reporte: item_lista.idmtoprev));
                 Navigator.pushNamed(context, 'vista_reporte_activo',arguments: ReporteActivoPreventivoCorrectivo(tipo: 'preventivo', reporte: item_lista.idmtoprev, idswf_request: item_lista.idswfrequest));
                   
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xffE7E7E7),
                            offset: Offset(3.0, 1.0), //(x,y)
                            blurRadius: 4.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //id swf
                                Row(children: [
                                  Text("Id swf: ", style: estiloTextbold),
                                  Text('${item_lista.idswfrequest}')
                                ]),
                                //folio
                                Row(children: [
                                  Text("ID: ", style: estiloTextbold),
                                  Text(item_lista.idmtoprev)
                                ]),
                                //Serie
                                Row(children: [
                                  Text("Serie: ", style: estiloTextbold),
                                  Text(item_lista.serie)
                                ]),
                                //ciudad
                                Row(children: [
                                  Text("Ciudad: ", style: estiloTextbold),
                                  Text(item_lista.ciudad)
                                ]),
                                //sucursal
                                Row(children: [
                                  Text("Sucursal: ", style: estiloTextbold),
                                  Text(item_lista.sucursal)
                                ])
                              ],
                            ),
                          )),
                          const Icon(Icons.chevron_right_sharp)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }):
            const SinResultados(msg: "¡No se encontraron reportes asignados!")
            );
  }
}