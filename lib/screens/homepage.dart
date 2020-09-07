import 'dart:ui';

import 'package:currency_converter_app/screens/currency_list_screen.dart';
import 'package:currency_converter_app/screens/number_input_screen.dart';
import 'package:flutter/material.dart';
import '../models/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String fromcurrency;
  final String tocurrency;
  final double currencyval;
  double convertedcurrencyval;
  static const routename = 'home-page';
  HomePage(
      {this.fromcurrency = 'USD',
      this.tocurrency = 'INR',
      this.currencyval = 0.0,
      this.convertedcurrencyval = 0.0});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool toConvert;
  bool tocurr = false;
  bool isLoading = false;
  void initState() {
    toConvert = false;
    super.initState();
  }

  Future<void> convertfunc(
      double currval, String fromcurr, String tocurr) async {
    final url = 'http://api.openrates.io/latest?base=$fromcurr&symbols=$tocurr';
    try {
      final response = await http
          .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
      final extractedData = json.decode(response.body);

      setState(() {
        widget.convertedcurrencyval =
            (widget.currencyval * (extractedData["rates"][tocurr]));
      });
    } catch (error) {
      throw (error);
    }
  }

  MediaQuery data;
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: data.size.height,
            color: AppColors.primaryColor,
          ),
          Column(
            children: [
              Container(
                height: toConvert == false
                    ? data.size.height * 0.6
                    : data.size.height * 0.4,
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'From:',
                            style: TextStyle(
                                fontSize: 30, color: AppColors.convertButton),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CurrencyList(
                                          widget.currencyval,
                                          widget.convertedcurrencyval,
                                          widget.fromcurrency,
                                          widget.tocurrency,
                                          false)));
                            },
                            child: Text(
                              widget.fromcurrency,
                              style: TextStyle(
                                fontSize: 40,
                                color: AppColors.primaryTextColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            toConvert = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NumberInputScreen(
                                        currency: widget.fromcurrency,
                                        tocurrency: widget.tocurrency,
                                      )));
                        },
                        child: Text(
                          widget.currencyval.toString(),
                          style: TextStyle(
                            fontFamily: 'CenturyGothic',
                            fontSize: 70,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'To:',
                              style: TextStyle(
                                  fontSize: 30, color: AppColors.convertButton),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CurrencyList(
                                              widget.currencyval,
                                              widget.convertedcurrencyval,
                                              widget.fromcurrency,
                                              widget.tocurrency,
                                              true)));
                                });
                              },
                              child: Text(
                                widget.tocurrency,
                                style: TextStyle(
                                    fontSize: 40,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        toConvert == false
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                    convertfunc(
                                            widget.currencyval,
                                            widget.fromcurrency,
                                            widget.tocurrency)
                                        .then((value) {
                                      toConvert = true;
                                      isLoading = false;
                                    });
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: data.size.height * 0.07,
                                  width: data.size.width * 0.43,
                                  child: Center(
                                    child: Text(
                                      isLoading ? 'Converting...' : 'CONVERT',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                widget.convertedcurrencyval.toStringAsFixed(2),
                                style: TextStyle(
                                    fontFamily: 'CenturyGothic', fontSize: 70),
                              ),
                      ],
                    ),
                  ),
                  height: toConvert == false
                      ? data.size.height * 0.4
                      : data.size.height * 0.6,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    /* borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ), */
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, 20);
    path.quadraticBezierTo(5, 5, 20, 0);
    path.lineTo(20, 0);
    path.lineTo((size.width / 2) - 25, 0);
    /* path.conicTo((size.width / 2) - 5, 10, size.width / 2, 20, 1); */
    path.cubicTo(
        size.width / 2 - 15, 5, size.width / 2 - 5, 15, size.width / 2, 20);
    path.lineTo(size.width / 2, 20);
    path.lineTo(size.width - 20, 20);
    path.quadraticBezierTo(size.width - 5, 25, size.width, 40);
    path.lineTo(size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
