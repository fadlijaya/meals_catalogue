class Favorite {
  int id;
  String _foodId, _foodName, _foodPicture, _foodCategory;

  Favorite(this._foodId, this._foodName, this._foodPicture, this._foodCategory);

  Favorite.map(dynamic obj) {
    this._foodId = obj["foodId"];
    this._foodName = obj["foodName"];
    this._foodPicture = obj["foodPicture"];
    this._foodCategory = obj["foodCategory"];
  }

  String get foodId => _foodId;

  String get foodName => _foodName;

  String get foodPicture => _foodPicture;

  String get foodCategory => _foodCategory;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["foodId"] = _foodId;
    map["foodName"] = _foodName;
    map["foodPicture"] = _foodPicture;
    map["foodCategory"] = _foodCategory;

    return map;
  }

  void setFavoriteId(int id) {
    this.id = id;
  }
}
