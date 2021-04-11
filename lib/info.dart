import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoState();
}

class TrashType {
  final String title;
  final String description;
  final String assetUri;

  TrashType({this.title, this.description, this.assetUri});
}

class InfoSlides extends StatelessWidget {
  final List<TrashType> data = [
    TrashType(
      title: "PET(E) или ПЭТ",
      description:
          "полиэтилентерефталат: обычно это бутылки с выпуклой точкой на дне, в которых продают воду, газировку, молоко, масло. Также из ПЭТа часто делают прозрачные флаконы для шампуней, одноразовые пищевые контейнеры. Его можно сдать на переработку.",
      assetUri: 'assets/images/1.png',
    ),
    TrashType(
      title: "PEHD (HDPE) или ПНД",
      description:
          "полиэтилен низкого давления: канистры, крышки для бутылок, флаконы из-под косметики и бытовой химии. Его можно сдать на переработку.",
      assetUri: "assets/images/2.png",
    ),
    TrashType(
      title: "PVC или ПВХ",
      description:
          "поливинилхлорид: оконные рамы, блистеры, упаковки из-под таблеток, а также тортов и творога, термоусадочная плёнка, флаконы для косметики, игрушки. Избегайте такой упаковки, она вредна, её практически невозможно сдать на переработку.",
      assetUri: "assets/images/3.png",
    ),
    TrashType(
      title: "PELD (LDPE) или ПВД",
      description:
          " полиэтилен высокого давления (низкой плотности): пакеты и плёнка. Четвёрку можно сдать на переработку, но придётся поискать где.",
      assetUri: "assets/images/4.png",
    ),
    TrashType(
      title: "PP или ПП",
      description:
          "полипропилен: крышки для бутылок, вёдра и ведёрки, стаканчики для йогурта, упаковка линз, шуршащая пластиковая упаковка. Пятёрку можно сдать на переработку.",
      assetUri: "assets/images/5.png",
    ),
    TrashType(
      title: "PS или ПС",
      description:
          "полистирол, бывает обычный и вспененный. Из вспененного полистирола делают пенопласт, контейнеры для яиц, подложки для мяса и фасовки. Из обычного полистирола — стаканчики для йогурта и упаковку для компакт-дисков, а также почти всю одноразовую посуду. Можно сдать на переработку, но лучше избегать такую упаковку, она вредна.",
      assetUri: "assets/images/6.png",
    ),
    TrashType(
      title: "O(ther) или ДРУГОЕ",
      description:
          "Смесь различных пластиков или полимеры, не указанные выше. Например, упаковка для сыра, кофе, корма для животных. Переработке не подлежит.",
      assetUri: "assets/images/7.png",
    ),
    TrashType(
      title: "20–22 (PAP)",
      description:
          "бумага и картон. Коробки от бытовой техники, продуктов, косметики; открытки, обложки книг, журналы и газеты, конверты, бумажные пакеты, бумага для печати. Можно сдать на переработку.",
      assetUri: "assets/images/8.png",
    ),
    TrashType(
      title: "40 (FE)",
      description:
          "жесть: консервные банки, баллончики аэрозолей. Консервные банки можно сдать на переработку, баллончики принимают не везде.",
      assetUri: "assets/images/9.png",
    ),
    TrashType(
      title: "41 (ALU)",
      description:
          "алюминий: банки для напитков и фольга. Можно сдать на переработку, но фольгу принимают только в Петербурге.",
      assetUri: "assets/images/10.png",
    ),
    TrashType(
      title: "70–74 (GL)",
      description:
          "стекло и стеклотара. Бесцветное прозрачное, зелёное, коричневое, светло-коричневое и тёмно-коричневое бутылочное стекло. Банки и бутылки можно сдать на переработку.",
      assetUri: "assets/images/11.png",
    ),
    TrashType(
      title: "81–84 (С/PAP) ",
      description:
          "композиционные материалы: многослойная упаковка из бумаги, пластика и иногда металла. Такую упаковку называют «тетрапаком» или «пюрпаком» и используют, например, для сока и молочных продуктов. Можно сдать, но переработка очень сложная и дорогая.",
      assetUri: "assets/images/12.png",
    ),
    TrashType(
      title: "d2w",
      description:
          "d2w указывает на так называемый оксоразлагаемый пластик. Знак ставят на пластиковую упаковку, в состав которой добавили присадку — компонент, отвечающий за быстрый распад пластика на микрочастицы. В переработку этот пластик сдавать нельзя. Такие товары лучше не покупать.",
      assetUri: "assets/images/d2w.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Slide> slides = data
        .map(
          (e) => Slide(
            backgroundColor: Colors.white,
            title: e.title,
            styleTitle: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.bold),
            description: e.description,
            styleDescription:
                Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
            pathImage: e.assetUri,
          ),
        )
        .toList();
    final size = MediaQuery.of(context).size;

    return Swiper(
      layout: SwiperLayout.STACK,
      plugins: [SwiperPagination()],
      itemCount: data.length,
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
                      data[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      data[index].assetUri,
                      width: size.width * 0.4,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  data[index].description,
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
  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    return QrCamera(qrCodeCallback: (code) async {
      if (isScanning) {
        isScanning = false;
        final f = Future.delayed(Duration(seconds: 1)).then((value) => "s");
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: f,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Card(
                            child: ListTile(
                              title: Text("YOURRE TRASH"),
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
            );
          },
        );
        isScanning = true;
      }
    });
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

class _InfoState extends State<Info> {
  int currentTab = 0;
  final List<Widget> tabs = [
    TrashInfo(),
    InfoSlides(),
    QrScan(),
  ];
  bool isScanning = true;

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
            onTap: (value) => setState(() => currentTab = value),
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.info),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Icon(Icons.info),
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
