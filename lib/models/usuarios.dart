class Usuarios {
  String _uid;
  String _nome;
  String _dataNas;
  String _email;
  String _numero;
  String _localizacao;
  String _foto;
  String get uid => this._uid;

  set uid(String value) => this._uid = value;

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get dataNas => this._dataNas;

  set dataNas(value) => this._dataNas = value;

  get email => this._email;

  set email(value) => this._email = value;

  get numero => this._numero;

  set numero(value) => this._numero = value;

  get localizacao => this._localizacao;

  set localizacao(value) => this._localizacao = value;

  get foto => this._foto;

  set foto(value) => this._foto = value;

  Usuarios();
  Usuarios.fromDocumentSnapshot(dynamic documentSnapshot) {
    this.uid = documentSnapshot.id;
    this.nome = documentSnapshot.data()['nome'];
    this.dataNas = documentSnapshot.data()['foto'];
    this.email = documentSnapshot.data()['email'];
    this.numero = documentSnapshot.data()['numero'];
    this.localizacao = documentSnapshot.data()['localiza'];
    this.foto = documentSnapshot.data()['foto'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      "uid": this.uid,
      "nome": this.nome,
      "nascimento": this.dataNas,
      "email": this.email,
      "numero": this.numero,
      "localiza": this.localizacao,
      "foto": this.foto,
    };
    return mapa;
  }
}
