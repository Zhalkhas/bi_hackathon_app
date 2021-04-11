import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_bi_musorapp/login.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:pimp_my_button/pimp_my_button.dart';

class TrashTracking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TrashTrackingState();
}

class _TrashTrackingState extends State<TrashTracking> {
  int index = 0;
  final List<List<String>> text = [
    [
      "Мусор попал в свой контейнер",
      "Отлично! Путь в милю начинается с одного шага"
    ],
    [
      "Мусор забрали из контейнеров",
      "Он уже едет на переработку, ура!",
    ],
    [
      "Мусор прибыл на пункт сортировки",
      "Тут решится его дальнейшая судьба",
    ],
    [
      "Мусор стал вторсырьем",
      "Отлично! Продолжайте в том же духе",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Трекинг"),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: Text(
              "Выйти",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => FirebaseAuth.instance.signOut().then(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  ),
                ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(4, (index) {
                  final isFirst = index == 0;
                  final isLast = index == 3;
                  final title = text[index][0];
                  final subtitle = text[index][1];
                  final indicatorStyle = IndicatorStyle(
                    color: index <= this.index ? Colors.green : Colors.grey,
                  );
                  final beforeStyle = LineStyle(
                    color: index <= this.index ? Colors.green : Colors.grey,
                  );
                  final afterStyle = LineStyle(
                    color: index - 1 < this.index ? Colors.green : Colors.grey,
                  );
                  return TimelineTile(
                    isFirst: isFirst,
                    isLast: isLast,
                    axis: TimelineAxis.vertical,
                    beforeLineStyle: beforeStyle,
                    afterLineStyle: afterStyle,
                    indicatorStyle: indicatorStyle,
                    endChild: ListTile(
                      title: Text(title),
                      subtitle: Text(subtitle),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: index != 3
                ? Container()
                : Card(
                    margin: EdgeInsets.all(15),
                    elevation: 5,
                    child: Center(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PimpedButton(
                            pimpedWidgetBuilder: (context, controller) {
                              Future.delayed(Duration(milliseconds: 500))
                                  .then((value) => controller.forward());
                              return Image.asset(
                                "assets/images/planet-earth.png",
                                width: size.width * 0.35,
                                height: size.width * 0.35,
                              );
                            },
                            particle: DemoParticle(),
                          ),
                        ),
                        subtitle: Text(
                            "Поздравляю! Ваш мусор обернулся в мусорный кокон, и из ужасного мусора превратился в мусорную бабочку. Бутылка, которую сделают из пластика что вы сдали напоит бедных африканских детей, ваш вклад в зеленое дело неоценим!"),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
