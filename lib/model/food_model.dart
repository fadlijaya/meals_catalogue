class Food {
  final String foodId;
  final String foodName;
  final String foodPicture;

  Food({this.foodId, this.foodName, this.foodPicture});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        foodId: json['idMeal'],
        foodName: json['strMeal'],
        foodPicture: json['strMealThumb']);
  }
}

class FoodDetail {
  final String foodId;
  final String foodName;
  final String foodCategory;
  final String foodArea;
  final String foodDetail;
  final String foodPicture;
  final String foodIngredients;

  FoodDetail(
      {this.foodId,
      this.foodName,
      this.foodCategory,
      this.foodArea,
      this.foodDetail,
      this.foodPicture,
      this.foodIngredients});

  factory FoodDetail.fromJson(Map<String, dynamic> json) {
    String _strIngredient = json['strIngredient1'] +
        ", " +
        json['strIngredient2'] +
        ", " +
        json['strIngredient3'] +
        ", " +
        json['strIngredient4'] +
        ", " +
        json['strIngredient5'] +
        ", " +
        json['strIngredient6'] +
        ", " +
        json['strIngredient7'] +
        ", " +
        json['strIngredient8'] +
        ", " +
        json['strIngredient9'] +
        ", " +
        json['strIngredient10'];
    return FoodDetail(
        foodId: json['idMeal'],
        foodName: json['strMeal'],
        foodCategory: json['strCategory'],
        foodArea: json['strArea'],
        foodDetail: json['strInstructions'],
        foodPicture: json['strMealThumb'],
        foodIngredients: _strIngredient);
  }
}
