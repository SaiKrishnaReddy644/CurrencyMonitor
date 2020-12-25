import 'dart:async';

import 'package:currency/components/header.dart';
import 'package:currency/constants.dart';
import 'package:currency/main.dart';
import 'package:currency/models/currency_model.dart';
import 'package:currency/screens/select_base_currency.dart';
import 'package:currency/screens/select_currencies.dart';
import 'package:currency/services/api_requests.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyMonitor extends StatefulWidget {
  @override
  _CurrencyMonitorState createState() => _CurrencyMonitorState();
}

class _CurrencyMonitorState extends State<CurrencyMonitor> {
  Future<CurrencyModel> currencyModeFuture;
  SharedPreferences pref;
  var baseCurrency = "";
  @override
  void initState() {
    currencyModeFuture = getCurrenciesRequestData();
    super.initState();
  }

  Future<CurrencyModel> getCurrenciesRequestData() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      baseCurrency = pref.getString("base");
    });
    CurrencyModel currencyModel = await getCurrenciesData(baseCurrency);
    return currencyModel;
  }

  asyncDataFetch() {
    Timer(Duration(seconds: 60), () async {
      setState(() {
        currencyModeFuture = getCurrenciesRequestData();
      });
    });
  }

  getCurrencyListWidget(CurrencyModel currencyModel) {
    List<Widget> currencyListWidget = [];
    List<String> selectedCurrencies = pref.getStringList("currencies");
    var currenciesData = currencyModel.toJson();
    var j = 0;
    for (var i = 0; i < currenciesCodes.length; i++) {
      if (j <= selectedCurrencies.length - 1) {
        if (currenciesCodes.contains(selectedCurrencies[j])) {
          currencyListWidget.add(Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${selectedCurrencies[j]}\t\t${currenciesData['rates'][selectedCurrencies[j]]}",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ));
          j++;
        }
      }
    }
    return currencyListWidget;
  }

  @override
  Widget build(BuildContext context) {
    asyncDataFetch();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Header(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  getCurrenciesRequestData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Refresh",
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: FutureBuilder(
                future: currencyModeFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData && !snapshot.hasError) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                  "Base Currency $baseCurrency\n $baseCurrency Value : 1 $baseCurrency",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BaseCurrencySelection()));
                              },
                              child: Text("Edit Base currency",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Today's Value",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectCurrencies()));
                                    },
                                    child: Text("+ Add more currency",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17)),
                                  )
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              children: getCurrencyListWidget(snapshot.data)),
                        ),
                      ],
                    );
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LinearProgressIndicator(
                          backgroundColor: Colors.white);
                    } else {
                      return Column(
                        children: [
                          Text("Cannot able to load the currency list")
                        ],
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => SplashScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    pref.setStringList("currencies", []);
    super.dispose();
  }
}
