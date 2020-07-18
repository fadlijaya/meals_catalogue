import 'package:flutter/material.dart';
import 'package:mealscatalogue/constant.dart';
import 'package:mealscatalogue/helpers/db_helper.dart';
import 'package:mealscatalogue/model/favorite_model.dart';
import 'package:mealscatalogue/model/food_model.dart';
import 'package:mealscatalogue/service/food_service.dart';

class FoodDetailPage extends StatefulWidget {
  final String foodId;
  final String foodName;
  final String foodPicture;

  const FoodDetailPage({Key key, this.foodId, this.foodName, this.foodPicture})
      : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  List<FoodDetail> foodDetail;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _getFoodById();
    _isFavorite();
  }

  Future _getFoodById() async {
    var foodService = FoodService();
    var response = await foodService.getFoodById(widget.foodId);
    if (!mounted) return;
    setState(() {
      foodDetail = response;
    });
  }

  _isFavorite() async {
    var db = DBHelper();
    var res = await db.isFavorite(widget.foodId);
    setState(() {
      isFavorite = res ? true : false;
    });
  }

  Future saveFavorite() async {
    var db = DBHelper();
    var favorite = Favorite(widget.foodId, widget.foodName, widget.foodPicture,
        foodDetail[0].foodCategory);
    await db.saveFavorite(favorite);
    print("saved");
  }

  deleteFavorite(foodId) {
    var db = DBHelper();
    db.deleteFavorite(foodId);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: widget.foodId,
                      child: Material(
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30)),
                              child: Image.network(
                                widget.foodPicture,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                top: 9,
                                left: 9,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black.withOpacity(0.3)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                  ),
                                )),
                            Positioned(
                                top: 9,
                                right: 9,
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kWhite,
                                    ),
                                    child: IconButton(
                                        tooltip: 'Favorite',
                                        icon: Icon(isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                        onPressed: () {
                                          setState(() {
                                            if (isFavorite) {
                                              deleteFavorite(widget.foodId);
                                              isFavorite = false;
                                            } else {
                                              saveFavorite();
                                              isFavorite = true;
                                            }
                                          });
                                        }))),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        widget.foodName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              buildFoodDetail()
            ],
          ),
        ),
      ),
    );
  }

  Container buildFoodDetail() {
    if (foodDetail == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        child: Padding(
          padding: EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
              bottom: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Category",
                style: TextStyle(
                    color: kBlack, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding / 8, bottom: defaultPadding / 2),
                child: Text(
                  foodDetail[0].foodCategory,
                  style: TextStyle(color: kBlack),
                  textAlign: TextAlign.justify,
                ),
              ),
              Text(
                "Area",
                style: TextStyle(
                    color: kBlack, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding / 8, bottom: defaultPadding / 2),
                child: Text(
                  foodDetail[0].foodArea,
                  style: TextStyle(color: kBlack),
                  textAlign: TextAlign.justify,
                ),
              ),
              Text(
                "Ingredients",
                style: TextStyle(
                    color: kBlack, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding / 8, bottom: defaultPadding / 2),
                child: Text(
                  foodDetail[0].foodIngredients,
                  style: TextStyle(color: kBlack),
                  textAlign: TextAlign.justify,
                ),
              ),
              Text(
                "Instructions",
                style: TextStyle(
                    color: kBlack, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: defaultPadding / 8, bottom: defaultPadding / 2),
                child: Text(
                  foodDetail[0].foodDetail,
                  style: TextStyle(
                    color: kBlack,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
