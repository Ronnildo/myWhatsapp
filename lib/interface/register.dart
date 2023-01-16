import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/model/user_model.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Controladores
  final TextEditingController _nameController =
      TextEditingController(text: "Ravi");
  final TextEditingController _emailController =
      TextEditingController(text: "ravi@gmail.com");
  final TextEditingController _passController =
      TextEditingController(text: "ravi2022");
  String _msgError = "";

  validate() {
    String name = _nameController.text;
    String email = _emailController.text;
    String pass = _passController.text;

    if (name.isNotEmpty) {
      if (email.isNotEmpty && email.contains("@")) {
        if (pass.isNotEmpty && pass.length >= 8) {
          UserModel user = UserModel(name, email, pass);
          register(user);
        } else {
          setState(() {
            _msgError = "Preencha o campo password. min 8.";
          });
        }
      } else {
        setState(() {
          _msgError = "Campo vazio ou E-mail inválido.";
        });
      }
    } else {
      setState(() {
        _msgError = "Campo vazio, preencha o nome.";
      });
    }
  }

  limparCampos() {
    setState(() {
      _nameController.text = "";
      _emailController.text = "";
      _passController.text = "";
    });
  }

  register(UserModel user) {
    print("${user.name}, ${user.email}, ${user.password}");
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    )
        .then((autentic) {
      auth.currentUser!.updateDisplayName(user.name);
      setState(
        () {
          _msgError = "Usuário Cadastrado!";
        },
      );
      CollectionReference ref = FirebaseFirestore.instance.collection("users")
        ..doc(autentic.user!.uid.toString());

      ref.add(user.toJson()).then((cad) {
        print("Dados cadastrados!");
        limparCampos();
      }).catchError(
        (onError) {
          setState(() {
            _msgError = "Erro ao cadastrar usuário! Tente novamente.";
          });
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }).catchError((onError) {
      List erro = onError.toString().split("]");
      print(erro);
      setState(() {
        _msgError = erro[1].toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // const Color(0XFF075E54) const Color(0xFF25D366)
    return Scaffold(
      backgroundColor: const Color(0XFF075E54),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cadastro",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF075E54),
        leading: const Icon(
          Icons.chevron_left_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
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
                    "assets/images/usuario.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _nameController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
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
                    color: Colors.grey,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Senha",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(_msgError),
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
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
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
