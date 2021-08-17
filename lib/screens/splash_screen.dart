// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/screens/login.dart';
import 'package:scotwallet/utils/app_constants.dart';
import 'package:scotwallet/utils/shdf.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String emailId = "";

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
          emailId = await SHDFClass.readSharedPrefString(AppConstants.EmailId, "");
      if(emailId == null||emailId == ""){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProductOrderScreen()));
      }
    });
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    /*height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.25,*/
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fill,
                      scale: 2,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        //height: MediaQuery.of(context).size.height *0.06,
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02,),
                        child: const Text(
                          "SCOTCOIN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize:
                            40,
                            fontFamily: 'DidactGothic',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w900,
                            color: ScotCoinColors.skyBlue,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.02,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: const Text(
                          "WALLET",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize:
                            40,
                            fontFamily: 'DidactGothic',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w900,
                            color: ScotCoinColors.skyBlue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
