import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class RatingList extends StatelessWidget {
  final itemsCount = 15;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Color iconColor;
        switch (index) {
          case 0:
            iconColor = Color.fromRGBO(0xff, 0xd7, 0x00, 1);
            break;
          case 1:
            iconColor = Color.fromRGBO(0xc0, 0xc0, 0xc0, 1);
            break;
          case 2:
            iconColor = Color.fromRGBO(0xcd, 0x7f, 0x32, 1);
            break;
        }
        return ListTile(
          leading: Text("${index + 1}"),
          title: Text(Faker().person.name()),
          subtitle: Text("${(itemsCount - index) * 100} единиц мусора"),
          trailing: index < 3
              ? Icon(
                  RpgAwesome.queen_crown,
                  color: iconColor,
                )
              : null,
        );
      },
      itemCount: itemsCount,
    );
  }
}

class Rating extends StatelessWidget {
  // final Future<void> f =
  //     Future.delayed(Duration(seconds: 1)).then((value) => value);

  @override
  Widget build(BuildContext context) {
    Future f() async {
      return await Future.delayed(Duration(seconds: 1)).then((value) => 1);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Рейтинг"),
      ),
      body: FutureBuilder(
        future: f(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RatingList();
          } else {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      // FutureBuilder(
      //   // future: f,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return RatingList();
      //   } else if (snapshot.hasError) {
      //     return Center(
      //       child: Text("ERROR ${snapshot.error}"),
      //     );
      //   } else {
      //     return Center(
      //       child: SizedBox(
      //         width: 50,
      //         height: 50,
      //         child: CircularProgressIndicator(),
      //       ),
      //     );
      //   }
      // },
      // ),
    );
  }
}
