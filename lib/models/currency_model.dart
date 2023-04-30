class Currency {
  final String currencyFrom;
  final String currencyTo;
  final dynamic amount;
  final dynamic rate;
  final dynamic result;

  Currency({
    required this.currencyFrom,
    required this.currencyTo,
    required this.amount,
    required this.rate,
    required this.result,
  });

  factory Currency.fromMap({required Map data}) {
    return Currency(
      currencyFrom: data['query']['from'],
      currencyTo: data['query']['to'],
      amount: data['query']['amount'],
      rate: data['info']['rate'],
      result: data['result'],
    );
  }
}