// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
import 'package:scotwallet/model/canclewithdraw_request.dart';
import 'package:scotwallet/model/canclewithdraw_response.dart';
import 'package:scotwallet/model/withdrawrequest_request.dart';
import 'package:scotwallet/model/withdrawrequest_response.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';
import 'package:scotwallet/repository/common_repository.dart';
import 'package:scotwallet/screens/edit_profile.dart';
import 'package:scotwallet/screens/global.dart';
import 'package:scotwallet/utils/custom_progress_dialog.dart';

class WithDrawRequestScreen extends StatefulWidget {
  const WithDrawRequestScreen({Key key}) : super(key: key);

  @override
  _WithDrawRequestScreenState createState() => _WithDrawRequestScreenState();
}

class _WithDrawRequestScreenState extends State<WithDrawRequestScreen> {
  final ProgressDialog _progressDialog = ProgressDialog();
  List<Withdraws> transactionList = List();
  String cancelId = "";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getWithDrawAPI();
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: (){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => EditProfileScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Withdraw Request'),
            backgroundColor: ScotCoinColors.skyBlue,
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => EditProfileScreen()));
                setState(() {});
              },
              child: const Icon(Icons.arrow_back),
            ),
            centerTitle: true,
          ),
          body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    transactionList.isNotEmpty
                        ? Container(
                      margin:const EdgeInsets.only(top: 10, bottom: 10),
                      child: productTaskList(),
                    )
                        : Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width,
                      /* padding: EdgeInsets.only(
                                left:
                                MediaQuery.of(context).size.height * 0.02),*/
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "No Data Available!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1,
                              fontFamily: "Roboto",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ],
                ),
              )
          )),);
  }


  ListView productTaskList() {
    return ListView.builder(
        itemCount: transactionList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int position) {
             var date = Jiffy(transactionList[position].date).format('MMM do yyyy, h:mm:ss a');
          //   String firstLetter = transactionList[position].sender.substring(0,1).toUpperCase();
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
                          elevation: 5,
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
                               Container(
                                 child:  Row(
                                   children: [
                                     Padding(
                                       padding: EdgeInsets.only(left: 10),
                                       child: Column(
                                         crossAxisAlignment:
                                         CrossAxisAlignment.start,
                                         children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.50,
                                            child:  Text(transactionList[position]
                                                .address,
                                              style: TextStyle(fontSize: 16, color: ScotCoinColors.black),),
                                          ),
                                           Container(
                                             padding: EdgeInsets.only(top: 6),
                                             child: Text(
                                               date,
                                               style: TextStyles.trTimeTextStyle(
                                                   context),
                                             ),
                                           )
                                         ],
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                                transactionList[position].withCancelled && !transactionList[position].withComplete
                               ?Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:
                                   BoxDecoration(
                                    borderRadius: new BorderRadius.circular(10.0),
                                       shape: BoxShape.rectangle,
                                       border: Border.all(
                                         color: Colors.blue,
                                         width: 1,
                                       )
                                  ),
                                  child:
                                  Text(
                                  "Withdraw Cancelled",
                                    style: TextStyle(fontSize: 13, color: Colors.blue,fontWeight: FontWeight.bold)
                                  )
                                )
                               : !transactionList[position].withCancelled && transactionList[position].withComplete
                              ?Container(
                                    padding: EdgeInsets.all(10),
                                    decoration:
                                    BoxDecoration(
                                        borderRadius: new BorderRadius.circular(10.0),
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 1,
                                        )
                                    ),
                                    child:
                                    Text(
                                      "Withdraw Completed",
                                        style: TextStyle(fontSize: 13, color: Colors.green,fontWeight: FontWeight.bold)

                                    )
                                )
                                    :InkWell(
                                  onTap: (){
                                    cancelId = transactionList[position].id.toString();
                                    print(cancelId);
                                    cancelWithDrawAPI();
                                    setState(() {});
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration:
                                      BoxDecoration(
                                          borderRadius: new BorderRadius.circular(10.0),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 1,
                                          )
                                      ),
                                      child:
                                      const Text(
                                          "Cancel Withdraw",
                                          style: TextStyle(fontSize: 13, color: Colors.red,fontWeight: FontWeight.bold)
                                      )
                                  )
                                )
                              ],
                            ),
                          )),
                    ],
                  ))));
        });
  }

  void getWithDrawAPI() async {
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    WithDrawRequestRequest getTransactionRequest = WithDrawRequestRequest();
    getTransactionRequest.size = 2000;
    getTransactionRequest.pageNumber = 1;
    getTransactionRequest.keyword = "";
    getTransactionRequest.sortBy = "";
    getTransactionRequest.sortWay = "";

    WithDrawRequestResponse getTransactionResponse =
        await withDrawListRes(getTransactionRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if (getTransactionResponse.map.status == 'success') {
      transactionList = getTransactionResponse.map.withdraws;
      print(transactionList.toString());

      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: getTransactionResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


  void cancelWithDrawAPI() async {
    if (progressDialog == false) {
      progressDialog = true;
      _progressDialog.showProgressDialog(context,
          textToBeDisplayed: 'loading...', dismissAfter: null);
    }

    CancelWithDrawRequest getTransactionRequest = CancelWithDrawRequest();
    getTransactionRequest.id = cancelId;


    CancelWithDrawResponse getTransactionResponse = await cancelWithdrawRes(getTransactionRequest);
    _progressDialog.dismissProgressDialog(context);
    progressDialog = false;

    if (getTransactionResponse.map.status == 'success') {

      getWithDrawAPI();

      Fluttertoast.showToast(
          msg: 'Withdraw cancel successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {});
    } else {
      Fluttertoast.showToast(
          msg: getTransactionResponse.map.status,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ScotCoinColors.skyBlue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }


}
