import 'package:flutter/material.dart';
import 'package:threethingsforcouple/constants/constants.dart';
import 'package:threethingsforcouple/constants/real_data.dart';


class LectureDetailPage extends StatefulWidget {
  final ThreeThingsInfo threeThingsInfo;

  const LectureDetailPage({Key key, this.threeThingsInfo}) : super(key: key);

  @override
  _LectureDetailPageState createState() => _LectureDetailPageState();
}

class _LectureDetailPageState extends State<LectureDetailPage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 100),
                      Text(
                        widget.threeThingsInfo.title,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 40,
                          color: primaryTextColor,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.black38),
                      SizedBox(height: 20),
                      Text(
                        widget.threeThingsInfo.titleDesc ?? '',
                        maxLines: 20,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 20,
                          color: contentTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.black38),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          '부부의 3개',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 25,
                            color: const Color(0xff47455f),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      threeThingCard(size, 1, 'To Women', gradientEndColor, widget.threeThingsInfo.points.values.toList()[0]),
                      threeThingCard(size, 2, 'To Women', gradientEndColor, widget.threeThingsInfo.points.values.toList()[2]),
                      threeThingCard(size, 3, 'To Women', gradientEndColor, widget.threeThingsInfo.points.values.toList()[4]),
                      threeThingCard(size, 1, 'To Men', gradientStartColor, widget.threeThingsInfo.points.values.toList()[6]),
                      threeThingCard(size, 2, 'To Men', gradientStartColor, widget.threeThingsInfo.points.values.toList()[8]),
                      threeThingCard(size, 3, 'To Men', gradientStartColor, widget.threeThingsInfo.points.values.toList()[10]),
                    ],
                  ),
                ),

//                  Container(
//                    height: 250,
//                    padding: const EdgeInsets.only(left: 32.0),
//                    child: ListView.builder(
//                        itemCount: planetInfo.images.length,
//                        scrollDirection: Axis.horizontal,
//                        itemBuilder: (context, index) {
//                          return Card(
//                            clipBehavior: Clip.antiAlias,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(24),
//                            ),
//                            child: AspectRatio(
//                                aspectRatio: 1,
//                                child: Image.network(
//                                  planetInfo.images[index],
//                                  fit: BoxFit.cover,
//                                )),
//                          );
//                        }),
//                  ),
              ],
            ),
//            Positioned(
//              right: -64,
//              child: Hero(
//                  tag: threeThingsInfo.position,
//                  child: Image.asset("assets/venus.png"),
//            ),
            Positioned(
              left: 32,
              child: Text(
                widget.threeThingsInfo.position.toString(),
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 200,
                  color: primaryTextColor.withOpacity(0.1),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget threeThingCard(size, number, toWho, color, cardTitle) {
    return Stack(
      children: [
        Container(
          width: size.width * 0.9,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cardTitle.toString(),
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 15,
                      color: const Color(0xff47455f),
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0,0,0),
          child: Text(toWho,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: color.withOpacity(0.9)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,20,0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(number.toString(),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: color.withOpacity(0.9)
              ),
            ),
          ),
        )
      ]
    );
  }
}
