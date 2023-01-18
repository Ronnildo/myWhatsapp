import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/interface/home.dart';
import 'package:whatsapp/interface/register.dart';

import '../model/user_model.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  String _msgError = "";

  _limparCamapos() {
    _emailController.text = "";
    _passController.text = "";
  }

  validate() {
    String email = _emailController.text;
    String password = _passController.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (password.isNotEmpty) {
        UserModel userModel = UserModel("", email, password);
        login(userModel);
      } else {
        setState(() {
          _msgError = "Preencha o campo senha.";
        });
      }
    } else {
      setState(() {
        _msgError = "Preencha o campo email ou coloque um e-mail válido.";
      });
    }
  }

  login(UserModel userModel) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: userModel.email!, password: userModel.password!)
        .then(
      (log) {
        _limparCamapos();
        Navigator.pushReplacementNamed(context, "/home");
      },
    ).catchError(
      (onError) {
        setState(() {
          _msgError = onError;
        });
      },
    );
  }

  Future _verificarUsuarioLogado() async {
    User? user = await FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  void initState() {
    super.initState();
    _verificarUsuarioLogado();
    _limparCamapos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF075E54),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF075E54),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32,
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _emailController,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 10,
                  ),
                  child: ElevatedButton(
                    onPressed: validate,
                    autofocus: true,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Não tem conta? Cadastre-se!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  _msgError,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
