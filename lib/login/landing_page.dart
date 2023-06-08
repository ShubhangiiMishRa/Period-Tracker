import 'package:flutter/material.dart';
import 'package:nexus/Authentication/login_page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Authentication/signup_page.dart';
import '../globalVariable.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final images = [
    'images/s1.svg',
    'images/s2.svg',
    'images/s3.svg'
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, right: 16, left: 16),
              child: ListView(
                children: [
                  Center(
                      child: GradientText(
                    'Health App',
                    style: TextStyle(
                        fontFamily: 'alexbrush',
                        fontWeight: FontWeight.w600,
                        fontSize: 40),
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ttb,
                    colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                  )),
                  SizedBox(
                    height: 34,
                  ),
                  const Center(
                      child: Text(
                    'Daily health shots for your everyday health',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'mulish'),
                  )),
                  SizedBox(
                    height: 34,
                  ),
                  CarouselSlider.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = images[index];
                      return buildImage(image, index);
                    },
                    options: CarouselOptions(
                        height: 300,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                      }
                    ),
                  ),

                  buildIndicator(),
                  // ListView(
                  //   scrollDirection: Axis.horizontal,
                  //   children: [
                  //     Icon(Icons.circle, size: 10, color: Colors.black,),
                  //     Icon(Icons.circle, size: 10, color: Colors.black),
                  //     Icon(Icons.circle, size: 10, color: Colors.black),
                  //   ],
                  // ),
                  Container(
                    height: 44.0,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffdc3d83), Color(0xffac4dba)])),
                    child: ElevatedButton(
                      onPressed: () {
                        nextPage(context, SignUpPage());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Let\'s go'),
                    ),
                  ),
                  //ElevatedButton(onPressed: (){}, child: Text('Let\'s go'), style: ButtonStyle(gra)),
                  // GestureDetector(
                  //     onTap: () {
                  //       //nextPage(context, SignUpPage());
                  //     },
                  //     child: Image.asset('images/letsgo.png')),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientText(
                          "Already a member?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'mulish',
                            // shadows: [
                            //   Shadow(
                            //     color: Color.fromRGBO(0, 0, 0, 0.25),
                            //     offset: Offset(0, 4),
                            //     blurRadius: 4,
                            //   ),
                            // ]
                          ),
                          gradientType: GradientType.linear,
                          gradientDirection: GradientDirection.ttb,
                          colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                        ),
                        TextButton(
                          onPressed: () {
                            // nextPage(context, const LoginPage());
                          },
                          child: const Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'mulish',
                              color: Color(0xff9BCB3B),
                              // shadows: [
                              //   Shadow(
                              //     color: Color.fromRGBO(0, 0, 0, 0.25),
                              //     offset: Offset(0, 4),
                              //     blurRadius: 4,
                              //   ),
                              // ]
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // buildImage(String image, int index) => Stack(
  //       children: [
  //
  //         Center(child: SvgPicture.asset('images/bg.svg')),
  //         Center(child: SvgPicture.asset(image))
  //       ],
  //     );
  buildImage(String image, int index) =>
          Center(child: SvgPicture.asset(image));

  Widget buildIndicator() {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: AnimatedSmoothIndicator(
            activeIndex: activeIndex, count: images.length,
            effect: const SlideEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor:  Color(0xFFc938c5),
            ),
          ),
        ),
      );
  }
}
