import 'package:animated_check/animated_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'trash_data.dart';

class SubmitWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubmitWidgetState();
}

class _SubmitWidgetState extends State<SubmitWidget>
    with SingleTickerProviderStateMixin {
  Map<String, List<TrashType>> data;

  void initData() {
    data = {
      'Пластик': List.from(trashData.sublist(0, 7)),
      'Остальные материалы': List.from(trashData.sublist(7)),
    };
  }

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));
    initData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> widgets = [];
    data.keys.forEach((title) {
      widgets.add(ListTile(title: Text(title)));
      data[title].forEach((trash) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Image.asset(
              trash.assetUri,
              width: size.width * 0.15,
            ),
            title: Text(trash.title),
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
          ),
        ));
      });
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Сдача мусора"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                final f =
                    Future.delayed(Duration(seconds: 1)).then((value) => value);
                await showDialog(
                  context: context,
                  builder: (context) {
                    _animationController.forward();
                    return AlertDialog(
                      title: Text(
                        "Поздравляем!",
                        textAlign: TextAlign.center,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: AnimatedCheck(
                              progress: _animation,
                              size: 200,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Вы сдали мусор и сделали шаг в более чистое и светлое будущее! Вы можете отслеживать ваш мусор во вкладке \"Трекинг\"",
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Закрыть"),
                        ),
                      ],
                    );
                    // return FutureBuilder(
                    //   future: f,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       _animationController.forward();
                    //       return AlertDialog(
                    //         title: Text("Поздравляем!"),
                    //         content: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Container(
                    //               child: AnimatedCheck(
                    //                 progress: _animation,
                    //                 size: 200,
                    //                 color: Colors.white,
                    //               ),
                    //               decoration: BoxDecoration(
                    //                 shape: BoxShape.circle,
                    //                 color: Colors.green,
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(top: 8.0),
                    //               child: Text(
                    //                   "Вы сдали мусор и сделали шаг в более чистое и светлое будущее! Вы можете отслеживать ваш мусор во вкладке \"Трекинг\""),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     } else {
                    //       return AlertDialog(
                    //         content: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             SizedBox(
                    //               width: 50,
                    //               height: 50,
                    //               child: CircularProgressIndicator(),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //   },
                    // );
                  },
                );
                setState(() => data.forEach((trashType, trashes) {
                      trashes.forEach((trash) {
                        trash.reset();
                      });
                    }));
                _animationController.reset();
              },
              icon: Icon(
                Icons.local_shipping_outlined,
                color: Colors.white,
              ),
              label: Text(
                "Сдать",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: ListView(
        children: widgets,
      ),
    );
  }
}
