


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/helpers/utils.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';
import 'package:serviciosapp/models/search_consumibles_response.dart';
import 'package:serviciosapp/services/consumibles_refacciones_provider.dart';

class Consumible extends StatelessWidget {
  final ReporteActivoPreventivoCorrectivo reporte;
  
  const Consumible({
    super.key,
    required this.consumible, required this.reporte
  });

  final SearchConsumiblesResponse consumible;

  @override
  Widget build(BuildContext context) {
     
   

    return GestureDetector(
      onTap: ()async{
       final isOk = await Provider.of<ConsumiblesRefaccionesProvider>(context, listen: false).agregarconsumible(idReporte: int.parse( reporte.reporte ), idConsumible: int.parse(consumible.id), tipo: reporte.tipo );
       if(!isOk){
                final SnackBar snackBar = warningMensaje('Ocurrio un error al guardar el consumible');
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showSnackBar(context,snackBar);
               
       }else{
               final SnackBar snackBar = successMensaje('El consumible "${consumible.descripcion}" se agrego exitosamente!');
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                showSnackBar(context,snackBar);
       }
        FocusScope.of(context).unfocus();// quitar el teclado habilitado
      },
      child: Card(
           child: Container(
             padding: const EdgeInsets.all(8),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('ID: ${consumible.id}'),
                 Text('Codigo: ${consumible.codigo}'),
                 Text(consumible.descripcion),
               ],
             ),
           ),
      ),
    );
  }
}



