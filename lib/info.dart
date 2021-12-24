import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Info extends StatelessWidget {
  const Info({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Card(
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
                        child: Text(
                          'Fotoğrafta Kompozisyon',
                          style: TextStyle(
                              fontSize: 27, fontFamily: "times new roman"),
                        ),
                      ),
                      Image.asset('assets/comp.jpg'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                            'Sanatta denge, uyum, ritim, derinlik gibi unsurlar kompozisyonu ' +
                                ' oluşturmaktadır. Fotoğrafçılıkta kompozisyon ise kadraja giren objeleri göze' +
                                ' hoş gelecek şekilde seçme ve düzenlemektir.',
                            style: TextStyle(
                                fontSize: 17, fontFamily: "times new roman")),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
                        child: Text(
                          'Üçler Kuralı',
                          style: TextStyle(
                              fontSize: 27, fontFamily: "times new roman"),
                        ),
                      ),
                      Image.asset('assets/rft.jpeg'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                            'İnsan gözünün ilk bakışta hangi noktalara dikkat ettiği bilimsel olarak kanıtlanmıştır.' +
                                'Fotoğrafçılıkta da insanların ilk olarak dikkat ettikleri noktalara objelerin konumlandırılması gerekir.' +
                                'Bu konumlandırma, kadrajın iki paralel iki de dikey çizgi ile eşit aralıklarla bölündüğü düşünüldüğünde,' +
                                'çizgilerin kesişim noktaları kabul edilerek yapılır.' +
                                'Ortaya çıkan dört kesişim noktası insan gözünün bir fotoğrafta ilk dikkat ettiği noktalardır.' +
                                'Fotoğrafın ana öğesi bu noktalara denk gelecek şekilde fotoğraf çekilirse kompozisyon güçlendirilmiş olur.',
                            style: TextStyle(
                                fontSize: 16, fontFamily: "times new roman")),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 20, 5, 30),
                        child: Text(
                          'İlgi Merkezi',
                          style: TextStyle(
                              fontSize: 27, fontFamily: "times new roman"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                            'İzleyen gözün fotoğrafa girmesini sağlayan, ana konuyu,' +
                                'ana fikri anlatan, gösteren vurgulu öge fotoğrafın ilgi merkezidir.' +
                                ' Görüntünün, görselliğin tekdüzeliğini yok eden bu öge,' +
                                ' fotoğrafın temel yapı taşıdır. ',
                            style: TextStyle(
                                fontSize: 16, fontFamily: "times new roman")),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
