import 'package:flutter/material.dart';
import 'package:mealscatalogue/constant.dart';
import 'package:mealscatalogue/model/food_model.dart';
import 'package:mealscatalogue/service/food_service.dart';
import 'package:mealscatalogue/view/food_detail_page.dart';
import 'package:mealscatalogue/view/food_search.dart';

class SeafoodPage extends StatefulWidget{
  final String foodCategory;

  SeafoodPage({Key key, this.foodCategory}) : super(key: key);
  @override
  _SeafoodPageState createState() => _SeafoodPageState();
}

class _SeafoodPageState extends State<SeafoodPage> {
  List<Food> foodList;

  @override
  void initState(){
    super.initState();
    _getFoodByCategory();
  }

  Future _getFoodByCategory() async {
    var foodService = FoodService();
    var response = await foodService.getFoodByCategory(widget.foodCategory);
    if(!mounted) return;
    setState(() {
      foodList = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildCard(context);
  }
   // ignore: missing_return
   SafeArea buildCard(BuildContext context) {
    if(foodList == null){
      return SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          )
      );
    } else {
      return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: FoodSearch(
                        foodCategory: widget.foodCategory,
                        foodList: foodList
                    )
                );
              },
              child: Icon(Icons.search),
              tooltip: 'Search',
              backgroundColor: kBlack,
            ),
            body: GridView.builder(
                itemCount: foodList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: defaultPadding / 4,
                    crossAxisSpacing: defaultPadding / 4,
                    childAspectRatio: 0.75
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(defaultPadding / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Hero(
                              tag: foodList[index].foodId,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  foodList[index].foodPicture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
                            child: Text(
                              foodList[index].foodName,
                              style: TextStyle(color: kBlack),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodDetailPage(
                                foodId: foodList[index].foodId,
                                foodName: foodList[index].foodName,
                                foodPicture: foodList[index].foodPicture,
                              )
                          )
                      );
                    },
                  );
                }
            ),
          ),
      );
    }
  }

}