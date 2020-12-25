import 'package:currency/screens/Login.dart';
import 'package:currency/screens/select_base_currency.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/header.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        canvasColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    validateUserLogin();
    super.initState();
  }

  validateUserLogin() {
    Future.delayed(Duration(milliseconds: 2000), () {
      SharedPreferences.getInstance().then((pref) => {
            if (pref.getString("id") != null)
              {
                Navigator.pushReplacement(
                    context,
                    (MaterialPageRoute(
                        builder: (context) => BaseCurrencySelection())))
              }
            else
              {
                Navigator.pushReplacement(
                    context, (MaterialPageRoute(builder: (context) => Login())))
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Header()
      ),
    );
  }
}
