import 'package:mealscatalogue/model/food_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodService {
    String baseApiUrl =
        "https://www.themealdb.com/api/json/v1/1/";

    getFoodByCategory(String foodCategory) async {
      String url = "$baseApiUrl/filter.php?c=$foodCategory";
      http.Response response = await http.get(url);
      var responseJson = json.decode(response.body);

      if(response.statusCode == 200){
        if(response.body == '{"meals":null}'){
          return throw Exception ('No Results');
        } else {
          return (responseJson['meals'] as List)
              .map((p) => Food.fromJson(p))
              .toList();
        }
    } else {
        throw Exception('Failed to load food');
      }
}

  getFoodById(String foodId) async {
    String url = "$baseApiUrl/lookup.php?i=$foodId";
    http.Response response = await http.get(url);
    var responseJson = json.decode(response.body);

    if(response.statusCode == 200){
      if(response.body == '{"meals":null}'){
        return throw Exception ('No Results');
      } else {
        return (responseJson['meals'] as List)
            .map((p) => FoodDetail.fromJson(p))
            .toList();
      }
    } else {
      throw Exception('Failed to load food');
    }
  }
}