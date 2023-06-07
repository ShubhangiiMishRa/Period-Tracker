import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nexus/globalVariable.dart';
import 'package:nexus/home/home_page2.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({Key? key}) : super(key: key);

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> with TickerProviderStateMixin{
  int _selectedStory = 0;
  int _selectedIndex = 0;
  bool _pressed = false;
  late TabController _tabController;
  int selectedTab = 0;

  final topBar = ['Yoga', 'Conceiving', 'Conception','PCOD/PCOS','Menopause'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Stories',
            style: TextStyle(
              fontFamily: 'mulishbold',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: 1.33,
              color: Color(0xFF0F2F5B),
            ),
          ),
          centerTitle: true,
          bottom:  TabBar(
            splashFactory: InkSplash.splashFactory,
            indicatorColor: Color.fromRGBO(220, 61, 142, 1),
            isScrollable: true,
            controller:  _tabController,
            onTap: (v){
              customPrint("v :: $v");
              setState(() {
                selectedTab = v;
              });
            },
            tabs: List.generate(5, (index) => Column(
              children: [
                Text(
                  topBar[index],
                  style: TextStyle(fontSize: 16, color:  index == selectedTab? Color.fromRGBO(220, 61, 142, 1):Color(0xff191919)),
                ),
                SizedBox(width: 10,),
              ],
            )),
            // [
            //   Text(
            //     'Yoga',
            //     style: TextStyle(fontSize: 16, color: Color(0xff191919)),
            //   ),
            //   Text(
            //     'Conceiving',
            //     style: TextStyle(fontSize: 16, color: Color(0xff191919)),
            //   ),
            //   Text(
            //     'Conception',
            //     style: TextStyle(fontSize: 16, color: Color(0xff191919)),
            //   ),
            //   Text(
            //     'PCOD/PCOS',
            //     style: TextStyle(fontSize: 16, color: Color(0xff191919)),
            //   ),
            //   Text(
            //     'Menopause',
            //     style: TextStyle(fontSize: 16, color: Color(0xff191919)),
            //   ),
            // ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Brewed For You',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  height: 1.33,
                  color: Color(0xFF0F2F5B),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('images/Image.jpg'),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HEALTHY EATING',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.33,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'If you work out for more than an hour then you must eat carbs before you hit the gym, ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  height: 1.33,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Meghna Kriplaniiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            height: 1.33,
                                            color: Color(0xff8D8D8D)),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.bookmark_border_outlined,
                                        size: 18,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MENTAL HEALTH',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.33,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Anxiety got you down? We got 10 mental health experts to suggest how you',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      height: 1.33,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.asset('images/Image.jpg'))
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Subhchintamani S.V.',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        height: 1.33,
                                        color: Color(0xff8D8D8D)),
                                  ),
                                ),
                                // SizedBox(width: MediaQuery.of(context).size.width / 10,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 18,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MENTAL HEALTH',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.33,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Anxiety got you down? We got 10 mental health experts to suggest how you',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      height: 1.33,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.asset('images/Image.jpg'))
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Meghna Kriplani',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.33,
                                      color: Color(0xff8D8D8D)),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 18,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MENTAL HEALTH',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.33,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Anxiety got you down? We got 10 mental health experts to suggest how you',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      height: 1.33,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Image.asset('images/Image.jpg'))
                            ],
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Meghna Kriplani',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      height: 1.33,
                                      color: Color(0xff8D8D8D)),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.share,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.bookmark_border_outlined,
                                      size: 18,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // body: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     children: [
        //       Text(
        //         'Stories',
        //         style: TextStyle(
        //           // fontFamily: 'Roboto',
        //           fontFamily: 'Roboto',
        //           fontWeight: FontWeight.w600,
        //           fontSize: 18,
        //           height: 1.33,
        //           color: Color(0xFF0F2F5B),
        //         ),
        //       ),
        //       ListView(
        //         children: [
        //             Card(
        //
        //             ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
