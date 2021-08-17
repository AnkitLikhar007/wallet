// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/screens/home_screen.dart';
import 'package:scotwallet/screens/login.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  String que1 = "";
  String que2 = "";
  String que3 = "";
  String que4 = "";
  String que5 = "";
  String que6 = "";


  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      setState(() {});
      return;
    },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FAQ'),
          backgroundColor: ScotCoinColors.skyBlue,
          leading: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
              setState(() {});
            },
            child: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             InkWell(
               onTap: (){
                 if(que1 == ""){
                   que1 = "1";
                   que2 = "";
                   que3 = "";
                   que4 = "";
                   que5 = "";
                   que6 = "";
                 }else{
                   que1 = "";
                 }
                 setState(() {});
               },
               child:  Container(
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

                     child: Padding(
                       padding: EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [

                           Container(
                               width: MediaQuery.of(context).size.width * 0.80,
                               child: const Text(
                                   '1) How to withdraw funds back to my layer 1 wallet?',
                                   style: TextStyle(
                                       fontSize: 16,
                                       color:ScotCoinColors.blue,
                                       fontWeight: FontWeight.w500)
                               )
                           )
                         ],
                       ),
                     )),
               ),
             ),
               que1 == "1"
               ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                        'To withdraw funds into a layer 1 wallet you first click on Withdraw. You do need your layer 1 wallet address in the box which says Ethereum wallet address that starts with 0x. Put the amount you wish to withdraw and click withdraw. This will take the same time as any other layer 1 transaction and will incur a cost for gas. Here is a useful link to see what Gas prices are currently at and you can choose the best time to transfer when it is cheaper https://etherscan.io/gastrackerAny other questions then email info@scotcoinproject.comor Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                   :Container(),

                InkWell(
                  onTap: (){
                    if(que2 == ""){
                      que2 = "1";
                      que1 = "";
                      que3 = "";
                      que4 = "";
                      que5 = "";
                      que6 = "";

                    }else{
                      que2 = "";
                    }
                    setState(() {});
                  },
                  child:  Container(
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

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: const Text(
                                      '2) How much does it cost to deposit funds into your ScotWallet?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:ScotCoinColors.blue,
                                          fontWeight: FontWeight.w500)
                                  )
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                que2 == "1"
                    ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'When depositing funds from your Ethereum wallet on layer 1 such as Metamask, into the Scot wallet on layer 2 scotwallet.com, a box pops up asking you to confirm the transfer and it will tell you how much it will cost you x amount of Ethereum aka Gas price which is the cost for the mining pool to pick up and authorize your transaction on the Ethereum network then deposit the funds into your wallet balance.Here is a useful link to see what Gas prices are currently at and you can choose the best time to transfer when it is cheaper https://etherscan.io/gastrackerAny other questions then email info@scotcoinproject.com or Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                    :Container(),


                InkWell(
                  onTap: (){
                    if(que3 == ""){
                      que3 = "1";
                      que1 = "";
                      que2 = "";
                      que4 = "";
                      que5 = "";
                      que6 = "";
                    }else{
                      que3 = "";
                    }
                    setState(() {});
                  },
                  child:  Container(
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

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: const Text(
                                      '3) How much does it cost to send from wallet to wallet on ScotWallet(Layer 2)?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:ScotCoinColors.blue,
                                          fontWeight: FontWeight.w500)
                                  )
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                que3 == "1"
                    ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'Zero. It is absolutely free !!\nAny other questions then email info@scotcoinproject.com or Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                    :Container(),


                InkWell(
                  onTap: (){
                    if(que4 == ""){
                      que4 = "1";
                      que1 = "";
                      que2 = "";
                      que3 = "";
                      que5 = "";
                      que6 = "";
                    }else{
                      que4 = "";
                    }
                    setState(() {});
                  },
                  child:  Container(
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

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: const Text(
                                      '4) What if I forget my password?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:ScotCoinColors.blue,
                                          fontWeight: FontWeight.w500)
                                  )
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                que4 == "1"
                    ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'Click on the Forgot password link at the Scotwallet login screen. Enter your registered email address. You will receive an email to the registered email address with the password reset link. Click the link and reset the password.You will now be able to login to your Scotwallet account with your new password.Any other questions then email info@scotcoinproject.com or Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                    :Container(),


                InkWell(
                  onTap: (){
                    if(que5 == ""){
                      que5 = "1";
                      que1 = "";
                      que2 = "";
                      que3 = "";
                      que4 = "";
                      que6 = "";
                    }else{
                      que5 = "";
                    }
                    setState(() {});
                  },
                  child:  Container(
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

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: const Text(
                                      '5) What is the Layer 1 and Layer 2 you mention in your user guide?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:ScotCoinColors.blue,
                                          fontWeight: FontWeight.w500)
                                  )
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                que5 == "1"
                    ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'Layer 1 is your Ethereum wallet on Metamask with the address that starts with 0x, which sits on the Ethereum Mainnet blockchain. Any movement of tokens from this wallet to the new scotwallet.com platform costs the normal gas prices at that specific time.\n NOTE - There must be Ethereum and Scotcoin in the wallet to be able to send to the layer 2 Scot Wallet.\n When depositing funds from your Ethereum wallet to the Scot wallet, a box pops up asking you to confirm the transfer and it will tell you how much it will cost you. Here is a useful link to see what Gas prices are currently at and you can choose the best time to transfer when it is cheaper https://etherscan.io/gastracker\n Layer 2 is the Scot Wallet platform on scotwallet.com and when you transfer funds from a wallet on Scot Wallet to another wallet on Scot Wallet the cost is free !!!\n There are obvious benefits to this for a business. They can store multiple payment transactions in their balance for as long as they wish and then when they choose to withdraw they can pull funds out of the Scot Wallet back into their Scotcoin wallet on The Ethereum Mainnet and once Scotcoin are listed on an exchange in a few months time they can exchange Scotcoin for fiat currencies such as Pound Sterling, Euros and US Dollars.\n Any other questions then email info@scotcoinproject.com or Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                    :Container(),


                InkWell(
                  onTap: (){
                    if(que6 == ""){
                      que6 = "1";
                      que1 = "";
                      que2 = "";
                      que3 = "";
                      que4 = "";
                      que5 = "";
                    }else{
                      que6 = "";
                    }
                    setState(() {});
                  },
                  child:  Container(
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

                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: const Text(
                                      '6) What is Ethereum Mainnet and how does it work?',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:ScotCoinColors.blue,
                                          fontWeight: FontWeight.w500)
                                  )
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                que6 == "1"
                    ? Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: const Text(
                      'Ethereum runs on what is called the Mainnet. Like most cryptocurrencies it involves mining. This process called mining is a procedure for solving complex mathematical calculations. Miners are essential on any kind of cryptocurrency network.\n   Miners use their processing time and computing power to resolve those mathematical calculations, providing a so-called ‘proof of work’ for the network, which authorizes Ethereum transactions. Once these transactions are approved the amount of Ethereum or ERC20 token is received into the receiving wallet and the same amount is removed from the balance of the sender’s wallet.\n Any other questions then email info@scotcoinproject.com or Visit our Telegram channel on https://t.me/scotcoin',
                        style: TextStyle(
                            fontSize: 16,
                            color:ScotCoinColors.black,
                            fontWeight: FontWeight.w400)
                    )
                )
                    :Container(),





              ],
            ),
          ),
        ),
      ),);
  }
}
