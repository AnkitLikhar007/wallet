// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'home_screen.dart';

class HowItsWork extends StatefulWidget {
  const HowItsWork({Key key}) : super(key: key);

  @override
  _HowItsWorkState createState() => _HowItsWorkState();
}

class _HowItsWorkState extends State<HowItsWork> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      setState(() {});
      return;
    },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("How it works"),
          backgroundColor: ScotCoinColors.skyBlue,
           leading: InkWell(
             onTap: (){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
               setState(() {});
             },
             child:const Icon(Icons.arrow_back),
           ),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SfPdfViewer.asset(
                    'images/how_its_work.pdf',
                  ),
                ],
              ),
            )
        ),
      ),);
  }
}
