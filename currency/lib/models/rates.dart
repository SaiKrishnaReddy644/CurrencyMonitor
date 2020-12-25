class Rates {
  double cad;
  double hkd;
  double isk;
  double php;
  double dkk;
  double huf;
  double czk;
  double aud;
  double ron;
  double sek;
  double idr;
  double inr;
  double brl;
  double rub;
  double hrk;
  double jpy;
  double thb;
  double chf;
  double sgd;
  double pln;
  double bgn;
  double tryy;
  double cny;
  double nok;
  double nzd;
  double zar;
  double usd;
  double mxn;
  double ils;
  double gbp;
  double krw;
  double myr;
  double eur;
  Rates(
      {this.eur,
      this.cad,
      this.hkd,
      this.isk,
      this.php,
      this.dkk,
      this.huf,
      this.czk,
      this.aud,
      this.ron,
      this.sek,
      this.idr,
      this.inr,
      this.brl,
      this.rub,
      this.hrk,
      this.jpy,
      this.thb,
      this.chf,
      this.sgd,
      this.pln,
      this.bgn,
      this.tryy,
      this.cny,
      this.nok,
      this.nzd,
      this.zar,
      this.usd,
      this.mxn,
      this.ils,
      this.gbp,
      this.krw,
      this.myr});

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      eur: json['EUR'],
      cad: json['CAD'],
      hkd: json['HKD'],
      isk: json['ISK'],
      php: json['PHP'],
      dkk: json['DKK'],
      huf: json['HUF'],
      czk: json['CZK'],
      aud: json['AUD'],
      ron: json['RON'],
      sek: json['SEK'],
      idr: json['IDR'],
      inr: json['INR'],
      brl: json['BRL'],
      rub: json['RUB'],
      hrk: json['HRK'],
      jpy: json['JPY'],
      thb: json['THB'],
      chf: json['CHF'],
      sgd: json['SGD'],
      pln: json['PLN'],
      bgn: json['BGN'],
      tryy: json['TRY'],
      cny: json['CNY'],
      nok: json['NOK'],
      nzd: json['NZD'],
      zar: json['ZAR'],
      usd: json['USD'],
      mxn: json['MXN'],
      ils: json['ILS'],
      gbp: json['GBP'],
      krw: json['KRW'],
      myr: json['MYR'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CAD'] = this.cad;
    data['HKD'] = this.hkd;
    data['ISK'] = this.isk;
    data['PHP'] = this.php;
    data['DKK'] = this.dkk;
    data['HUF'] = this.huf;
    data['CZK'] = this.czk;
    data['AUD'] = this.aud;
    data['RON'] = this.ron;
    data['SEK'] = this.sek;
    data['IDR'] = this.idr;
    data['INR'] = this.inr;
    data['BRL'] = this.brl;
    data['RUB'] = this.rub;
    data['HRK'] = this.hrk;
    data['JPY'] = this.jpy;
    data['THB'] = this.thb;
    data['CHF'] = this.chf;
    data['EUR'] = this.eur;
    data['SGD'] = this.sgd;
    data['PLN'] = this.pln;
    data['BGN'] = this.bgn;
    data['TRY'] = this.tryy;
    data['CNY'] = this.cny;
    data['NOK'] = this.nok;
    data['NZD'] = this.nzd;
    data['ZAR'] = this.zar;
    data['USD'] = this.usd;
    data['MXN'] = this.mxn;
    data['ILS'] = this.ils;
    data['GBP'] = this.gbp;
    data['KRW'] = this.krw;
    data['MYR'] = this.myr;
    return data;
  }
}
