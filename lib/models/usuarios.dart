class Usuarios {
  String uid;
  String _nome;
  String _dataNas;
  String _email;
  String _numero;
  int _status;
  String _localizacao;
  String _atuacao;
  String _foto;

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get dataNas => this._dataNas;

  set dataNas(value) => this._dataNas = value;

  get email => this._email;

  set email(value) => this._email = value;

  get numero => this._numero;

  set numero(value) => this._numero = value;

  get status => this._status;

  set status(value) => this._status = value;

  get localizacao => this._localizacao;

  set localizacao(value) => this._localizacao = value;

  get atuacao => this._atuacao;

  set atuacao(value) => this._atuacao = value;

  get foto => this._foto;

  set foto(value) => this._foto = value;

  Usuarios.fromDocumentSnapshot(dynamic documentSnapshot) {
    this.uid = documentSnapshot.data()['uid'];
    this.nome = documentSnapshot.data()['nome'];
    this.dataNas = documentSnapshot.data()['nascimento'];
    this.email = documentSnapshot.data()['email'];
    this.numero = documentSnapshot.data()['numero'];
    this.localizacao = documentSnapshot.data()['localiza'];
    this.foto = documentSnapshot.data()['foto'];
    this.atuacao = documentSnapshot.data()["atuacao"];
    this.status = documentSnapshot.data()["status"];
  }

  Usuarios({
    this.uid,
  });

//
  Usuarios.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.nome = mapData['nome'];
    this.email = mapData['email'];
    this.dataNas = mapData['nascimento'];
    this.localizacao = mapData['localiza'];
    this.status = mapData['status'];
    this.foto = mapData['foto'];
  }
  //
  Map<String, dynamic> toMap() {
    Map<String, dynamic> mapa = {
      "uid": this.uid,
      "nome": this.nome,
      "nascimento": this.dataNas,
      "email": this.email,
      "numero": this.numero,
      "localiza": this.localizacao,
      "atuacao": this.atuacao,
      "status": this.status,
      "foto": this.foto,
    };
    return mapa;
  }
}
