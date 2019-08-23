class Post {
  //Atributos
  int _userId;
  int _id;
  String _title;
  String _body;

  //Contrutor
  Post(_userId, _id, _title, _body);

  //Getters and Setters
  int get userId => this._userId;

  set userId(int value) {
    this._userId = value;
  }

  int get id => this._id;

  set id(int value) {
    this._id = value;
  }

  String get title => _title;

  set title(String value) {
    this._title = value;
  }

  String get body => _body;

  set body(String value) {
    this._body = value;
  }
}
