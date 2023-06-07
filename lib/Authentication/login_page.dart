import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nexus/Authentication/signup_page.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/main.dart';
import 'package:nexus/screens/calendar_picker.dart';
import 'package:nexus/screens/my_profile.dart';
import 'package:nexus/screens/stories.dart';
import 'package:nexus/Authentication/verification_page.dart';
import 'package:nexus/screens/testpage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../screens/history_page.dart';
import '../screens/navigation.dart';
import '../screens/periods_log.dart';
// import '../Widgets/my_textfield.dart';
import '../globalVariable.dart';
import '../home/home_page.dart';
import '../home/testPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool splash = true;
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 89, bottom: 34),
                    child: Center(
                        child: GradientText(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'alexbrush',
                          fontWeight: FontWeight.w600,
                          fontSize: 40),
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ltr,
                      colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                    )),
                  ),
                  const Center(
                      child: Text(
                        'Welcome Back User',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'mulish'),
                      )),
                  SizedBox(
                    height: 42,
                  ),
                  // MyTextFiled(
                  //   //placeholder: "Enter e-mail",
                  //   controller: mobileNumberController,
                  //   hint: "Mobile number",
                  //   inputType: TextInputType.emailAddress,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 71.73,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.60784),
                      color: Color(0xFFFAFAFA),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Number',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'mulishbold'),
                        ),
                        SizedBox(height: 5),
                        // IntlPhoneField(
                        //   decoration: InputDecoration(
                        //     labelText: 'Phone Number',
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(),
                        //     ),
                        //   ),
                        //   initialCountryCode: 'IN',
                        //   onChanged: (phone) {
                        //     print(phone.completeNumber);
                        //   },
                        // )
                        IntlPhoneField(
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            hintText: 'Enter Phone Number',
                            contentPadding: EdgeInsets.all(10),
                            counterText: "",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              // borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'IN',
                          autovalidateMode: AutovalidateMode.disabled,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 71.73,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9.60784),
                      color: Color(0xFFFAFAFA),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OTP',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'mulishbold'),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48.04,
                          padding: EdgeInsets.symmetric(horizontal: 15.3725),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(9.60784),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            maxLength: 6,
                            style: TextStyle(
                              fontSize: 15
                            ),
                            decoration: new InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: Image.asset('icons/otp.png'),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                //hintText: 'Enter Mobile Number'
                                hintText: 'Enter OTP'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 27.18,
                  ),
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
                      onPressed: () async{
                        // prefs.setBool(MyApp.K, )
                        if(debugMode){
                          nextPage(context, NavigatorPage());
                        }
                        customPrint(prefs.getBool(LocalStorage.isLoggedIn));
                        await prefs.setBool(LocalStorage.isLoggedIn, true);
                        UserData.isLoggedIn = true;
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Login'),
                    ),
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       nextPage(
                  //           context,
                  //           OTPPage(
                  //             phoneNumber: '687687929',
                  //           ));
                  //     },
                  //     child: Image.asset('images/loginbutton.png')),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don\'t have an account?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'mulish',
                              color: Colors.black
                              ),

                        ),
                        TextButton(
                          onPressed: () {
                            nextPage(context, SignUpPage());
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'mulish',
                                color: Color(0xff9BCB3B),
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

  void getUserDetails() {}
}
