import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/api/userdata.dart';
import 'package:nexus/login/splash_Screen.dart';
import 'package:nexus/main.dart';
import 'package:nexus/util/colors.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../Widgets/progressHud.dart';
import '../globalVariable.dart';
import '../home/tutorial_page/tutorial_page.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
  final String phoneNumber;
}

class _OTPPageState extends State<OTPPage> {
  static TextEditingController otpController = TextEditingController();
  bool loading = false;
  bool isEnable = false;



  // void _validateOtpCode(String value) {
  //   if (value.length == 6 && int.tryParse(value) != null) {
  //     setState(() {
  //       _otpCode = value;
  //     });
  //   } else {
  //     setState(() {
  //       _otpCode = '';
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhoneNumber(widget.phoneNumber, context);
  }

  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: ProgressHUD(
        isLoading: loading,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: ListView(
                children: [
                  //Container(
                  //alignment: Alignment.topLeft, child: const BackButton()),
                  Padding(
                    padding: const EdgeInsets.only(top: 158, bottom: 34),
                    child: Center(
                        child: GradientText(
                          'Verification',
                          style: TextStyle(
                              fontFamily: 'alexbrush',
                              fontWeight: FontWeight.w600,
                              fontSize: 40),
                          gradientType: GradientType.linear,
                          gradientDirection: GradientDirection.ttb,
                          colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                        )),
                  ),
                  //Image.asset('images/verificationtext.png'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 42),
                    child: const Center(
                        child: Text(
                          'Enter OTP sent on your mobile number',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'mulish'),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 47),
                    child: Container(
                      width: 335,
                      height: 48.04,
                      margin: EdgeInsets.only(
                        left: 5,
                        top: 42,
                        right: 5,
                      ),
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Pinput(
                            controller: pinController,
                            length: 6,
                            toolbarEnabled: false,
                            onChanged: (value){
                              print(value);
                              if(value.length == 6){
                                setState(() {
                                  isEnable = true;
                                });

                              }else{
                                setState(() {
                                  isEnable = false;
                                });
                              }
                              print("isEnable  :: $isEnable");
                            },
                            inputFormatters: [
                              // Formatter()
                            ],
                          ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         _validateOtpCode;
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // Expanded(
                          //   child: Container(
                          //     width: 50,
                          //     height: 48.04,
                          //     decoration: BoxDecoration(
                          //       color: Color(0xffEDEDED),
                          //       borderRadius: BorderRadius.circular(13),
                          //     ),
                          //     padding: EdgeInsets.all(10),
                          //     child: TextField(
                          //       onChanged: (_) {
                          //         FocusScope.of(context).nextFocus();
                          //       },
                          //       keyboardType: TextInputType.number,
                          //       maxLength: 1,
                          //       decoration: new InputDecoration(
                          //           counterText: "",
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.symmetric(
                          //               vertical: 8, horizontal: 7),
                          //           //hintText: 'Enter Mobile Number'
                          //           hintText: '0'),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 5,
                          ),
                          // add your child widgets here
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                            begin:   Alignment.topCenter ,
                            end: Alignment.bottomCenter,
                            colors: isEnable ? [Color(0xffdc3d83), Color(0xffac4dba)] : [colorDisable ,colorDisable])),
                    child: ElevatedButton(
                      onPressed: () {



                        if(isEnable){
                          // customPrint('OTP ::::   ${_otpCode}');
                          verifyOTPNumber(pinController.text, context)
                              .then((value) async {


                            customPrint("widget.phoneNumber  :: ${widget.phoneNumber}");
                            await prefs.setString(LocalStorage.phoneNumber, widget.phoneNumber);
                            customPrint("LocalStorage.phoneNumber :: ${prefs.getString(LocalStorage.phoneNumber)}");
                            setState(() {

                            });
                          });
                        }else{

                        }

                        // nextPage(context, Tut_page());
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text('Submit',style: TextStyle(color: isEnable ? colorWhite : colorBlack),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
