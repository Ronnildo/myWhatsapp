import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/interface/abas/contatos.dart';
import 'package:whatsapp/interface/abas/conversas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> itensMenu = [
    "Configurações",
    "Deslogar",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  _escolhaItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configurações":
        Navigator.pushReplacementNamed(context, "/config");
        break;
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
    //print("Item Escolhido: $itemEscolhido");
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF075E54),
        title: const Text("WhatsApp"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: "Conversas",
            ),
            Tab(text: "Contatos"),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolhaItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          AbaConversas(),
          AbaContatos(),
        ],
      ),
    );
  }
}
