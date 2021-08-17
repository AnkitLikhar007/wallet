// @dart=2.9
import 'dart:async';

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_text_drawable/flutter_text_drawable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scotwallet/components/generic__login_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getbalance_response.dart';
import 'package:scotwallet/model/getuserwalletaddress_response.dart';
import 'package:scotwallet/model/transaction_request.dart';
import 'package:scotwallet/model/transaction_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/authentication_screen.dart';
import 'package:scotwallet/screens/constactus_screen.dart';
import 'package:scotwallet/screens/deposit_screen.dart';
import 'package:scotwallet/screens/edit_profile.dart';
import 'package:scotwallet/screens/faq_screen.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/screens/howitswork_screen.dart';
import 'package:scotwallet/screens/login.dart';
import 'package:scotwallet/screens/other_wallet_screen.dart';
import 'package:scotwallet/screens/receive.dart';
import 'package:scotwallet/screens/scannpay_screen.dart';
import 'package:scotwallet/screens/send_scot_coin.dart';
import 'package:scotwallet/screens/withdraw.dart';
import 'package:scotwallet/utils/app_constants.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';
import 'package:scotwallet/utils/shdf.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ProgressDialog _progressDialog = ProgressDialog();
  String balanceAmount = "";
  String emailId = "";
  List<Transactions> transactionList = List();
  String itemCount = "";
  Timer _clockTimer;
  String address = "";
  String userAddress = "";

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, ()async{
      emailId = await SHDFClass.readSharedPrefString(AppConstants.EmailId, "");
      userAddress = await SHDFClass.readSharedPrefString(AppConstants.UserAddress, "");
      print("User address : $userAddress");
      getWalletAddressAPI();
      getBalanaceAPI();
    });

    _clockTimer =  Timer.periodic(const Duration(seconds: 2), (_){
      getTransactionAPI();
    });
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _clockTimer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: DoubleBackToCloseApp(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child:Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(
                  children: [
                    Container(
                      color: ScotCoinColors.blue,
                      height: MediaQuery.of(context).size.height *0.26,
                    ),
                    Positioned(
                      child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      top: 40,
                      left: 20,
                    ),
                    /*Positioned(
                      child: GenericLoginButton(
                        icon: Icons.account_circle,
                        buttonText: Globals.TEXT_LOGIN,
                        buttonTap: () {
                        },
                        color: Color(0XFF12b1e6),
                      ),
                      top: 40,
                      right: 20,
                    ),*/
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.height * 0.14, 0, 0),
                        child: Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.02,
                              right: MediaQuery.of(context).size.height * 0.02),
                          child: Card(
                            elevation:10,
                            //color: const Color(0XFFf0f3f4),
                            color: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                  bottomRight: Radius.circular(7),
                                  topRight: Radius.circular(7)),

                            ),

                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                        child:   Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.40,
                                                  child: Text(Globals.TEXT_TOTAL_BALANCE),
                                                ),
                                                Container(
                                                    width: MediaQuery.of(context).size.width * 0.40,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.only(top: 5),
                                                            child:  Text(
                                                                balanceAmount,
                                                                style: const TextStyle(fontSize: 22, color: ScotCoinColors.black,fontWeight: FontWeight.bold)
                                                            )),
                                                        Container(
                                                            padding:const EdgeInsets.only(top: 6, left: 2),
                                                            child: const Text(
                                                                "SCOT",
                                                                style: TextStyle(fontSize: 15, color: ScotCoinColors.black,fontWeight: FontWeight.w400)
                                                            )),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                            Image.asset(
                                              'images/logo.png',
                                              height: 45,
                                              width: 45,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child:  InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  SendScotCoin()));
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: Color(0XFF9800d9),
                                                    child: Icon(
                                                      Icons.file_upload,
                                                      color: ScotCoinColors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.only(top: 5),
                                                      child: Text(
                                                        "Send",
                                                        style:
                                                        TextStyle(fontSize: 12, color: ScotCoinColors.black)
                                                      ))
                                                ],
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child:  InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ScanNPayScreen()));
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: ScotCoinColors.skyBlue,
                                                    child: Icon(
                                                      Icons.qr_code_scanner,
                                                      color: ScotCoinColors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.only(top: 5),
                                                      child: const Text(
                                                        "Scan N Pay",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 12, color: ScotCoinColors.black)
                                                      ))
                                                ],
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  ReceiveScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: Color(0XFFfab500),
                                                    child: Icon(
                                                      Icons.file_download,
                                                      color: ScotCoinColors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5),
                                                      child: Text(
                                                        "Receive",
                                                        style:
                                                        TextStyle(fontSize: 12, color: ScotCoinColors.black)
                                                      ))
                                                ],
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const OtherWalletScreen()));
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor: Color(0XFF00b5eb),
                                                    child: Icon(
                                                      Icons.file_upload,
                                                      color: ScotCoinColors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5),
                                                      child: Text(
                                                        "Deposit",
                                                        style:
                                                        TextStyle(fontSize: 12, color: ScotCoinColors.black)
                                                      ))
                                                ],
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  Withdraw()));
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 22,
                                                    backgroundColor:
                                                    Color(0XFFdf90fa),
                                                    child: Icon(
                                                      Icons.file_download,
                                                      color: ScotCoinColors.white,
                                                      size: 22,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(top: 5),
                                                      child: Text(
                                                        "Withdraw",
                                                        style:
                                                        TextStyle(fontSize: 12, color: ScotCoinColors.black)
                                                      ))
                                                ],
                                              ),
                                            )
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
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transactions",
                        style: TextStyles.headlineBoldTextStyle(context),
                      ),
                      InkWell(
                        onTap: (){
                          itemCount = '1';
                          setState(() {});
                        },
                        child:  Text(
                          "View All",
                          style: TextStyle(color: ScotCoinColors.blue, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: productTaskList()
                )
              ]),
            )
          // Text("abc")
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
      drawer: Drawer(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                // color: const Color(0xffffd700),
                child: Column(children: <Widget>[

                  Container(
                    height: MediaQuery.of(context).size.height * 0.12,
                    color: ScotCoinColors.skyBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left:
                              MediaQuery.of(context).size.height * 0.03,
                          top: MediaQuery.of(context).size.height * 0.03),
                          child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Profile",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: 1,
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.white24,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> EditProfileScreen()));
                        setState(() {});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *0.45,
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.03,
                                      top: MediaQuery.of(context).size.height * 0.02,
                                      bottom: MediaQuery.of(context).size.height * 0.01),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right:
                                            MediaQuery.of(context).size.height * 0.0),
                                        child: const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "User Name",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                height: 1,
                                                fontFamily: "Roboto",
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 17,
                                              ),
                                            )),
                                      ),
                                    ],
                                  )),
                              Container(
                                  width: MediaQuery.of(context).size.width *0.45,
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height * 0.03,
                                      top: MediaQuery.of(context).size.height * 0.00,
                                      bottom: MediaQuery.of(context).size.height * 0.02),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right:
                                            MediaQuery.of(context).size.height * 0.0),
                                        child:  Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              userAddress,
                                              textAlign: TextAlign.left,
                                              style:const TextStyle(
                                                height: 1,
                                                fontFamily: "Roboto",
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ))
                            ],
                          ),

                          Container(
                              padding: EdgeInsets.only(
                                  right: MediaQuery.of(context).size.height * 0.06,
                                  top: MediaQuery.of(context).size.height * 0.02,
                                  bottom: MediaQuery.of(context).size.height * 0.02),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(
                                        right:
                                        MediaQuery.of(context).size.height * 0.0),
                                    child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Edit Profile",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            height: 1,
                                            fontFamily: "Roboto",
                                            color: ScotCoinColors.skyBlue,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        )),
                                  ),
                                ],
                              ))
                        ],
                      )),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

               /*   Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black38,
                  ),*/
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AuthenticationScreen()));
                        setState(() {});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.03,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                    MediaQuery.of(context).size.height * 0.0),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Authentication",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            ],
                          ))),

                 /* Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black38,
                  ),*/
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HowItsWork()));
                        setState(() {});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.03,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                    MediaQuery.of(context).size.height * 0.0),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "How it works",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            ],
                          ))),

                 /* Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black38,
                  ),*/
                  InkWell(
                      onTap: () {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const FAQScreen()));
                        setState(() {});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.03,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                    MediaQuery.of(context).size.height * 0.0),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "FAQ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            ],
                          ))),
                 /* Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black38,
                  ),*/

                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ContactUsScreen()));
                        setState(() {});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.03,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                    MediaQuery.of(context).size.height * 0.0),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Contact Us",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            ],
                          ))),


                  InkWell(
                      onTap: () {
                        _scaffoldKey.currentState.openEndDrawer();
                        _ShowlogoutDialog(context);
                        setState(() {});
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.03,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom: MediaQuery.of(context).size.height * 0.02),
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    right:
                                    MediaQuery.of(context).size.height * 0.0),
                                child: const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Logout",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontFamily: "Roboto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 17,
                                      ),
                                    )),
                              ),
                            ],
                          ))),
                 /* Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.001,
                    color: Colors.black38,
                  ),*/


                ]),
              ),

            ],
          )
      ),
    );
  }


  ListView productTaskList() {
    return ListView.builder(
        itemCount: itemCount == ""?7:transactionList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
          var date = Jiffy(transactionList[position].creationDate).format('MMM do yyyy, h:mm:ss a');
          String firstLetter = "";
          if(userAddress == transactionList[position].sender){
             firstLetter = transactionList[position].receiver.substring(0,1).toUpperCase();
          }else{
             firstLetter = transactionList[position].sender.substring(0,1).toUpperCase();
          }

          return AnimationConfiguration.staggeredList(
              position: position,
              duration: const Duration(milliseconds: 1000),
              child: SlideAnimation(
                  verticalOffset: 300,
                  child: FadeInAnimation(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Card(
                              elevation:7,
                              //color: const Color(0XFFf0f3f4),
                              color: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7),
                                    bottomLeft: Radius.circular(7),
                                    bottomRight: Radius.circular(7),
                                    topRight: Radius.circular(7)),

                              ),

                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                                child: TextDrawable(
                                                  boxShape: BoxShape.rectangle,
                                                  text: firstLetter,
                                                ))),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(userAddress == transactionList[position].sender
                                                ?transactionList[position].receiver
                                                :transactionList[position].sender,
                                                style: TextStyle(fontSize: 16, color: ScotCoinColors.black,fontWeight: FontWeight.w400),),
                                             Container(
                                               padding: EdgeInsets.only(top: 5),
                                               child:  Text(
                                                 date,
                                                 style: TextStyles.trTimeTextStyle(context),
                                               ),
                                             )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      userAddress == transactionList[position].sender
                                      ?"-"+transactionList[position].amount.toString()
                                        :"+"+transactionList[position].amount.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: userAddress == transactionList[position].sender
                                          ?ScotCoinColors.red
                                          :ScotCoinColors.green,
                                          fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              )),
                        ],
                      )
                  )
              )
          );
        });
  }


  void getBalanaceAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }


    GetBalanceResponse getBalanceResponse = await getBalanaceRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(getBalanceResponse.map.status == 'success'){

      balanceAmount = getBalanceResponse.map.amount.toString();
      print("Balance Amount : $balanceAmount ");

      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: getBalanceResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }



  void getTransactionAPI()async{
    userAddress = await SHDFClass.readSharedPrefString(AppConstants.UserAddress, "");
    print("User address : $userAddress");
  /*  if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }*/

    GetTransactionRequest getTransactionRequest = GetTransactionRequest();
    getTransactionRequest.size = 2000;
    getTransactionRequest.pageNumber = 1;
    getTransactionRequest.keyword = "";
    getTransactionRequest.sortBy = "";
    getTransactionRequest.sortWay = "";


    GetTransactionResponse getTransactionResponse = await transactionRes(getTransactionRequest);
    /*_progressDialog.dismissProgressDialog(context);
    progressDialog = false;*/

    if(getTransactionResponse.map.status == 'success'){
      transactionList = getTransactionResponse.map.transactions;
      print(transactionList.toString());

      if (mounted) {
        setState(() {
        });
      }

    }else{
      Fluttertoast.showToast(
          msg: getTransactionResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  void getWalletAddressAPI()async{
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }


    GetUserWalletAddressResponse getUserWalletAddressResponse = await getUserWalletAddressRes();
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if(getUserWalletAddressResponse.map.status == 'success'){

      String address = getUserWalletAddressResponse.map.address;
      SHDFClass.saveSharedPrefValueString(AppConstants.UserAddress, address);
      print("User address : $address");

      setState(() {});

    }else{
      Fluttertoast.showToast(
          msg: getUserWalletAddressResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }


  //VALIDATION DIALOG
  _ShowlogoutDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildCodeChild(context),
          );
        });
  }

  //CUSTOM VALIDATION DIALOG CODE
  _buildCodeChild(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        //color: Color(0xffffd700),
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.00),
                child: const Text(
                  "Logout!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    18,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: const Text(
                  "Sure you want to logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                    16,
                    fontFamily: 'DidactGothic',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: ScotCoinColors.skyBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'No',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'DidactGothic',
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()async{
                      SHDFClass.saveSharedPrefValueString(AppConstants.EmailId, "");
                      SHDFClass.saveSharedPrefValueString(AppConstants.UserId, "");
                      SHDFClass.saveSharedPrefValueString(AppConstants.UserAddress, "");
                      SHDFClass.saveSharedPrefValueString(AppConstants.Token, "");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        bottom: MediaQuery.of(context).size.height * 0.01,),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.00,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.01,
                          MediaQuery.of(context).size.height * 0.03),
                      decoration: const BoxDecoration(
                        color: ScotCoinColors.skyBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        'Yes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'DidactGothic',
                          color: Colors.white,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )
  );


}
