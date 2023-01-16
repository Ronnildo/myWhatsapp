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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
