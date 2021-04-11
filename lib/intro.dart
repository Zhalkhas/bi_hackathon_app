import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'login.dart';

class AppIntroSlider extends StatelessWidget {
  final _slides = [
    Slide(
        title: "Добро пожаловать!",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Это приложение поможет вам практиковать раздельный сбор мусора и Вы своими усилиями сделаете планету чище для себя, своих близких и для нас! Спасибо!",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_1.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
    Slide(
        title: "Трекинг",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Отслеживайте местоположение сортированного Вами мусора до пункта приема",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_2.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
    Slide(
        title: "Учет сортировки",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "Ведите личный учет сдачи мусора и получайте за это баллы",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_3.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
    Slide(
        title: "Сканер штрих кодов",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "А так же Вы можете узнать типа мусора отсканировав штрих-код или QR-код упаковки",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_4.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
    Slide(
        title: "Памятка для новичков",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Определяйте тип мусора с помощью встроенной инструкции во вкладке \"Памятка\"",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_5.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
    Slide(
        title: "Начните сегодня!",
        styleTitle: TextStyle(
          color: Colors.green,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            "Будьте основоположником современного развития экологии в нашей стране, осознанным гражданином",
        styleDescription: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "assets/images/intro_6.png",
        colorBegin: Colors.transparent,
        colorEnd: Colors.transparent),
  ];

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: CustomPaint(
            painter: BottomCurve(),
            child: IntroSlider(
              nameNextBtn: "След.",
              namePrevBtn: "Пред.",
              isShowSkipBtn: false,
              isShowPrevBtn: true,
              nameDoneBtn: "Вход",
              backgroundColorAllSlides: Colors.transparent,
              slides: _slides,
              onDonePress: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              ),
            )),
      );
}
