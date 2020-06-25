import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:threethingsforcouple/constants/constants.dart';
import 'package:threethingsforcouple/constants/real_data.dart';

import 'lecture_detail_page.dart';

class LecturePage extends StatefulWidget {
  @override
  _LecturePageState createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  @override
  Widget build(BuildContext context) {
    importExcelData();

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                gradientStartColor.withOpacity(0.9),
                gradientEndColor.withOpacity(0.8)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.7])),
      child: SafeArea(
        child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(32,32,32,0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '남자와 여자',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 30,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.only(left: 20),
              child: Swiper(
//                  itemCount: threeThings.length,
                itemCount: 12, // 총 싣는 아이템 개수
                itemWidth: MediaQuery.of(context).size.width - 2 * 50,
                layout: SwiperLayout.STACK,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      activeSize: 15, space: 5, activeColor: primaryTextColor),
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, a, b) => LectureDetailPage(
                            threeThingsInfo: threeThings[index],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 70),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 30),
                                    Text(
                                      threeThings[index].title,
                                      style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: 23,
                                        color: const Color(0xff47455f),
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      threeThings[index]
                                              .titleDesc
                                              .substring(0, 60) +
                                          '...',
                                      style: TextStyle(
                                        fontFamily: 'Avenir',
                                        fontSize: 20,
                                        color: primaryTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(height: 50),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '자세히 보기',
                                          style: TextStyle(
                                            fontFamily: 'Avenir',
                                            fontSize: 18,
                                            color: secondaryTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: secondaryTextColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          // man
                          top: 50,
                          left: 10,
                          child: Container(
                            child: Image.asset("assets/mars.png"),
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Positioned(
                          // 남녀 아이콘
                          top: 47,
                          left: 115,
                          child: Icon(
                            Icons.wc,
                            size: 90,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        Positioned(
                          // woman
                          top: 50,
                          right: 10,
                          child: Container(
                            child: Hero(
                              tag: threeThings[index].position,
                              child: Image.asset("assets/venus.png"),
                            ),
                            width: 100,
                            height: 100,
                          ),
                        ),
//                          Hero(
//                            tag: planets[index].position,
//                            child: Image.asset(planets[index].iconImage),
//                          ),
                        Positioned(
                          right: 24,
                          top: 200,
                          child: Text(
                            threeThings[index].position.toString(),
                            style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 200,
                              color: primaryTextColor.withOpacity(0.08),
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  importExcelData() async {
    String title,
        titleDesc,
        point1ForWoman,
        point1ForWomanDesc,
        point2ForWoman,
        point2ForWomanDesc,
        point3ForWoman,
        point3ForWomanDesc,
        point1ForMan,
        point1ForManDesc,
        point2ForMan,
        point2ForManDesc,
        point3ForMan,
        point3ForManDesc;

    ByteData data = await rootBundle.load("assets/three_things.xlsx");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    int i = 0;
    // 나는 sheet1의 데이터만 볼 것이니..
    for (var table in excel.tables.keys) {
      if (table.toString() == "Sheet2" || table.toString() == "Sheet3") {
        continue;
      }
      for (var row in excel.tables[table].rows) {
        List<dynamic> data = row.toList();
        if (data[0].toString() == '중제목') {
          continue;
        } else {
          title = data[0].toString();
          titleDesc = data[1].toString();
          point1ForWoman = data[2].toString();
          point1ForWomanDesc = data[3].toString();
          point2ForWoman = data[4].toString();
          point2ForWomanDesc = data[5].toString();
          point3ForWoman = data[6].toString();
          point3ForWomanDesc = data[7].toString();
          point1ForMan = data[8].toString();
          point1ForManDesc = data[9].toString();
          point2ForMan = data[10].toString();
          point2ForManDesc = data[11].toString();
          point3ForMan = data[12].toString();
          point3ForManDesc = data[13].toString();

          Map<String, String> inputPoints = {
            "point1ForWoman": point1ForWoman, // 여자에게 해주는 조언1
            "point1ForWomanDesc": point1ForWomanDesc,
            "point2ForWoman": point2ForWoman, // 여자에게 해주는 조언2
            "point2ForWomanDesc": point2ForWomanDesc,
            "point3ForWoman": point3ForWoman, // 여자에게 해주는 조언3
            "point3ForWomanDesc": point3ForWomanDesc,
            "point1ForMan": point1ForMan, // 남자에게 해주는 조언1
            "point1ForManDesc": point1ForManDesc,
            "point2ForMan": point2ForMan, // 남자에게 해주는 조언2
            "point2ForManDesc": point2ForManDesc,
            "point3ForMan": point3ForMan, // 남자에게 해주는 조언3
            "point3ForManDesc": point3ForManDesc,
          };

          threeThings
              .add(new ThreeThingsInfo(++i, title, titleDesc, inputPoints));
        }
      }
    }
  }

  Widget dropDownButton() {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text(
            'Solar System',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              color: const Color(0x7cdbf1ff),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
      onChanged: (value) {},
      icon: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset('assets/drop_down_icon.png'),
      ),
      underline: SizedBox(),
    );
  }
}
