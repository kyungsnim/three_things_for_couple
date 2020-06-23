import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:threethingsforcouple/constants/constants.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:threethingsforcouple/constants/data.dart';
import 'package:threethingsforcouple/constants/real_data.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    importExcelData();
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 44,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    DropdownButton(
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
                    ),
                  ],
                ),
              ),
              Container(
                height: 500,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
//                  itemCount: threeThings.length,
                  itemCount: 2,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder:
                    DotSwiperPaginationBuilder(activeSize: 20, space: 8),
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
//                        Navigator.push(
//                          context,
//                          PageRouteBuilder(
//                            pageBuilder: (context, a, b) => DetailPage(
////                              planetInfo: three[index],
//                            ),
//                          ),
//                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(height: 100),
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 100),
                                      Text(
                                        threeThings[index].title,
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 12,
                                          color: const Color(0xff47455f),
                                          fontWeight: FontWeight.w900,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Solar System',
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          fontSize: 23,
                                          color: primaryTextColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 32),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            'Know more',
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
//                          Hero(
//                            tag: planets[index].position,
//                            child: Image.asset(planets[index].iconImage),
//                          ),
                          Positioned(
                            right: 24,
                            bottom: 60,
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
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.0),
          ),
          color: navigationColor,
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Image.asset('assets/menu_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/search_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/profile_icon.png'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  importExcelData() async {

    String title, titleDesc, point1ForWoman, point1ForWomanDesc, point2ForWoman,
        point2ForWomanDesc, point3ForWoman, point3ForWomanDesc, point1ForMan, point1ForManDesc, point2ForMan,
        point2ForManDesc, point3ForMan, point3ForManDesc;

    ByteData data = await rootBundle.load("assets/three_things.xlsx");
    List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    int i = 0;
    // 나는 sheet1의 데이터만 볼 것이니..
    for (var table in excel.tables.keys) {
      if (table.toString() == "Sheet2" || table.toString() == "Sheet3") {
        continue;
      }
      for (var row in excel.tables[table].rows) {
        print('excel.tables[table].row : ${excel.tables[table].row}');

        List<dynamic> data = row.toList();
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
          "point1ForWoman" : point1ForWoman,
          "point1ForWomanDesc" : point1ForWomanDesc,
          "point2ForWoman" : point2ForWoman,
          "point2ForWomanDesc" : point2ForWomanDesc,
          "point3ForWoman" : point3ForWoman,
          "point3ForWomanDesc" : point3ForWomanDesc,
          "point1ForMan" : point1ForMan,
          "point1ForManDesc" : point1ForManDesc,
          "point2ForMan" : point2ForMan,
          "point2ForManDesc" : point2ForManDesc,
          "point3ForMan" : point3ForMan,
          "point3ForManDesc" : point3ForManDesc,
        };

        threeThings.add(new ThreeThingsInfo(++i, title, titleDesc, inputPoints));
      }
    }
  }
}