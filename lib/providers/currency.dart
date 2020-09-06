import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Currency with ChangeNotifier {
  List<String> _currencyList = [];
  List<String> get currencyList {
    return [..._currencyList];
  }

  Future<void> fetchCurrencies() async {
    final url = 'http://api.openrates.io/latest';
    try {
      final response = await http
          .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
      final extractedData = json.decode(response.body);
      Map curr = extractedData['rates'];
      List<String> currencies = curr.keys.toList();

      _currencyList = currencies;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
