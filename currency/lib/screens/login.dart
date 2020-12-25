import 'package:currency/screens/select_base_currency.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  String googleIconURL =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png";

  

  googleSignIn(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _googleSignIn.signIn().then((GoogleSignInAccount signInAccount) {
      pref.setString("email", signInAccount.email);
      pref.setString("id", signInAccount.id);
      pref.setString("image", signInAccount.photoUrl);
      pref.setString("name", signInAccount.displayName);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BaseCurrencySelection()));
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 80,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RaisedButton(
            shape: StadiumBorder(),
            onPressed: () {
              googleSignIn(context);
            },
            child: Center(
                child: ListTile(
              leading: Image.network(
                googleIconURL,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Google Signin",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            )),
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}
