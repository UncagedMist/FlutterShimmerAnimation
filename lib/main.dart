import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shimmer",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shimmer Animation"),
      ),
      body: Center(
        child: LoadingList(),
      ),
    );
  }
}

class LoadingList extends StatefulWidget {

LoadingList({Key key, this.title}) : super(key: key);

final String title;

  createState() => _LoadingListState ();
}

class _LoadingListState  extends State<LoadingList> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    Timer timer = Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });

    // return ShimmerAnimLoader();

    return isLoading ? ShimmerAnimLoader() : ItemList(timer);
  }
}

class ItemList extends StatelessWidget {
  Timer timer;

  ItemList(this.timer);

  final icons = [
    Icons.directions_bike, Icons.directions_boat,
    Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
    Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
    Icons.directions_walk
    ];

  final titles = ['bike', 'boat', 'bus', 'car',
      'railway', 'run', 'subway', 'transit', 'walk'];

  
  @override
  Widget build(BuildContext context) {
    timer.cancel();

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(
              icons[index],
              size: 40.0,
              color: Colors.blue),
            title: Text(titles[index]),
            subtitle: Text(titles[index]),
          ),
        );
      },
    );
  }
}

class ShimmerAnimLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: 1500),
              ),
            );
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 30;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 80,
            width: 100,
            color: Colors.grey,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              // Container(
              //   height: containerHeight,
              //   width: containerWidth * 0.75,
              //   color: Colors.grey,
              // ),
            ],
          )
        ],
      ),
    );
  }
}