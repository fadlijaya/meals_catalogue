import 'package:flutter/material.dart';
import 'package:mealscatalogue/constant.dart';
import 'package:mealscatalogue/view/food_detail_page.dart';

class FoodSearch extends SearchDelegate{
  final String foodCategory;
  final List foodList;

  FoodSearch({@required this.foodCategory, @required this.foodList});

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
        IconButton(
            tooltip: 'Clear',
            icon: Icon(Icons.clear),
            onPressed: (){
              query = '';
              showSuggestions(context);
              },
            )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        tooltip: 'Back',
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(query.length < 3){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters."
            ),
          )
        ],
      );
    }

    final results = foodList
      .where(
        (food) => food.foodName.toLowerCase().contains(query.toLowerCase())
    ).toList();

    if(results.length == 0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text("No Results Found"),
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: results.length,
        itemBuilder: (context, index){
          return ListTile(
            contentPadding: EdgeInsets.all(defaultPadding),
            title: Text(results[index].foodName),
            onTap: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailPage(
                      foodId: results[index].foodId,
                      foodName: results[index].foodName,
                      foodPicture: results[index].foodPicture,
                    )
                  )
              );
            },
          );
        }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
      ? foodList
        : foodList
          .where((food) =>
          food.foodName.toLowerCase().contains(query.toLowerCase())
    ).toList();
    // TODO: implement buildSuggestions
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index){
          return ListTile(
            contentPadding: EdgeInsets.only(left: defaultPadding,),
            title: Text(suggestions[index].foodName),
            onTap: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodDetailPage(
                        foodId: suggestions[index].foodId,
                        foodName: suggestions[index].foodName,
                        foodPicture: suggestions[index].foodPicture,
                      )
                  )
              );
            },
          );
        }
    );
  }

}