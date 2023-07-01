import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serviciosapp/models/reporte_activo_preventivo_correctivo.dart';



class BotonConsumiblesRefacciones extends StatelessWidget {
  final ReporteActivoPreventivoCorrectivo reporte;
  const BotonConsumiblesRefacciones({
    super.key, required this.reporte,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 180,
      right: 10,
      child: FloatingActionButton(
        heroTag: 'consumiblesRefacciones',
              onPressed: () {
                Navigator.pushNamed(context, 'consumibles-refacciones',arguments: reporte);
              },
              backgroundColor: const Color(0xff002E53),
              child: const FaIcon(  FontAwesomeIcons.list),
            ),
    );
  }
}