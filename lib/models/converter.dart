class Converter {
  double exchangeRate = 0.0;
  String fromCurr = '';
  String toCurr = '';
  double currVal = 0.0;
  double convertedVal = 0.0;
  Converter(
      {this.exchangeRate,
      this.fromCurr,
      this.currVal,
      this.convertedVal,
      this.toCurr});
}
