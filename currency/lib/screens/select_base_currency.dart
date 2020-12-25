import 'package:currency/components/header.dart';
import 'package:currency/constants.dart';
import 'package:currency/screens/select_currencies.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseCurrencySelection extends StatefulWidget {
  @override
  _BaseCurrencySelectionState createState() => _BaseCurrencySelectionState();
}

class _BaseCurrencySelectionState extends State<BaseCurrencySelection> {
  var form = GlobalKey<FormState>();
  String currencyCode = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Header(),
              SizedBox(
                height: 0,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select your Base currency",
                          style: TextStyle(fontSize: 19, color: Colors.white)),
                    ),
                  ),
                  Form(
                    key: form,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
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
                            validator: (String value) {
                              if (!currenciesCodes
                                  .contains(value.toUpperCase())) {
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
                  ),
                 
                  FlatButton(
                      onPressed: () async {
                        if (form.currentState.validate()) {
                          form.currentState.save();
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString("base", currencyCode.toUpperCase());
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectCurrencies()));
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
