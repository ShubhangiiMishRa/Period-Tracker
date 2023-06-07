import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nexus/api/local_storage.dart';
import 'package:nexus/screens/my_profile.dart';
import 'package:nexus/util/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../Authentication/verification_page.dart';
import '../globalVariable.dart';
import '../main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstDateEdit = TextEditingController();
  TextEditingController nameControllerEdit = TextEditingController();
  TextEditingController emailControllerEdit = TextEditingController();
  TextEditingController phonenumberControllerEdit = TextEditingController();
  TextEditingController _dropdownageControllerEdit = TextEditingController();
  TextEditingController _dropdownsexualControllerEdit = TextEditingController();
  TextEditingController _dropdowncycledaysControllerEdit =
      TextEditingController();
  TextEditingController _periodflowControllerEdit = TextEditingController();
  // Initial Selected Value
  DateTime? pickedDate;
  String dropdownvalue = "";
  String ageDropDown = "";
  String daysDropDown = "";
  List<String> _previousValues = [];
  @override
  void initState() {
    firstDateEdit =
        TextEditingController(text: prefs.getString(LocalStorage.userFirstDay));
    nameControllerEdit =
        TextEditingController(text: prefs.getString(LocalStorage.userName));
    emailControllerEdit =
        TextEditingController(text: prefs.getString(LocalStorage.userEmail));
    phonenumberControllerEdit =
        TextEditingController(text: prefs.getString(LocalStorage.phoneNumber));
    _dropdownageControllerEdit =
        TextEditingController(text: prefs.getString(LocalStorage.userAge));
    _dropdownsexualControllerEdit = TextEditingController(
        text: prefs.getString(LocalStorage.userSexualActivity));
    _dropdowncycledaysControllerEdit = TextEditingController(
        text: prefs.getString(LocalStorage.userDaysInCycle));
    _periodflowControllerEdit = TextEditingController(
        text: prefs.getString(LocalStorage.userFlowDuration));

    dropdownvalue = prefs.getString(LocalStorage.userSexualActivity) ?? "";
    ageDropDown = prefs.getString(LocalStorage.userAge) ?? "";
    daysDropDown = prefs.getString(LocalStorage.userDaysInCycle) ?? "";
    // TODO: implement initState
    super.initState();
  }

  // List of items in our dropdown menu
  var items = [
    'Yes',
    'No',
  ];
  List<String> age = [for (int i = 12; i < 61; i++) i.toString()];
  List<String> numberOfDays = [for (int i = 20; i < 60; i++) i.toString()];
  late DateTime _chosenDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            nextPage(context, MyProfile());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF0F2F5B),
          ),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            height: 1.33,
            color: Color(0xFF0F2F5B),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 15, left: 16),
            child: ListView(
              children: [
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
                            width: MediaQuery.of(context).size.width,
                            height: 48.04,
                            padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextFormField(
                              // initialValue: prefs.getString(LocalStorage.userName)??"Name",
                              controller: nameControllerEdit,
                              style: TextStyle(fontSize: 15),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Enter your name';
                                else if (!RegExp(r'^[a-zA-Z ]+$')
                                    .hasMatch(value))
                                  return "Enter a valid name";
                                else
                                  return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z ]+$')),
                              ],
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //suffixIcon: Image.asset('icons/otp.png'),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: 'Enter Full Name'),
                            ),
                          ),
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
                            width: MediaQuery.of(context).size.width,
                            height: 48.04,
                            padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextFormField(
                              enabled: false,
                              controller: emailControllerEdit,
                              validator: validateEmail,
                              style: TextStyle(fontSize: 15),
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r"\s")), // Deny whitespace
                                LengthLimitingTextInputFormatter(
                                    100), // Limit the length of the input to 100 characters
                                // EmailInputFormatter(), // Validate the input as an email address
                              ],
                              decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  //suffixIcon: Image.asset('icons/otp.png'),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: 'Enter Email'),
                            ),
                          ),
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
                          IntlPhoneField(
                            enabled: false,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'Please enter your phone number';
                              } else if (!RegExp(r'^\+?\d{10,12}$')
                                  .hasMatch(value.toString())) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                            controller: phonenumberControllerEdit,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              fillColor: Color(0xFFFAFAFA),
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
                          // IntlPhoneField(
                          //   controller: phonenumberController,
                          //   style: TextStyle(fontSize: 15),
                          //   decoration: InputDecoration(
                          //     // border: OutlineInputBorder(),
                          //     helperText: "",
                          //     border: InputBorder.none,
                          //     focusedBorder: InputBorder.none,
                          //     enabledBorder: InputBorder.none,
                          //     errorText: null,
                          //     errorBorder: InputBorder.none,
                          //     disabledBorder: InputBorder.none,
                          //     counterText: "",
                          //     contentPadding:
                          //         EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          //     hintText: 'Enter Mobile Number',
                          //     // labelText: 'Enter Mobile Number',
                          //   ),
                          //   initialCountryCode: 'IN',
                          //   autovalidateMode: AutovalidateMode.disabled,
                          //   // onChanged: (phone) {
                          //   //   print(phone.completeNumber);
                          //   // },
                          // ),
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
                            width: MediaQuery.of(context).size.width,
                            height: 48.04,
                            padding: EdgeInsets.all(15.3725),
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
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ageDropDown = newValue!;
                                    _dropdownageControllerEdit.text =
                                        ageDropDown;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            width: MediaQuery.of(context).size.width,
                            height: 48.04,
                            padding: EdgeInsets.all(15.3725),
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
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    _dropdownsexualControllerEdit.text =
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 48.04,
                                        padding: EdgeInsets.all(15.3725),
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
                                                ? Text(prefs
                                                    .getString(LocalStorage
                                                        .userFirstDay)
                                                    .toString())
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
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate!);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          firstDateEdit.text =
                                              formattedDate; //set output date to TextField value.
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
                                    width: 343,
                                    height: 48.04,
                                    padding: EdgeInsets.all(15.3725),
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
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }).toList(),
                                        // After selecting the desired option,it will
                                        // change button value to selected value
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            daysDropDown = newValue!;
                                            _dropdowncycledaysControllerEdit
                                                .text = daysDropDown;
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
                            width: MediaQuery.of(context).size.width,
                            height: 48.04,
                            padding: EdgeInsets.all(15.3725),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(9.60784),
                            ),
                            child: TextField(
                              controller: _periodflowControllerEdit,
                              keyboardType: TextInputType.number,
                              maxLength: 2,
                              style: TextStyle(fontSize: 15),
                              decoration: new InputDecoration(
                                  counterText: "",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  //hintText: 'Enter Mobile Number'
                                  hintText: '00'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
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
                    onPressed: () {
                      // EditData();
                      _saveMyValue();
                      // nextPage(context, MyProfile());
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Text('Save'),
                  ),
                ),
                // Container(
                //   width: 344,
                //   height: 420.12,
                //   padding: EdgeInsets.zero,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(0),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.withOpacity(0.2),
                //         spreadRadius: 0,
                //         blurRadius: 10,
                //         offset: Offset(0, 10),
                //       ),
                //     ],
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: 71.73,
                //         padding: EdgeInsets.all(0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9.60784),
                //           color: Color(0xFFFAFAFA),
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Mobile Number',
                //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'mulish'),
                //             ),
                //             SizedBox(height: 5),
                //             Container(
                //               width: MediaQuery.of(context).size.width,
                //               height: 48.04,
                //               padding: EdgeInsets.symmetric(horizontal: 15.3725),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(9.60784),
                //               ),
                //               child: TextField(),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         height: 15,
                //       ),
                //       Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: 71.73,
                //         padding: EdgeInsets.all(0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9.60784),
                //           color: Color(0xFFFAFAFA),
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'OTP',
                //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'mulish'),
                //             ),
                //             SizedBox(height: 5),
                //             Container(
                //               width: MediaQuery.of(context).size.width,
                //               height: 48.04,
                //               padding: EdgeInsets.symmetric(horizontal: 15.3725),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(9.60784),
                //               ),
                //               child: TextField(),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         height: 27.18,
                //       ),
                //       Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: 71.73,
                //         padding: EdgeInsets.all(0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9.60784),
                //           color: Color(0xFFFAFAFA),
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Mobile Number',
                //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'mulish'),
                //             ),
                //             SizedBox(height: 5),
                //             Container(
                //               width: MediaQuery.of(context).size.width,
                //               height: 48.04,
                //               padding: EdgeInsets.symmetric(horizontal: 15.3725),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(9.60784),
                //               ),
                //               child: TextField(),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         height: 15,
                //       ),
                //       Container(
                //         width: MediaQuery.of(context).size.width,
                //         height: 71.73,
                //         padding: EdgeInsets.all(0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(9.60784),
                //           color: Color(0xFFFAFAFA),
                //         ),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'OTP',
                //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'mulish'),
                //             ),
                //             SizedBox(height: 5),
                //             Container(
                //               width: MediaQuery.of(context).size.width,
                //               height: 48.04,
                //               padding: EdgeInsets.symmetric(horizontal: 15.3725),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(9.60784),
                //               ),
                //               child: TextField(),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(
                //         height: 27.18,
                //       ),
                //
                //   ]
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  _loadMyValue() async {
    setState(() {
      _previousValues = [
        prefs.getString(LocalStorage.userName) ?? "NA",
        prefs.getString(LocalStorage.userEmail) ?? "email",
        prefs.getString(LocalStorage.phoneNumber) ?? "number",
        prefs.getString(LocalStorage.userAge) ?? "age",
        prefs.getString(LocalStorage.userSexualActivity) ?? "",
        prefs.getString(LocalStorage.userFirstDay) ?? "",
        prefs.getString(LocalStorage.userFirstDay) ?? "",
        prefs.getString(LocalStorage.userFlowDuration) ?? ""
      ];
    });
  }

  _saveMyValue() async {
    await prefs.setString(
        LocalStorage.userName, nameControllerEdit.text);
    await prefs.setString(
        LocalStorage.userEmail, emailControllerEdit.text);
    await prefs.setString(
        LocalStorage.phoneNumber, phonenumberControllerEdit.text);
    await prefs.setString(
        LocalStorage.userAge, _dropdownageControllerEdit.text);
    await prefs.setString(
        LocalStorage.userSexualActivity, _dropdownsexualControllerEdit.text);
    await prefs.setString(LocalStorage.userFirstDay, firstDateEdit.text);
    await prefs.setString(
        LocalStorage.userDaysInCycle, _dropdowncycledaysControllerEdit.text);
    await prefs.setString(
        LocalStorage.userFlowDuration, _periodflowControllerEdit.text);
    setState((){
    });
    showSnackbar(context, 'Changes are saved!', colorSuccess,800);
    print("After edit :: ${prefs.getString(LocalStorage.userName)}");
    print(prefs.getString(LocalStorage.userEmail));
    print(prefs.getString(LocalStorage.phoneNumber));
    print(prefs.getString(LocalStorage.userAge));
    print(prefs.getString(LocalStorage.userAge));
    print(prefs.getString(LocalStorage.userFirstDay));
    print(prefs.getString(LocalStorage.userFirstDay));
    print(prefs.getString(LocalStorage.userFlowDuration));
    Timer(Duration(seconds: 1), () async{await nextPage(context, MyProfile()); });
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}
