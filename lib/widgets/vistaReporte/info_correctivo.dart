

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/reporte_activo_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoCorrectivo extends StatefulWidget {
  const InfoCorrectivo({
    super.key,
    required this.estiloTextboldWhite,
    required this.estiloTextWhite,
  });

  final TextStyle estiloTextboldWhite;
  final TextStyle estiloTextWhite;

  @override
  State<InfoCorrectivo> createState() => _InfoCorrectivoState();
}



class _InfoCorrectivoState extends State<InfoCorrectivo> {

  
  


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
                          Text("Cliente: ", style: widget.estiloTextboldWhite),
                          Expanded(
                              child: Text(
                                  '${reporteActivo.correctivoActivo.cliente}',
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
                                  '${reporteActivo.correctivoActivo.sucursal}',
                                  style: widget.estiloTextWhite,
                                  overflow: TextOverflow.ellipsis))
                        ],
                      ),

                      //Fecha Inicio
                      Row(
                        children: [
                          Text("Fecha inicio: ", style: widget.estiloTextboldWhite),
                          Expanded(
                              child: Text(
                            '${reporteActivo.correctivoActivo.fechaInicio}',
                            style: widget.estiloTextWhite,
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
                        Text("Folio: ", style: widget.estiloTextboldWhite),
                        Text(
                          reporteActivo.correctivoActivo.idreporte,
                          style: widget.estiloTextWhite,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    //Fecha compromiso
                    Row(
                      children: [
                        Text("Fecha compromiso: ", style: widget.estiloTextboldWhite),
                        Expanded(
                            child: Text(
                          '${reporteActivo.correctivoActivo.fechaCompromiso != null ? reporteActivo.correctivoActivo.fechaCompromiso : ''}',
                          style: widget.estiloTextWhite,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    ),
                    //Hora compromiso
                    Row(
                      children: [
                        Text("Hora compromiso: ", style: widget.estiloTextboldWhite),
                        Expanded(
                            child: Text(
                          '${reporteActivo.correctivoActivo.horaCompromiso != null ? reporteActivo.correctivoActivo.horaCompromiso : ''}',
                          style: widget.estiloTextWhite,
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
                style: widget.estiloTextboldWhite,
              ),
              Expanded(
                  child: Text(reporteActivo.correctivoActivo.motivo,
                      style: widget.estiloTextWhite, overflow: TextOverflow.ellipsis))
            ],
          ),
        )   
        ],
      ),
    );
  }
}

