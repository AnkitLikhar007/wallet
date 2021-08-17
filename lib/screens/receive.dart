// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scotwallet/components/generic_button.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/model/getuserwalletaddress_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';

import 'global.dart';


class ReceiveScreen extends StatefulWidget {
  @override
  _ReceiveScreenState createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  final ProgressDialog _progressDialog = ProgressDialog();
  String address = "";


  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, ()async{
      getWalletAddressAPI();
    });
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Globals.TEXT_RECEIVE),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              setState(() {});
            },
            child: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                    /*    height: MediaQuery.of(context).size.height * 0.19,
                        width:  MediaQuery.of(context).size.width* 0.40,*/
                        child:  QrImage(
                          // backgroundColor:  const Color(0xFFFFFFFF),
                          data: address,
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.height * 0.25,
                          gapless: false,
                          errorStateBuilder: (cxt, err) {
                            return Container(
                              child: const Center(
                                child: Text(
                                  "Something went wrong...",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        )
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Center(
                        child: Text(
                            address,
                         style: TextStyle(fontSize: 17, color: ScotCoinColors.black,fontWeight: FontWeight.bold),
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(Globals.TEXT_RECEIVING_TIPS,
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
                    )),
                /* Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: GenericButton(
                  color: ScotCoinColors.blue,
                  buttonText: Globals.TEXT_RECEIVE,
                  buttonTap: () {},
                ),
              ),*/
              ],
            ),
          ),
        ),
      ),);
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

      address = getUserWalletAddressResponse.map.address;

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


}
