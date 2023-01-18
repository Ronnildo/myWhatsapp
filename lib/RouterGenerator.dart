import 'package:flutter/material.dart';
import 'package:whatsapp/interface/configuracoes.dart';
import 'package:whatsapp/interface/home.dart';
import 'package:whatsapp/interface/login.dart';
import 'package:whatsapp/interface/register.dart';

class RouterGererator {
  static Route<dynamic>? genareteRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => const Login(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (_) => const Login(),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (_) => const Register(),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
      case "/config":
        return MaterialPageRoute(
          builder: (_) => const Configuracoes(),
        );
      default:
        _erroRota();
    }
  }

  static Route<dynamic>? _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tela não encontrada"),
        ),
        body: const Center(
          child: Text("Tela não encontrada"),
        ),
      );
    });
  }
}
