import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exchange/src/resources/fontsclass.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:async';
import 'dart:typed_data';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SellPage(),
    );
  }
}

class SellPage extends StatefulWidget {
  SellPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  var myController = TextEditingController(text: "");
  var recieverIDController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  var deviceHeight;
  var deviceWidth;

  var companyName = "SMJ Solutions";
  var companyAddress =
      "No. 39, Second Floor, Suite # 623, NGEF Lane, Indiranagar 1st Stage, Bangalore Bangalore KA 560038 IN";

  var gold999WalletBalance = 50.50;
  // var gold999WalletBalance = 0.0;
  var gold999CurrentPrice = 4024.59;

  var gold916WalletBalance = 20.75;
  // var gold916WalletBalance = 0.0;
  var gold916CurrentPrice = 3696.44;

  var silverWalletPrice = 200.00;
  // var silverWalletPrice = 0.0;
  var silverCurrentPrice = 49.39;

  double currenrLivePrice = 0.0;
  double currentLiveWallet = 0.0;

  var button916Colour = Colors.white;
  var button999Colour = Colors.white;
  var buttonSilverColour = Colors.white;

  var textColour916 = Colors.black;
  var textColour999 = Colors.black;
  var textColourSilver = Colors.black;

  DateTime alert;
  bool expired;

  void button22k() {
    setState(() {
      button916Colour = Colors.blue;
      textColour916 = Colors.white;

      button999Colour = Colors.white;
      textColour999 = Colors.black;

      buttonSilverColour = Colors.white;
      textColourSilver = Colors.black;

      currenrLivePrice = gold916CurrentPrice;
      currentLiveWallet = gold916WalletBalance;
    });
    // costCalculator();
    myController.text = "0.0";
    recieverIDController.text = "0.0";
  }

  void button24k(context) {
    setState(() {
      button999Colour = Colors.blue;
      textColour999 = Colors.white;

      button916Colour = Colors.white;
      textColour916 = Colors.black;

      buttonSilverColour = Colors.white;
      textColourSilver = Colors.black;

      currenrLivePrice = gold999CurrentPrice;
      currentLiveWallet = gold999WalletBalance;
    });
    // costCalculator();
    myController.text = "0.0";
    recieverIDController.text = "0.0";
  }

  void buttonSilver() {
    setState(() {
      buttonSilverColour = Colors.blue;
      textColourSilver = Colors.white;

      button999Colour = Colors.white;
      textColour999 = Colors.black;

      button916Colour = Colors.white;
      textColour916 = Colors.black;

      currenrLivePrice = silverCurrentPrice;
      currentLiveWallet = silverWalletPrice;
    });
    // costCalculator();
    myController.text = "0.0";
    recieverIDController.text = "0.0";
  }

  // void costCalculator() {
  //   setState(() {
  //     if (myController.text == "0" ||
  //         myController.text == "" ||
  //         myController.text == "0.0") {
  //       qtyBoxValue = 0;
  //       costText = "0.0";
  //     } else {
  //       cost = qtyBoxValue * currenrLivePrice;
  //       costRoundOff = double.parse(cost.toStringAsFixed(2));
  //       costText = costRoundOff.toString();
  //     }
  //   });
  // }

  void _showDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          title: new Text(
            "Opps! Wallet Empty",
            style: TextStyle(
                fontFamily: fonts().fontRegular,
                fontWeight: FontWeight.bold,
                fontSize: 15),
            textAlign: TextAlign.center,
          ),
          content: new Text(
            "Sorry, you cannot do selling because your wallet is empty.",
            style: TextStyle(fontFamily: fonts().fontRegular, fontSize: 13),
            textAlign: TextAlign.left,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(
              child: new FlatButton(
                child: new Text(
                  "OK",
                  style: TextStyle(
                      fontFamily: fonts().fontRegular,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (silverWalletPrice == 0.0 &&
        gold916WalletBalance == 0.0 &&
        gold999WalletBalance == 0.0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showDialog());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => button24k(context));
  }

  @override
  void dispose() {
    myController.dispose();
    recieverIDController.dispose();
    _scan();
    super.dispose();
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      this.barcode = barcode;
    });
    recieverIDController.text = barcode;
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          "Exchange",
          style: TextStyle(fontFamily: fonts().fontMedium, color: Colors.black),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      //Choose commodity container starts.
                      Container(
                        width: deviceWidth,
                        height: deviceHeight * 0.06,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 23,
                          ),
                          child: Align(
                            child: Text(
                              "CHOOSE COMMODITY",
                              style: TextStyle(
                                  fontFamily: fonts().fontMedium,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade900),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      ),
                      //commodity container ends.

                      //The row for three buttons for choosing the given commodities starts.
                      Container(
                        width: deviceWidth,
                        height: deviceHeight * 0.07,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  button24k(context);
                                },
                                elevation: 3,
                                color: button999Colour,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Text(
                                    "Gold 24k",
                                    style: TextStyle(
                                      fontFamily: fonts().fontMedium,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: textColour999,
                                    ),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  button22k();
                                },
                                elevation: 3,
                                color: button916Colour,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  child: Text(
                                    "Gold 22k",
                                    style: TextStyle(
                                        fontFamily: fonts().fontMedium,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: textColour916),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                onPressed: () {
                                  buttonSilver();
                                },
                                elevation: 3,
                                color: buttonSilverColour,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Text(
                                    "Silver",
                                    style: TextStyle(
                                        fontFamily: fonts().fontMedium,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: textColourSilver),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // The button container ends.

                      //Container for showing commodity details starts.
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: deviceHeight * 0.085,
                          width: deviceWidth,
                          // color: Colors.cyan,
                          child: Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              elevation: 2,
                              color: Colors.lightBlue.shade50,
                              child: Container(
                                height: deviceHeight * 0.13,
                                width: deviceWidth * 0.88,
                                // Column and row for showing selected commodity details.
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: Colors.black,
                                              size: 17,
                                            ),
                                          ),
                                          Text(
                                            "Wallet Balance",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontFamily:
                                                    fonts().fontRegular),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "$currentLiveWallet gms",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontFamily: fonts().fontRegular),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Container for showing selected commodity details end.

                      //Container for Calculation boxes.
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 0),
                        child: Container(
                          width: deviceWidth * 0.88,
                          height: deviceHeight * 0.095,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              enabled: true,
                              controller: myController,

                              validator: (value) {
                                var numValue = double.parse(value);

                                if (numValue > currentLiveWallet) {
                                  return 'Sorry,Wallet Limit exceeded ';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (_formKey.currentState.validate()) {}
                              },
                              keyboardAppearance: Brightness.dark,

                              style: TextStyle(fontFamily: fonts().fontRegular),
                              decoration: InputDecoration(
                                // hintStyle: TextStyle(),
                                border: OutlineInputBorder(
                                  // borderSide: BorderSide(width: 20, color: Colors.black),
                                  borderSide: BorderSide(color: Colors.yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                labelText: 'Enter quantity (gms)',
                                labelStyle: TextStyle(
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontFamily: fonts().fontRegular),
                              ),
                              // inputFormatters: [WhitelistingTextInputFormatter.],
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                          width: deviceWidth * 0.88,
                          height: deviceHeight * 0.095,
                          // color: Colors.yellow,
                          child: Form(
                            // key: _formKey,
                            child: TextFormField(
                              enabled: true,
                              controller: recieverIDController,

                              keyboardAppearance: Brightness.dark,
                              // enableInteractiveSelection: true,
                              style: TextStyle(fontFamily: fonts().fontRegular),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    print("Scanner Icon tapped");
                                    _scan();

                                    // scanner.scanPhoto();
                                  },
                                  child: new Icon(
                                    MdiIcons.qrcodeScan,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                labelText: 'Reciever ID',
                                labelStyle: TextStyle(
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontFamily: fonts().fontRegular),
                              ),
                              // inputFormatters: [WhitelistingTextInputFormatter.],
                              // keyboardType:
                              //     TextInputType.numberWithOptions(decimal: false),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, bottom: 15, right: 25, top: 20),
                        child: Container(
                          width: deviceWidth,
                          // color: Colors.yellow,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      MdiIcons.officeBuilding,
                                      color: Colors.grey.shade800,
                                      size: 22,
                                    ),
                                  ),
                                  Text(
                                    "Company Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold,
                                        fontFamily: fonts().fontMedium),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 10, left: 5),
                                child: Container(
                                  width: deviceWidth,
                                  // height: 30,
                                  child: Text(
                                    "$companyName",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                      fontFamily: fonts().fontMedium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, top: 10, right: 25),
                        child: Container(
                          width: deviceWidth,
                          // color: Colors.yellow,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.label_important,
                                      color: Colors.grey.shade800,
                                      size: 22,
                                    ),
                                  ),
                                  Text(
                                    "Company Address",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: fonts().fontMedium,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, bottom: 10, left: 5),
                                child: Container(
                                  width: deviceWidth,
                                  // height: 30,
                                  child: Text(
                                    "$companyAddress",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                      fontFamily: fonts().fontMedium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Container for calculation boxes ends.
                    ],
                  ),
                ],
              ),
            ),
          ),
          //bottom payment section starts.
          Align(
            child: Container(
              width: deviceWidth,
              height: 79,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RaisedButton(
                    onPressed: () {
                      print("Send button tapped");
                      // _settingModalBottomSheet(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 12),
                      child: Text(
                        "SEND",
                        style: TextStyle(
                            fontFamily: fonts().fontMedium,
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            alignment: Alignment.bottomCenter,
          ),

          // Container for payment section ends.
        ],
      ),
    );
  }
}
