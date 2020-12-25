import 'package:currency/components/header.dart';
import 'package:currency/constants.dart';
import 'package:currency/screens/currency_monitor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectCurrencies extends StatefulWidget {
  @override
  _SelectCurrenciesState createState() => _SelectCurrenciesState();
}

class _SelectCurrenciesState extends State<SelectCurrencies> {
  var form = GlobalKey<FormState>();
  String currencyCode = "";
  List<String> currencies = [];
  String baseCurrency = "";

  @override
  void initState() {
    getCurrencyList();
  }

  getCurrencyList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      baseCurrency = pref.getString("base");
    });

    if (pref.getStringList("currencies") != null) {
      currencies = pref.getStringList("currencies");
    }
  }

  addCurrencyToList(String currency) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (!currencies.contains(currency.toUpperCase()) &&
        pref.getString('base') != currency) {
      setState(() {
        currencies.add(currency.toUpperCase());
      });
    }
  }

  List<Widget> listTile() {
    List<Widget> list = [];
    for (var i = 0; i < currencies.length; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  currencies[i],
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    currencies.removeAt(currencies.indexOf(currencies[i]));
                  });
                },
              )
            ],
          ),
        ),
      ));
    }
    if (list.length == 0) {
      return [Container()];
    } else {
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Header(),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Base Currency: $baseCurrency",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Currencies to compare",
                            style:
                                TextStyle(fontSize: 17, color: Colors.white)),
                      ),
                    ),
                    Form(
                      key: form,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 15, right: 15, bottom: 5),
                          child: TextFormField(
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                errorStyle: TextStyle(fontSize: 12, height: 0),
                                hintText: "Currency Code (INR, USD, EUR, ...)",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                            validator: (value) {
                              if (!currenciesCodes
                                  .contains(value.toUpperCase().trim())) {
                                return "Invalid Currency Code Entered";
                              }
                            },
                            onSaved: (String value) {
                              currencyCode = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                        onPressed: () async {
                          if (form.currentState.validate()) {
                            form.currentState.save();
                            addCurrencyToList(currencyCode);
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.setStringList("currencies", currencies);
                          }
                          form.currentState.reset();
                        },
                        child: Container(
                            child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25,
                        ))),
                    FlatButton(
                        onPressed: () async {
                          Navigator.of(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CurrencyMonitor()));
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(children: listTile())
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
