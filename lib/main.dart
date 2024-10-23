import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

void main() {
  runApp(FoodSwipeApp());
}

class FoodSwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Swipe',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FoodSwipeHomePage(),
    );
  }
}

class FoodSwipeHomePage extends StatefulWidget {
  @override
  _FoodSwipeHomePageState createState() => _FoodSwipeHomePageState();
}

class _FoodSwipeHomePageState extends State<FoodSwipeHomePage> {
  List<String> foodItems = [
    'Pizza',
    'Sushi',
    'Burger',
    'Pasta',
    'Salad',
    'Tacos',
  ];

  List<String> cart = [];

  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Swipe'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: TinderSwapCard(
            orientation: AmassOrientation.BOTTOM,
            totalNum: foodItems.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.width * 0.9,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 0.8,
            cardBuilder: (context, index) => Card(
              child: Center(
                child: Text(
                  foodItems[index],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback:
                (DragUpdateDetails details, Alignment align) {
              // Detect swipe direction
              if (align.x < 0) {
                print("Disliked ${foodItems[controller.index]}");
              } else if (align.x > 0) {
                print("Liked ${foodItems[controller.index]}");
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (orientation == CardSwipeOrientation.UP) {
                setState(() {
                  cart.add(foodItems[index]);
                  print("Added ${foodItems[index]} to cart");
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
