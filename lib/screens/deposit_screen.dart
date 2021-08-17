// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/screens/other_wallet_screen.dart';


class DepositScreen extends StatefulWidget {
  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deposit'),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  HomeScreen()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
           actions: [
              InkWell(
                onTap: (){
                 // scanQR();
                  setState(() {});
                },
                child:   Container(
                  margin: EdgeInsets.only(right: 14),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: Image.asset('images/barcode_icon.png',),
                ),
              )
            ],

          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                child: Card(
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
                  child:  Container(
                    width: MediaQuery.of(context).size.width,

                    decoration:const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0XFF9c3eff), Color(0XFF2cbbe9)],
                          begin:  FractionalOffset(0.0, 0.0),
                          end:  FractionalOffset(0.7, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp
                      ),
                    ),
                    child:Container(
                        padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            Globals.TEXT_META_WALLET,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1,
                                fontFamily: "SEGOEUI",
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 17),
                          ),
                        )),

                    /* GenericButton(
                color: ScotCoinColors.blue,
                buttonText: Globals.TEXT_META_WALLET,
                buttonTap: onMeta,
              ),*/
                  ),
                ),
              ),
              Center(child: Text(Globals.TEXT_OR,
                style: TextStyle(
                    height: 1,
                    fontFamily: "SEGOEUI",
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),)),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const OtherWalletScreen()));
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Card(
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
                    child:  Container(
                      width: MediaQuery.of(context).size.width,

                      decoration:const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0XFF0975f2), Color(0XFF54e1ff)],
                            begin:  FractionalOffset(0.0, 0.0),
                            end:  FractionalOffset(0.7, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp
                        ),
                      ),
                      child:Container(
                          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              Globals.TEXT_OTHER_WALLET,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1,
                                  fontFamily: "SEGOEUI",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17),
                            ),
                          )),

                      /* GenericButton(
                color: ScotCoinColors.blue,
                buttonText: Globals.TEXT_META_WALLET,
                buttonTap: onMeta,
              ),*/
                    ),
                  ),
                ),
              ),
              /* Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 60),
              child: GenericButton(
                color: ScotCoinColors.blue,
                buttonText: Globals.TEXT_OTHER_WALLET,
                buttonTap: onMeta,
              ),
            ),*/


              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(Globals.TEXT_DEPOSIT_TIPS,
                              style: TextStyles.headlineTextStyle(context)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text(
                            Globals.TIP1,
                            style: TextStyles.tipsTextStyle(context),
                          ),
                        ),
                        Text(
                          Globals.TIP2,
                          style: TextStyles.tipsTextStyle(context),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Text(
                              Globals.TIP3,
                              style: TextStyles.tipsTextStyle(context),
                            )),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ), );
  }

  void onMeta() {
    /*showDialog(
      context: context,
      builder: (context) => GenericAlert(message: "Transfer"),
    );*/

  }
}
