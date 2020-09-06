import 'package:currency_converter_app/models/app_colors.dart';
import 'package:currency_converter_app/screens/homepage.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class NumberInputScreen extends StatefulWidget {
  /* final origCurrency;
  final convCurrency; */

  /* NumberInputScreen({this.origCurrency, this.convCurrency}); */
  static const routename = 'number-input';
  var currVal = 0.0;
  var convertedVal = 0.0;
  var currency = '';
  var tocurrency = '';
  NumberInputScreen(
      {this.currVal, this.convertedVal, this.currency, this.tocurrency});
  @override
  _NumberInputScreen createState() => _NumberInputScreen();
}

class _NumberInputScreen extends State<NumberInputScreen> {
  var currInput = 0.0;
  var isDecimal = false;
  int i = 1;
  var isLocked = false;
  @override
  Widget build(BuildContext context) {
    if (i >= 2) {
      isLocked = true;
    }
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                currInput = 0;
                isDecimal = false;
                i = 1;
                isLocked = false;
              });
            },
            child: Text(
              'tap to delete',
              style: TextStyle(
                  color: AppColors.convertButton,
                  fontSize: 17.0,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              (((currInput * 10) % 10) == 0)
                  ? currInput.toStringAsFixed(0)
                  : currInput.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 100.0,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold),
            ),
          ),
          numberRow(1, 2, 3),
          numberRow(4, 5, 6),
          numberRow(7, 8, 9),
          finalRow()
        ],
      ),
    );
  }

  Widget numberRow(number1, number2, number3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            calculateNumber(number1);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: AppColors.secondaryColor),
            child: Center(
              child: Text(
                number1.toString(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(number2);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: AppColors.secondaryColor),
            child: Center(
              child: Text(
                number2.toString(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(number3);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: AppColors.secondaryColor),
            child: Center(
              child: Text(
                number3.toString(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget finalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              isDecimal = true;
            });
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: AppColors.secondaryColor),
            child: Center(
              child: Text(
                '.',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            calculateNumber(0);
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: AppColors.secondaryColor),
            child: Center(
              child: Text(
                0.toString(),
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          currencyval: currInput.toDouble(),
                          convertedcurrencyval: widget.convertedVal,
                          fromcurrency: widget.currency,
                          tocurrency: widget.tocurrency,
                        )));
            /* CurrencyService().convertCurrency(
                widget.origCurrency, widget.convCurrency, currInput, context); */
          },
          child: Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0), color: Colors.white),
            child: Center(
                child: Icon(
              Icons.check,
              color: AppColors.secondaryColor,
              size: 25.0,
            )),
          ),
        )
      ],
    );
  }

  calculateNumber(number) {
    if (isLocked == false) {
      if (currInput == 0 && isDecimal == false) {
        setState(() {
          currInput = number.toDouble();
        });
      } else if (isDecimal == false) {
        setState(() {
          currInput = (currInput * 10) + number;
        });
      } else {
        setState(() {
          currInput = (currInput + (number * pow(10, -i)));
          i++;
        });
      }
    }
  }
}
