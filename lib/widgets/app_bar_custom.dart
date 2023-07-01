

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/all_notificaciones_provider.dart';



class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{

  final AppBar appBar;
  final PreferredSizeWidget? bottom;
  const AppBarCustom({
    super.key, required this.appBar, this.bottom,
  });

  @override
  Widget build(BuildContext context) {

    Provider.of<AllNotificacionesProvider>(context,listen: false).notificacionesRecientes(idUsuario: 180);

    return AppBar(
          elevation: 0,
          backgroundColor: Color(0xff002E53),
          foregroundColor: Colors.white,
          bottom: bottom,
          actions: [
               Stack(
          children: [
            IconButton(
                icon: const FaIcon(FontAwesomeIcons.solidBell),
                onPressed: () {
                   Navigator.of(context).pushNamed('notificaciones');
                }),
                 Positioned(
                  top: 8,
                  right:3,
                  child: GestureDetector(
                    onTap: () {
                       Navigator.of(context).pushNamed('notificaciones');
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.red.shade900,
                          borderRadius: BorderRadius.circular(50)),
                          child: const Center(child: Text('1')),
                    ),
                  ),
                  
                )
          ],
        )
          ],
        );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}