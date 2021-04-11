import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubmitWidgetState();
}

class TrashType {
  final String assetUri;
  final String title;
  final String description;
  int count = 0;

  TrashType({
    this.assetUri,
    this.title,
    this.description,
  });

  void inc() => count++;

  void dec() => count--;
}

class _SubmitWidgetState extends State<SubmitWidget> {
  Map<String, List<TrashType>> data = {
    'Plastic': List.generate(
      5,
      (index) => TrashType(
          assetUri: 'assets/images/${index + 1}.png',
          description: 'description $index',
          title: 'Title $index'),
    ),
    'Metal': List.generate(
      5,
      (index) => TrashType(
          assetUri: 'assets/images/${index + 1}.png',
          description: 'description $index',
          title: 'Title $index'),
    ),
    'Pidor': List.generate(
      5,
      (index) => TrashType(
          assetUri: 'assets/images/${index + 1}.png',
          description: 'description $index',
          title: 'Title $index'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    data.keys.forEach((title) {
      widgets.add(ListTile(title: Text(title)));
      data[title].forEach((trash) {
        widgets.add(ListTile(
          leading: Image.asset(trash.assetUri),
          title: Text(trash.title),
          subtitle: Text(trash.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(CupertinoIcons.minus),
                  onPressed: () {
                    setState(() {
                      trash.dec();
                    });
                  }),
              Text("${trash.count}"),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      trash.inc();
                    });
                  }),
            ],
          ),
        ));
      });
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: ListView(
        children: widgets,
      ),
    );
  }
}
