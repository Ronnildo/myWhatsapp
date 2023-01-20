import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? _idUsuario;
  bool? _subindoImagem = false;
  String? _downloadUrl;

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
      if (_imagem != null) {
        _subindoImagem = true;
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    final storage = FirebaseStorage.instance;
    final pastaRaiz = storage.ref();
    final arquivo = pastaRaiz.child("perfil").child("$_idUsuario.jpg");
    final image = arquivo.getDownloadURL();
    final task = arquivo.putFile(_imagem!).snapshotEvents.listen((event) {
      switch (event.state) {
        case TaskState.running:
          setState(() {
            _subindoImagem = true;
          });
          break;
        case TaskState.paused:
          setState(() {
            _subindoImagem = false;
          });
          break;
        case TaskState.success:
          setState(() {
            _subindoImagem = false;
          });
          download();
          break;
        case TaskState.canceled:
          setState(() {
            _subindoImagem = false;
          });
          break;
        case TaskState.error:
          setState(() {
            _subindoImagem = false;
            _downloadUrl =
                "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/flutter.png?alt=media&token=1f959f01-fc95-47d4-a21d-a417af96fa2f";
          });
          break;
      }
    });
  }

  Future download() async {
    final storage = FirebaseStorage.instance;
    final pastaRaiz = storage.ref();
    final arquivo = pastaRaiz.child("perfil/$_idUsuario.jpg");
    String download = await arquivo.getDownloadURL();
    setState(() {
      _downloadUrl = download;
    });
  }

  _recuperarDados() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuarioLogado = auth.currentUser;
    // print(usuarioLogado);
    _idUsuario = usuarioLogado!.uid;
    print(_idUsuario);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDados();
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
                _subindoImagem!
                    ? const CircularProgressIndicator()
                    : Container(),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      _downloadUrl != null ? NetworkImage(_downloadUrl!) : null,
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
                    onPressed: uploadImage,
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
