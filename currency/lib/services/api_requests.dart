import 'dart:convert';
import 'package:currency/constants.dart';
import 'package:currency/models/currency_model.dart';
import 'package:http/http.dart' as http;

Future<CurrencyModel> getCurrenciesData(String baseCurrency) async {
  var req = http.MultipartRequest(
      "GET", Uri.parse("$BASE_URL$GET_BASE_URL$baseCurrency"));
  var res = await req.send();
  var data = await res.stream.transform(utf8.decoder).join();
  print(data);
  return CurrencyModel.fromJson(json.decode(data));
}
