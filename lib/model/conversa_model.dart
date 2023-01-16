class ConversaModel {
  String? _nome;
  String? _mensagem;
  String? _urlImage;

  ConversaModel(this._nome, this._mensagem, this._urlImage);

  String get nome => _nome!;
  set nome(String value) {
    _nome = value;
  }

  String get mensagem => _mensagem!;
  set mensagem(String value) {
    _mensagem = value;
  }

  String get urlImage => _urlImage!;
  set urlImage(String value) {
    _urlImage = urlImage;
  }
}
