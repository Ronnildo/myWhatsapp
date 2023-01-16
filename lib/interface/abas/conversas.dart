import 'package:flutter/material.dart';
import 'package:whatsapp/model/conversa_model.dart';

class AbaConversas extends StatefulWidget {
  const AbaConversas({Key? key}) : super(key: key);

  @override
  State<AbaConversas> createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  List<ConversaModel> conversas = [
    ConversaModel(
      "Flutter",
      "Flutter The Best",
      "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/flutter.png?alt=media&token=1f959f01-fc95-47d4-a21d-a417af96fa2f",
    ),
    ConversaModel(
      "GitHub",
      "git pull",
      "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/github.jpeg?alt=media&token=32802882-15db-4ebf-a5b1-dc4866cb59e7",
    ),
    ConversaModel(
      "NodeJs",
      "port 7895",
      "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/nodejs.png?alt=media&token=74590299-fab1-45f9-a577-3ef4a9b8b241",
    ),
    ConversaModel(
      "Linkedin",
      "Alerta",
      "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/linkedin.png?alt=media&token=b821897d-60df-4f15-9d91-d26604eaba40",
    ),
    ConversaModel(
      "JavaScript",
      "Console.log()",
      "https://firebasestorage.googleapis.com/v0/b/myapp-289e9.appspot.com/o/js.png?alt=media&token=781818d9-a1dd-422a-9492-e1e796bff9e1",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversas.length,
      itemBuilder: (context, index) {
        ConversaModel conversa = conversas[index];
        return ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.urlImage),
          ),
          title: Text(
            conversa.nome,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            conversa.mensagem,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
