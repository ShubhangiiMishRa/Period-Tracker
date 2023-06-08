import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nexus/Authentication/verification_page.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/api/userdata.dart';

import 'package:nexus/main.dart';
import 'package:nexus/util/colors.dart';

import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../globalVariable.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstDate = TextEditingController();
  TextEditingController selectPeriodDate = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController _dropdownageController = TextEditingController();
  TextEditingController _dropdownsexualController = TextEditingController();
  TextEditingController _dropdowncycledaysController = TextEditingController();
  TextEditingController _periodflowController = TextEditingController();

  bool isEmailError= false;
  String emailErrorMessage = '';
  bool isNameError= false;
  bool isNuberError= false;
  String nameErrorMessage = '';
  String numberErrorMessage = '';
  // Initial Selected Value
  DateTime? pickedDate;
  double height = 45;
  String dropdownvalue = 'No';
  String ageDropDown = '18';
  String daysDropDown = '24';
  bool isAgeValueValid = false;
  // List of items in our dropdown menu
  var items = [
    'Yes',
    'No',
  ];
  List<String> age = [for (int i = 12; i < 61; i++) i.toString()];
  List<String> numberOfDays = [for (int i = 24; i < 41; i++) i.toString()];
  RxString phoneNumber = ''.obs;

  late BuildContext context1;


  @override
  Widget build(BuildContext context) {
    context1 = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Center(
                    child: GradientText(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'alexbrush',
                          fontWeight: FontWeight.w600,
                          fontSize: 40),
                      gradientType: GradientType.linear,
                      gradientDirection: GradientDirection.ttb,
                      colors: [Color(0xffdc3d83), Color(0xffac4dba)],
                    )),
                SizedBox(
                  height: 10,
                ),
                const Center(
                    child: Text(
                      'Enter details to get started',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'mulish'),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 71.73,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            // padding: EdgeInsets.only(l),
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextFormField(
                              controller: nameController,
                              style: TextStyle(fontSize: 15),
                              keyboardType: TextInputType.name,
                              validator: (value){
                                setState(() {
                                  if(value == null  || value.toString().isEmpty) {
                                    isNameError = true;
                                    nameErrorMessage = 'Enter name';
                                  } else {
                                    isNameError = false;
                                    nameErrorMessage = '';
                                  }
                                });
                              },
                              // onChanged: (value){
                              //   setState(() {
                              //   });
                              // },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z]')),
                                // RegExp(r'^[a-zA-Z ]+$')),
                              ],
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //suffixIcon: Image.asset('icons/otp.png'),
                                  contentPadding:
                                  EdgeInsets.only(left: 12),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: 'Enter Full Name'),
                            ),
                          ),
                          isNameError?Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22, top: 10), child: Text(nameErrorMessage, style: TextStyle(color: Color(0xffd61e36),fontSize: 12),)):SizedBox(height: 0,),

                        ],
                      ),
                      SizedBox(height: 15.37),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              // color: Color(0xFFA6A6A6),
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                setState(() {
                                  if (value!.isEmpty) {
                                    isEmailError = true;
                                    emailErrorMessage = 'Enter email';

                                  }
                                  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                  // final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(value)) {
                                    isEmailError = true;
                                    emailErrorMessage = 'Enter a valid email';
                                  }
                                  if (emailRegex.hasMatch(value)) {
                                    isEmailError = false;
                                    emailErrorMessage = '';
                                  }
                                  return null;
                                });
                              },
                              // validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                              // validator: validateEmail,
                              style: TextStyle(fontSize: 15),
                              keyboardType: TextInputType.emailAddress,
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //suffixIcon: Image.asset('icons/otp.png'),
                                  // contentPadding:
                                  //     EdgeInsets.symmetric(vertical: 10),
                                  contentPadding:
                                  EdgeInsets.only(left: 12),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: 'Enter Email'),
                            ),
                          ),
                          isEmailError?Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22, top: 10), child: Text(emailErrorMessage, style: TextStyle(color: Color(0xffd61e36),fontSize: 12),)):SizedBox(height: 0,),
                        ],
                      ),
                      SizedBox(height: 15.37),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: height,
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              // color: Color(0xFFA6A6A6),
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: IntlPhoneField(

                              validator: (value) {

                                // setState(() {
                                if (value.toString().isEmpty || value!.number.length != 10) {
                                  // showSnackbar(context, "Please enter your phone number", colorError);

                                  // isNuberError = true;
                                  //   numberErrorMessage = "Please enter your phone number";

                                  // setState(() {
                                  //   height = 85;
                                  //   customPrint("hyyy 86");
                                  // });
                                  // return "";
                                  return 'Please enter your phone number';
                                } else if (!RegExp(r'^\+?\d{10,12}$').hasMatch(value.toString())) {
                                  // isNuberError = true;
                                  //   numberErrorMessage = "Please enter a valid phone number";
                                  // setState(() {
                                  //   height = 85;
                                  //   customPrint("hyyy 85");
                                  // });

                                  return 'Please enter a valid phone number';
                                }
                                // height = 45;
                                return null;
                                // });
                              },
                              controller: phonenumberController,
                              onChanged: (phone) async {
                                phoneNumber(phone.completeNumber);

                                if(prefs.getString(LocalStorage.phoneNumber) == phone.completeNumber){
                                  showSnackbar(context, "Account already exists, please login", colorError);
                                }
                                print(phone.completeNumber);
                                print(phone.completeNumber.length);
                              },
                              style: TextStyle(fontSize: 15),
                              decoration: InputDecoration(
                                // fillColor: Color(0xFFFAFAFA),
                                // filled: true,
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
                          ),
                          // isNuberError?Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22, top: 10), child: Text(numberErrorMessage, style: TextStyle(color: Color(0xffd61e36),fontSize: 12),)):SizedBox(height: 0,),

                        ],
                      ),

                      SizedBox(height: 15.37),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            padding: EdgeInsets.only(left: 12),
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                // decoration: InputDecoration(
                                //   border: InputBorder.none,
                                // ),
                                // validator: (value) {
                                //   if (value == null) {
                                //     return '';
                                //   }
                                //   else{
                                //     isAgeValueValid = true;
                                //   }
                                //   return null;
                                // },
                                // // Initial Value
                                // decoration: InputDecoration(
                                //   border: InputBorder.none,
                                // ),
                                value: ageDropDown,
                                // Down Arrow Icon
                                icon: Align(
                                    child: const Icon(Icons.arrow_drop_down)),
                                // Array list of items
                                items: age.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ageDropDown = newValue!;
                                    _dropdownageController.text = ageDropDown;
                                  });
                                },

                              ),
                            ),
                          ),
                        ],
                      ),
                      // !isAgeValueValid?Text("Error"):Text(""),
                      SizedBox(height: 15.37),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Are You Sexually Active?',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            padding: EdgeInsets.only(left: 12),
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                // decoration: InputDecoration(
                                //   border: InputBorder.none,
                                // ),
                                // validator: (value) {
                                //   if (value == null) {
                                //     return 'Please select a value';
                                //   }
                                //   return null;
                                // },
                                // Initial Value
                                value: dropdownvalue,
                                // Down Arrow Icon
                                icon: Align(
                                    child: const Icon(Icons.arrow_drop_down)),
                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    _dropdownsexualController.text =
                                        dropdownvalue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsets.zero, // equivalent to padding: 0px
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'First Day Of Last Cycle',
                                    style: TextStyle(
                                      fontFamily: 'mulishbold',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.451,
                                      height:
                                      1.14, // equivalent to line-height: 15px
                                      letterSpacing: -0.480392,
                                      color: Color(0xFF374957),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  GestureDetector(
                                    child: Container(
                                        width: double.infinity,
                                        height: 45,
                                        padding: EdgeInsets.only(left: 12),
                                        // padding: EdgeInsets.all(15.3725),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFAFAFA),
                                          borderRadius:
                                          BorderRadius.circular(9.60784),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            pickedDate == null
                                                ? Text("Select", style: TextStyle(
                                                fontSize: 14
                                            ),)
                                                : Text(DateFormat('dd-MM-yyyy')
                                                .format(pickedDate!)),
                                            Icon(Icons.calendar_month,
                                                color: Colors.black26)
                                          ],
                                        )),
                                    onTap: () async {
                                      pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          firstDate.text = formattedDate; //set output date to TextField value.
                                          selectPeriodDate.text = pickedDate.toString(); //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.0, // equivalent to gap: 14px
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                              EdgeInsets.zero, // equivalent to padding: 0px
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Number Of Days In Cycle',
                                    style: TextStyle(
                                      fontFamily: 'mulishbold',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13.451,
                                      height:
                                      1.14, // equivalent to line-height: 15px
                                      letterSpacing: -0.480392,
                                      color: Color(0xFF374957),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    height: 45,
                                    padding: EdgeInsets.only(left: 12),
                                    // padding: EdgeInsets.all(15.3725),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFAFAFA),
                                      borderRadius:
                                      BorderRadius.circular(9.60784),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        // decoration: InputDecoration(
                                        //   border: InputBorder.none,
                                        // ),
                                        // validator: (value) {
                                        //   if (value == null) {
                                        //     return 'Please select a value';
                                        //   }
                                        //   return null;
                                        // },
                                        // Initial Value
                                        value: daysDropDown,
                                        // Down Arrow Icon
                                        icon: Align(
                                            child: const Icon(
                                                Icons.arrow_drop_down)),
                                        // Array list of items
                                        items: numberOfDays.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            daysDropDown = newValue!;
                                            _dropdowncycledaysController.text =
                                                daysDropDown;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // add more children widgets as necessary
                        ],
                      ),
                      SizedBox(height: 15.37),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of Day Period Flow',
                            style: TextStyle(
                              fontFamily: 'mulishbold',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 13.451,
                              height: 1.14, // equivalent to line-height: 15px
                              letterSpacing: -0.480392,
                              color: Color(0xFF374957),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 45,
                            // padding: EdgeInsets.only(left: 12),
                            // padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextField(
                              controller: _periodflowController,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              style: TextStyle(fontSize: 14),
                              decoration: new InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 12),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: '00'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  margin: EdgeInsets.only(left: 0, top: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFDC3D8E), Color(0xFFAC4DBA)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await submitForm();
                      // await displayData();
                      // await signupData();
                      // print('created');
                      // SignupApi.deleteAllItem();
                      // nextPage(context, NavigatorPage());
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text('Submit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have an Account?",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'mulish',
                            color: Colors.black
                        ),

                      ),
                      TextButton(
                        onPressed: () {



                          nextPage(context, LoginPage());
                        },
                        child: const Text(
                          'Login',
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
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signupData(String email, String phoneNumber) async {

    bool valid = validateMyFields(context, [ firstDate, _periodflowController,nameController,phonenumberController], ["First date","Number of day period flow","Name","Phone Number"]);
    if(!valid) {
      return;
      // return;
    }
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString(LocalStorage.phoneNumber) == phoneNumber){
      showSnackbar(context, "Account already exists, please login", colorError);
      return;
    }
    if(isEmailError == true){
      return;
    }
    // if(prefs.getString(LocalStorage.userEmail)==email){
    //   showSnackbar(context, 'User already registered, enter another email', colorError);
    //   return;
    // }
    // else{
    //
    // }
    // if(prefs.getString(LocalStorage.phoneNumber)==phoneNumber){
    //   showSnackbar(context, 'User already registered, enter another phone number', colorError);
    //   return;
    // }
    // else{
    //
    // }
    await prefs.setString(LocalStorage.userName, nameController.text);
    await prefs.setString(LocalStorage.userEmail, emailController.text);
    await prefs.setString(LocalStorage.phoneNumber, phonenumberController.text);
    await prefs.setString(LocalStorage.userAge, ageDropDown);
    // await prefs.setString(LocalStorage.userAge, _dropdownageController.text);
    await prefs.setString(
        LocalStorage.userSexualActivity, dropdownvalue);
    await prefs.setString(LocalStorage.userFirstDay, firstDate.text);
    await prefs.setString(LocalStorage.userDaysInCycle, daysDropDown);
    // await prefs.setString(LocalStorage.userDaysInCycle, _dropdowncycledaysController.text);
    await prefs.setString(LocalStorage.userFlowDuration, _periodflowController.text);
    await prefs.setString(LocalStorage.userSelectedDay, selectPeriodDate.text);

    customPrint("right now before sign up int data:: ${prefs.getString(LocalStorage.userFirstDay)}");
    customPrint("right now before sign up int year:: ${userFirstDayYear}");
    customPrint("right now before sign up int month:: ${userFirstDayMonth}");
    customPrint("right now before sign up int day:: ${userFirstDayDay}");

    customPrint("right now before sign up :: ${int.parse(prefs.getString(LocalStorage.userFirstDay).toString().split("-")[2])}");
    customPrint("right now before sign up :: ${int.parse(prefs.getString(LocalStorage.userFirstDay).toString().split("-")[1])}");
    customPrint("right now before sign up :: ${int.parse(prefs.getString(LocalStorage.userFirstDay).toString().split("-")[0].split(" ")[0])}");

    customPrint("right now before sign up dateTime :: ${DateTime(userFirstDayYear,userFirstDayMonth,userFirstDayDay)}");
    nextPage(context, OTPPage(phoneNumber: phoneNumber));
    // nextPage(context, SplashScreen());
    setState(() {

    });
    print(prefs.getString(LocalStorage.userName));
    print(prefs.getString(LocalStorage.userEmail));
    print(prefs.getString(LocalStorage.phoneNumber));
    print(prefs.getString(LocalStorage.userAge));
    print(prefs.getString(LocalStorage.userAge));
    print(prefs.getString(LocalStorage.userFirstDay));
    print(prefs.getString(LocalStorage.userFirstDay));
    print(prefs.getString(LocalStorage.userFlowDuration));
  }



  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      await signupData(emailController.text, phoneNumber.value);
      // await nextPage(context, OTPPage(phoneNumber: prefs.setString(LocalStorage.phoneNumber, phonenumberController.text).toString()));
    }
  }
  void displayData(){
    print(UserData.periodStartDate);print(UserData.prevDate);
    print(UserData.nextDate);print(UserData.flowDays);
    print(UserData.date);
  }
  String? validateEmail(String? value) {
    const pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    // const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    //     r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    //     r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    //     r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    //     r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    //     r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    //     r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}
