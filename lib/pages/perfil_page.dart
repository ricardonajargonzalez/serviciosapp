

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:serviciosapp/models/user.dart';
import 'package:serviciosapp/helpers/utils.dart';




class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {

   final controllerText = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Usuario usuario = ModalRoute.of(context)?.settings.arguments as Usuario;

    

    return  SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
                _AppBarPerfil(usuario: usuario),
                 SliverList(
                delegate: SliverChildListDelegate(
                  
                  [
                   Container(
                    width: double.infinity,
                    height: 800,
                    child: Column(
                      children: [
                        Container(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      width: double.infinity,
                     // color: Colors.amber,
                      child:  Row(
                        children: [
                          const Text("Usuario: ", style: estilotitulo),
                          Text('${usuario.nombre} ${usuario.apellido}')
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      width: double.infinity,
                     // color: Colors.amber,
                      child:  Row(
                        children: [
                          Text('${usuario.email} ')
                        ],
                      ),
                    ),
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      width: double.infinity,
                     // color: Colors.amber,
                      child:  Row(
                        children: [
                          const Text("Token activo: ", style: estilotitulo),
                          Text('Si')
                        ],
                      ),
                    )
                      ],
                    ),
                   )
                  
                ])
                )
            ],
          ),
        )
      ),
    );
  }
}

class _AppBarPerfil extends StatelessWidget {
 final Usuario usuario;

  const _AppBarPerfil({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return   SliverAppBar(
      pinned: true,
      floating: true,
      excludeHeaderSemantics: true,
      expandedHeight: 300,
     // toolbarHeight: 100,
         backgroundColor: const Color(0xff002E53),
         flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: 'usuario${usuario.idusuario}',
            child: Stack(
              children: [
                Align(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipOval(
                      child: FadeInImage(
                        placeholder: AssetImage('assets/no-image.png'), image: NetworkImage(usuario.foto),
                        fit: BoxFit.cover,
                        ),
                    ),
                  ),
                ),
                 Positioned(
                  bottom: 50,
                  left: MediaQuery.of(context).size.width * 0.60,
                  child: IconButton(
                    color: Colors.black,
                    onPressed: (){},
                    icon: FaIcon(FontAwesomeIcons.camera, color: Colors.white, size: 14,)
                  ),
                )
              ],
            ),
          ),
         ),
    );
  }
}

