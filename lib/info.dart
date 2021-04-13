import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:hackathon_bi_musorapp/consts.dart';
import 'package:hackathon_bi_musorapp/trash_data.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:http/http.dart' as http;

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoState();
}

class InfoSlides extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final List<Slide> slides = trashData
    //     .map(
    //       (e) => Slide(
    //         backgroundColor: Colors.white,
    //         title: e.title,
    //         styleTitle: Theme.of(context)
    //             .textTheme
    //             .headline4
    //             .copyWith(fontWeight: FontWeight.bold),
    //         description: e.description,
    //         styleDescription:
    //             Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
    //         pathImage: e.assetUri,
    //       ),
    //     )
    //     .toList();
    final size = MediaQuery.of(context).size;

    return Swiper(
      layout: SwiperLayout.STACK,
      plugins: [SwiperPagination()],
      itemCount: trashData.length - 1,
      itemWidth: size.width * 0.95,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      trashData[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      trashData[index].assetUri,
                      width: size.width * 0.4,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  trashData[index].description,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class QrScan extends StatefulWidget {
  final VoidCallback onWindowClose;

  const QrScan({Key key, this.onWindowClose}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<TrashType> getTrash(String code) async {
      print('doing get');
      final resp = await http.get("$baseURL/bihack/rest/item/$code");
      print('resp $resp');
      if (resp.statusCode == 500) {
        print('no responce');
        return trashData.last;
      }
      final json = jsonDecode(resp.body);
      print("found somth $json");
      return trashData
          .firstWhere((element) => element.title.contains(json['type'].substring(0,4)));
    }

    return QrCamera(
      qrCodeCallback: (code) async {
        if (isScanning) {
          isScanning = false;
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                      future: getTrash(code),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var t = snapshot.data;

                          return Container(
                            height: size.height * 0.5,
                            width: size.width * 0.8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: t.title.contains("404")
                                  ? Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Не найдено в базе, пожалуйста, выберите маркировку на продукте",
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: GridView.count(
                                            crossAxisCount: 3,
                                            children: trashData
                                                .sublist(
                                                    0, trashData.length - 1)
                                                .map(
                                                  (e) => InkWell(
                                                    child:
                                                        Image.asset(e.assetUri),
                                                    onTap: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      print("sending");
                                                      var resp = await http.post(
                                                          "$baseURL/bihack/rest/item/new/",
                                                          body: jsonEncode({
                                                            'code': code,
                                                            'type': e.title
                                                          }));
                                                      print(
                                                          'sent ${resp.statusCode}: ${resp.body}');
                                                    },
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  t.title,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Image.asset(
                                                  t.assetUri,
                                                  width: size.width * 0.4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              t.description,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Card(
                              child: Text("${snapshot.error}"),
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
            },
          );
          isScanning = true;
        }
      },
    );
  }
}

class ListText extends StatelessWidget {
  final String text;
  final TextSpan textSpan;
  final bool span;

  const ListText({Key key, this.text, this.textSpan, this.span = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: span
          ? RichText(text: textSpan)
          : Text(
              text,
              style: Theme.of(context).textTheme.headline6,
            ),
    );
  }
}

class ListHeadText extends StatelessWidget {
  final String text;

  const ListHeadText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TrashInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        ListHeadText(
          text: "Инструкция по раздельному сбору мусора",
        ),
        ListText(
          text:
              "Начав собирать отходы раздельно, вы можете сократить их количество, как минимум, в два раза, а может, и ещё больше. Лично вы сократите вырубку деревьев, опасную добычу нефти, металлов, уменьшите влияние на изменение климата, спасёте животных, погибающих от того, что они принимают пластиковые отходы на свалках и в океанах за еду.",
        ),
        Image.asset(
          "assets/images/oleni.jpg",
          fit: BoxFit.fitWidth,
        ),
        ListHeadText(
          text: "Что и как можно собирать раздельно?",
        ),
        ListText(
          text:
              "Решите, что будете собирать. Советуем начать с чего-то одного, например, макулатуры: её не надо мыть. Когда освоитесь с одной фракцией, добавляйте другие. Темп регулируйте сами и никого не слушайте. Тут важно, чтобы вам было комфортно.",
        ),
        ListText(
          text:
              "Неважно, решили вы собирать сначала один вид вторсырья или сразу несколько, важно делать это правильно. Иногда неперерабатываемые отходы маскируются под вторсырьё, их надо вовремя заметить и отложить в сторонку, чтобы не испортить партию переработчикам. Далее вы узнаете как это делать",
        ),
        Divider(),
        Image.asset(
          "assets/images/paper.png",
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Макулатура"),
        ListText(
          span: true,
          textSpan: TextSpan(
            text: "Что сдаем: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "незагрязненные бумагу и картон.\n\n",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextSpan(
                text: "Что игнорируем: ",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text:
                    "чеки, туалетную бумагу, салфетки, карточки от метро, одноразовые “бумажные” стаканчики от кофе, пачки из-под сигарет, подложки из-под яиц.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Divider(),
        Image.asset(
          'assets/images/metal.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Металл"),
        ListText(
          span: true,
          textSpan: TextSpan(
            text: "Что сдаем: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text:
                    "консервные банки, алюминиевые банки из-под напитков, крышки из-под стеклянных банок.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Divider(),
        Image.asset(
          'assets/images/glass.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Стекло"),
        ListText(
          span: true,
          textSpan: TextSpan(
            text: "Что сдаем: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text:
                    "бутылки и банки, иногда принимают разбитое стекло, уточняйте у приёмщика (и не порежьтесь).\n\n",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextSpan(
                text: "Что игнорируем: ",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "лампочки накаливания.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Divider(),
        Image.asset(
          'assets/images/plastic1.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Пластик"),
        ListText(
          text:
              "Его существует семь видов, маркировка указана в треугольничке. Подробнее о видах пластика вы можете прочитать в следующей вкладке",
        ),
        Divider(),
        Image.asset(
          'assets/images/tetrapak1.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Тетрапак"),
        ListText(
          span: true,
          textSpan: TextSpan(
            text: "Что сдаем: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text:
                    "коробки из-под сока, молока, кефира.Упаковку из-под пищевых продуктов советуем мыть, чтобы не появилось неприятного запаха.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Divider(),
        Image.asset(
          'assets/images/danger.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Опасные отходы"),
        ListText(
          span: true,
          textSpan: TextSpan(
            text: "Что сдаем: ",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text:
                    "батарейки, аккумуляторы, ртутные лампы и градусники, электрохлам, просроченные лекарства, шины.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Divider(),
        Image.asset(
          'assets/images/clothes.png',
          height: size.height * 0.08,
        ),
        ListHeadText(text: "Одежда"),
        ListText(
          text:
              "Хорошую одежду можно отдать на благотворительность в фонды или магазины типа Charity shop, «Спасибо!». На переработку принимают некоторые сетевые магазины, например, Uniqlo.",
        ),
        ListHeadText(text: "Как собирать вторсырьё?"),
        ListText(
          text:
              "Поставьте рядом с обычным мусорным ведром второе и складывайте в него всё вторсырьё. Перед сдачей просто рассортируйте его на виды.Собирать вторсырьё можно в обычные коробки или специальные контейнеры, которые продаются в мебельных магазинах. Предложений много: узкие для крохотных кухонь, широкие со скошенной крышкой, чтобы ставить их друг на друга.",
        ),
        Image.asset("assets/images/muzhik_i_baba.jpg", fit: BoxFit.fitWidth),
        ListHeadText(
          text: "Что же дальше?",
        ),
        ListText(
          text:
              "Новые привычки не приживаются сразу, поэтому не корите себя, если по старой памяти выбросите что-то в ведро со смешанными отходами. Постепенно вы войдёте во вкус и жить иначе уже не сможете. Когда это произойдёт, можно переходить на следующий уровень и стремиться к тому самому нулю отходов, становясь более осознанным жителем жилых комплексов BI Group",
        ),
        Image.asset("assets/images/musoronos.jpg", fit: BoxFit.fitWidth)
      ],
    );
  }
}

class _InfoState extends State<Info> with TickerProviderStateMixin {
  int currentTab = 0;
  final List<Widget> tabs = [
    TrashInfo(),
    InfoSlides(),
    QrScan(
      onWindowClose: () {},
    ),
  ];
  bool isScanning = true;
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Памятка"),
          elevation: 0,
          bottom: TabBar(
            controller: _controller,
            onTap: (value) => setState(() => currentTab = value),
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.info),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(FontAwesome5.recycle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(FontAwesome5.barcode),
              ),
            ],
          ),
        ),
        body: tabs[currentTab],
      ),
    );
  }
}
