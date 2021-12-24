import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'main.dart';
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) =>MyImagePicker(
        title: "main",
      ),),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Fotoğrafta Kompozisyon",
          body:
              "Kadraja giren objeleri göze hoş gelecek şekilde seçme ve düzenlemektir.",
          image: _buildImage('rot'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Üçler Kuralı",
          body:
              "Üçler kuralı, fotoğraftaki ana objelerin insan gözünün ilk bakışta dikkat ettiği "+ 
              "noktalara konumlandırılmasıdır.Bunun için kadrajın iki yatay ve iki dikey çizgi"+ 
              "ile eşit aralıklarla bölünmesi ve çizgilerin kesişim noktalarına fotoğrafın"+
              " ana ögelerinin yerleştirilmesi gerekir",
          image: _buildImage('rotR'),
          decoration: pageDecoration,
        ),
    
       
        PageViewModel(
          title: "Kompozisyon Asistanı",
          body:"Uygulamaya yüklenen fotoğrafların üçler kurulanı uygunluğuna "+
          "kontrol eder, uymayan durumlar için öneriler sunar." 
          ,
          image: _buildImage('img'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Atla'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Bitir', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}