import "rates.dart";

class CurrencyModel  {
	Rates rates;
	String base;
	String date;

	CurrencyModel({this.rates, this.base, this.date});

	factory CurrencyModel.fromJson(Map<String, dynamic> json) {
		return CurrencyModel(
			rates: json['rates'] != null ? new Rates.fromJson(json['rates']) : null,
			base: json['base'],
			date: json['date'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
		data['base'] = this.base;
		data['date'] = this.date;
		return data;
	}
  
}
