import 'dart:async';
import 'dart:io' as io;
import 'package:mealscatalogue/model/favorite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();

  DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "FavoriteDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  Future<FutureOr<void>> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE favorite(id INTEGER PRIMARY KEY, foodId TEXT, foodName TEXT, foodPicture TEXT, foodCategory TEXT)");
    print("DB Created");
  }

  Future<bool> isFavorite(String foodId) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery("SELECT * FROM favorite WHERE foodId = '$foodId'");
    return res.isNotEmpty ? true : false;
  }

  Future<int> saveFavorite(Favorite favorite) async {
    var dbClient = await db;
    int res = await dbClient.insert("favorite", favorite.toMap());
    print("Data Inserted");
    return res;
  }

  Future<List<Favorite>> getFavorite(String foodCategory) async {
    var dbClient = await db;

    List<Map> list = await dbClient.rawQuery(
        "SELECT * FROM favorite WHERE foodCategory = '$foodCategory' ORDER BY foodName ASC");

    List<Favorite> favoriteData = new List();

    for (int i = 0; i < list.length; i++) {
      var favorite = Favorite(
        list[i]["foodId"],
        list[i]["foodName"],
        list[i]["foodPicture"],
        list[i]["foodCategory"],
      );

      favorite.setFavoriteId(list[i]['id']);
      favoriteData.add(favorite);
    }
    return favoriteData;
  }

  Future<int> deleteFavorite(String foodId) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete("DELETE FROM favorite WHERE foodId = ?", [foodId]);
    return res;
  }
}
