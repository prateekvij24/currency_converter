import 'package:currency_converter_app/providers/currency.dart';
import 'package:currency_converter_app/screens/currency_list_screen.dart';
import 'package:currency_converter_app/screens/homepage.dart';
import 'package:currency_converter_app/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/number_input_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]).then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  String _fromcurrency = 'USD';
  String _tocurrency = 'INR';
  double _currencyval = 0.0;
  double _convertedcurrencyval = 0.0;
  bool toCurr = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Currency(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CurrencyConverty',
        /*  home: CurrencyConverty(), */

        theme: ThemeData(fontFamily: 'ArialRound', primaryColor: Colors.amber),
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          /* HomePage(
                fromcurrency: _fromcurrency,
                tocurrency: _tocurrency,
                currencyval: _currencyval,
                convertedcurrencyval: _convertedcurrencyval,
              ), */
          NumberInputScreen.routename: (ctx) => NumberInputScreen(),
          CurrencyList.routename: (ctx) => CurrencyList(_currencyval,
              _convertedcurrencyval, _fromcurrency, _tocurrency, toCurr)
        },
      ),
    );
  }
}
