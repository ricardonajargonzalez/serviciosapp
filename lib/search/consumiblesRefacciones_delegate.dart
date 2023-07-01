

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/models/search_consumibles_response.dart';
import 'package:serviciosapp/services/consumibles_refacciones_provider.dart';
import 'package:serviciosapp/widgets/consumible.dart';

class ConsumiblesRefaccionesDelegate extends SearchDelegate {
  
  final ReporteActivoPreventivoCorrectivo reporte;

  ConsumiblesRefaccionesDelegate({required this.reporte});

  @override
  String? get searchFieldLabel => 'Buscar consumibles';


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: ( )=> query = '', icon: const FaIcon(FontAwesomeIcons.xmark,size: 20,color:  Color(0xff002E53),))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null); 
      Provider.of<ConsumiblesRefaccionesProvider>(context,listen: false).consumiblesAgregados(idReporte: int.parse( reporte.reporte ), tipo: reporte.tipo );
      },
    icon: const FaIcon(FontAwesomeIcons.angleLeft,size: 20,color:  Color(0xff002E53)));
  }

  @override
  Widget buildResults(BuildContext context) {
     return Text("buildResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {

      if( query.isEmpty ){
        return  const SizedBox(
          child: Center(
            child: FaIcon(FontAwesomeIcons.list,color: Colors.black38,size: 100),
          ),
        );
      }

     final consumibleProvider = Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false); 

     return FutureBuilder(
      future: consumibleProvider.searchConsumiblesConFiltro(descripcion: query,codigo: query),
      // future: consumibleProvider.searchConsumibles(),
      builder: (BuildContext context, AsyncSnapshot<List<SearchConsumiblesResponse>> snapshot) { 
           
            if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras el Future está en progreso
                return const SizedBox(child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                // Maneja cualquier error que ocurra durante la carga del Future
                return Text('Error: ${snapshot.error}');
              } else {
                // Muestra los datos cargados una vez que el Future se completa
               if (snapshot.data!.isNotEmpty) {
                    final consumibles = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: consumibles?.length,
                      itemBuilder: (BuildContext context, int index) { 
                        final consumible = consumibles![index];
                         return Consumible( consumible: consumible, reporte : reporte,);
                       });
                } else {
                  return const SizedBox(
                    child: Center(
                      child: FaIcon(FontAwesomeIcons.list,color: Colors.black38,size: 100),
                    ),
                  );
                }
              }

       });
  }
  
  
}

