import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Configuracoes extends StatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final TextEditingController _nameController = TextEditingController();
  late File? _imagem;

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagem = File(image.path);
    }
  }

  _recuperarImagem(String origemImage) async {
    final ImagePicker _picker = ImagePicker();
    File? imageSelecionada;
    switch (origemImage) {
      case "camera":
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          imageSelecionada = File(image.path);
        }
        break;
      case "galeria":
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          imageSelecionada = File(image.path);
        }
        break;
      default:
    }
    setState(() {
      _imagem = imageSelecionada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF075E54),
        title: const Text("Configurações"),
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/flutter.png?alt=media&token=1f959f01-fc95-47d4-a21d-a417af96fa2f",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            _imagem = File(image.path);
                          }
                        },
                        child: const Text("Camera"),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            _imagem = File(image.path);
                          }
                        },
                        child: const Text("Galeria"),
                      )
                    ],
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 10,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    autofocus: true,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text(
                      "Salvar",
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
