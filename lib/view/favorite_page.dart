import 'package:flutter/material.dart';
import 'package:mealscatalogue/constant.dart';
import 'package:mealscatalogue/helpers/db_helper.dart';
import 'package:mealscatalogue/model/favorite_model.dart';
import 'food_detail_page.dart';

class FavoritePage extends StatefulWidget{
  FavoritePage({Key key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kWhite,
            bottom: PreferredSize(
              preferredSize: Size(0, 0),
              child: Container(
                child: TabBar(
                  indicatorColor: kBlack,
                    tabs: [
                      Container(
                        height: 48,
                        child: Tab(
                          text: kSeafood,
                        ),
                      ),
                      Container(
                        height: 48,
                        child: Tab(
                          text: kDessert,
                        ),
                      )
                    ]
                ),
              ),
            ),
          ),
          body: TabBarView(
              children: <Widget>[
                FavoriteView(foodCategory: kSeafood),
                FavoriteView(foodCategory: kDessert)
              ]
          ),
        )
    );
  }

}

class FavoriteView extends StatefulWidget {
  final String foodCategory;

  const FavoriteView({Key key, this.foodCategory}) : super(key: key);
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        future: db.getFavorite(widget.foodCategory),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);
            var data = snapshot.data;
            return snapshot.hasData
                ? FavoriteGridView(data)
                : Center(
                child: Text('No Data'),
            );
          }
      ),
    );
  }
}

class FavoriteGridView extends StatefulWidget {
  final List<Favorite> favoriteData;

  FavoriteGridView(this.favoriteData);
  @override
  _FavoriteGridViewState createState() => _FavoriteGridViewState();
}

class _FavoriteGridViewState extends State<FavoriteGridView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.builder(
      itemCount: widget.favoriteData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: defaultPadding / 4,
          crossAxisSpacing: defaultPadding /4,
          childAspectRatio: 0.75
        ),
        itemBuilder: (context, index){
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: widget.favoriteData[index].foodId,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          widget.favoriteData[index].foodPicture,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
                    child: Text(
                      widget.favoriteData[index].foodName,
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
                        foodId: widget.favoriteData[index].foodId,
                        foodName: widget.favoriteData[index].foodName,
                        foodPicture: widget.favoriteData[index].foodPicture,
                      )
                  )
              );
            },
          );
        }
    );
  }
}