import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviciosapp/services/preventivos_provider.dart';
import 'package:serviciosapp/widgets/app_bar_custom.dart';
import 'package:serviciosapp/widgets/bandejaEntrada/listado_preventivo.dart';
import 'package:serviciosapp/widgets/bandejaEntrada/listado_correctivo.dart';
import 'package:serviciosapp/widgets/menu.dart';


class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final PreferredSizeWidget tab = const TabBar(

          labelColor: Colors.white,
      indicatorColor: Colors.grey,
      tabs: [
        Tab(
            icon: Icon(Icons.perm_contact_cal, color: Colors.white),
            text: 'Preventivos'),
        Tab(
            icon: Icon(Icons.engineering, color: Colors.white),
            text: 'Correctivos')
      ]
/*
      labelColor: Color(0xff002E53),
      indicatorColor: Color(0xff002E53),
      tabs: [
        Tab(
            icon: Icon(Icons.perm_contact_cal, color: Color(0xff002E53)),
            text: 'Preventivos'),
        Tab(
            icon: Icon(Icons.engineering, color: Color(0xff002E53)),
            text: 'Correctivos')
      ]
      */
      );

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final listPreventivos = Provider.of<PreventivosProvider>(context);
    TextStyle estiloTextbold = TextStyle(fontWeight: FontWeight.bold);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Menu(),
        appBar: AppBarCustom(
            appBar: AppBar(
              bottom: tab,
            ),
            bottom: tab),
        body: const TabBarView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [ListaPreventivos(), ListaCorrectivos()],
        ),
      ),
    );
  }
}






