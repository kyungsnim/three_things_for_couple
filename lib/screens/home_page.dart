import 'package:flutter/material.dart';
import 'package:threethingsforcouple/constants/constants.dart';
import 'package:threethingsforcouple/screens/lecture_page.dart';

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
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              backgroundColor: gradientEndColor,
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                LecturePage(),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            gradientStartColor.withOpacity(0.9),
                            gradientEndColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 0.7])),
                ),
//                Board(),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            gradientStartColor.withOpacity(0.9),
                            gradientEndColor.withOpacity(0.8)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 0.7])),
                ),
//                Container(),
              ]),
              bottomNavigationBar: TabBar(
                unselectedLabelColor: navigationColor,
                labelColor: primaryTextColor,
                indicatorWeight: 5,
                indicatorColor: primaryTextColor,
                tabs: <Widget>[
                  Tab(
                    icon: Icon(
                      Icons.library_books,
                      size: 30,
                    ),
                    text: '남자와 여자',
                  ),
                  Tab(
                      icon: Icon(
                        Icons.question_answer,
                        size: 30,
                      ),
                      text: '나의 고민은'),
                  Tab(
                      icon: Icon(
                        Icons.perm_identity,
                        size: 30,
                      ),
                      text: '내 정보'),
//                  Tab(icon: Icon(Icons.more_horiz), text: 'More'),
                ],
              )

//        Container(
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.vertical(
//              top: Radius.circular(36.0),
//            ),
//            color: navigationColor,
//          ),
//          padding: const EdgeInsets.all(24),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.library_books),
//                color: Colors.blueGrey,
//                iconSize: 35,
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.question_answer),
//                color: Colors.blueGrey,
//                iconSize: 35,
//                onPressed: () {},
//              ),
//              IconButton(
//                icon: Icon(Icons.perm_identity),
//                color: Colors.blueGrey,
//                iconSize: 35,
//                onPressed: () {},
//              ),
//            ],
//          ),
//        ),
              ),
        ),
      ),
    );
  }

  // back 버튼 클릭시 종료할건지 물어보는
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("앱을 종료하시겠습니까?"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "예",
                  style: TextStyle(fontSize: 18, color: primaryTextColor),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text(
                  "아니요",
                  style: TextStyle(fontSize: 18, color: primaryTextColor),
                ),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ) ??
        false;
  }
}

//        appBar: AppBar(
//          title: CustomAppBar(),
//          centerTitle: false,
//          backgroundColor: titleTextColor,
//          elevation: 0.0,
//          actions: <Widget>[
//            GestureDetector(
//                onTap: () {
//                  showDialog(
//                    context: context,
//                    builder: (context) => AlertDialog(
//                      title: Text("로그아웃 하시겠습니까?"),
//                      actions: <Widget>[
//                        FlatButton(
//                          child: Text(
//                            "예",
//                            style: TextStyle(
//                                fontSize: 18, color: Colors.indigo),
//                          ),
//                          onPressed: () {
////                            fp.signOut();
//                            Navigator.pop(context, true);
//                          },
//                        ),
//                        FlatButton(
//                          child: Text(
//                            "아니요",
//                            style: TextStyle(
//                                fontSize: 18, color: Colors.redAccent),
//                          ),
//                          onPressed: () => Navigator.pop(context, false),
//                        ),
//                      ],
//                    ),
//                  );
//                },
//                child: Padding(
//                  padding: const EdgeInsets.only(right: 30.0),
//                  child: Icon(
//                    Icons.exit_to_app,
//                    color: Colors.indigo,
//                  ),
//                )),
//          ],
//        ),
