import 'package:flutter/material.dart';
import 'package:solvecase/Classes/Constants.dart';
import 'package:solvecase/Classes/DatabaseHelper.dart';
import 'package:solvecase/Classes/solution.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DrawerScreen.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  final dbHelper = DatabaseHelper.instance;

  List<Solution> bookmarks = [];

  void getAllItems() async {
    final allRows = await dbHelper.queryAllRows();
    bookmarks.clear();
    allRows.forEach((row) => bookmarks.add(Solution.fromMap(row)));
    setState(() {});
  }

  @override
  void initState() {
    getAllItems();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: DrawerScreen(),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: pHeight * 0.18,
            width: pWidth,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kPrimaryColor,
                  Color(0xFFF26969),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: pHeight * 0.04,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: pHeight * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Bookmarks',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: pHeight * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: pHeight * 0.005,
                ),
//                Center(
//                  child: Container(
//                    width: pWidth * 0.92,
//                    height: pHeight * 0.05,
//                    decoration: BoxDecoration(
//                      color: Color(0xFFF7A1A1),
//                      borderRadius: BorderRadius.circular(8),
//                    ),
//                    child: Center(
//                      child: TextFormField(
//                        controller: search,
//                        decoration: InputDecoration(
//                          suffixIcon: Icon(
//                            Icons.search,
//                            color: kPrimaryColor,
//                          ),
//                          hintText: 'Search',
//                          hintStyle: TextStyle(
//                              color: kPrimaryColor,
//                              fontSize: pHeight * 0.02,
//                              fontFamily: 'Poppins'),
//                          border:
//                              OutlineInputBorder(borderSide: BorderSide.none),
//                        ),
//                      ),
//                    ),
//                  ),
//                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: EdgeInsets.only(bottom: 20),
                        elevation: 1,
                        shadowColor: Colors.black.withOpacity(0.75),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${bookmarks[index].name}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.75),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.file_download,
                                        color: Colors.black.withOpacity(0.75),
                                      ),
                                      onPressed: () {
                                        _launchURL1(bookmarks[index].url);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  _launchURL1(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
