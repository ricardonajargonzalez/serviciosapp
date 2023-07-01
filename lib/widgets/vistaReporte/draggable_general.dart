import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/helpers/utils.dart';
import 'package:animate_do/animate_do.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:serviciosapp/widgets/vistaReporte/info_correctivo.dart';
import 'package:serviciosapp/widgets/vistaReporte/info_preventivo.dart';

class DraggagleGeneral extends StatefulWidget {
  final double maxChildSize;
  final double initialChildSize;
  final double minChildSize;
  
  const DraggagleGeneral({
    super.key,
    required this.maxChildSize, required this.initialChildSize, required this.minChildSize
  });

  @override
  State<DraggagleGeneral> createState() => _DraggagleGeneralState();
}

class _DraggagleGeneralState extends State<DraggagleGeneral> {
  @override
  Widget build(BuildContext context) {
    final reporteActivo = Provider.of<ReporteActivoProvider>(context);

    return DraggableScrollableSheet(
      maxChildSize: widget.maxChildSize,
      initialChildSize: widget.initialChildSize,
      minChildSize: widget.minChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return FadeInUp(
          from: 500,
          child: Container(
            decoration: boxShadowGeneral,
            child: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  
                    child: reporteActivo.tipoReporte == 'preventivo'
                        ? 
                        //WIDGET PARA REPORTE PREVENTIVO
                        const InfoPreventivo(
                            estiloTextboldWhite: estiloTextboldWhite,
                            estiloTextWhite: estiloTextWhite)
                        :

                        //WIDGET PARA REPORTE CORRECTIVO
                        const InfoCorrectivo(
                            estiloTextboldWhite: estiloTextboldWhite,
                            estiloTextWhite: estiloTextWhite)
                       
                        
                    )
                  ),
          ),
        );
      },
    );
  }
}


/*
class InfoGeneral extends StatefulWidget {
  const InfoGeneral({
    super.key,
  });

  @override
  State<InfoGeneral> createState() => _InfoGeneralState();
}

class _InfoGeneralState extends State<InfoGeneral> {
  @override
  Widget build(BuildContext context) {
    final reporteActivo = Provider.of<ReporteActivoProvider>(context);

    return Container(
        // color: Colors.amber,
        // height: height,
        child: reporteActivo.tipoReporte == 'correctivo'
            ? //WIDGET PARA REPORTE CORRECTIVO
            InfoCorrectivo(
                estiloTextboldWhite: estiloTextboldWhite,
                estiloTextWhite: estiloTextWhite)
            : //WIDGET PARA REPORTE PREVENTIVO
            InfoPreventivo(
                estiloTextboldWhite: estiloTextboldWhite,
                estiloTextWhite: estiloTextWhite));
  }
}
*/