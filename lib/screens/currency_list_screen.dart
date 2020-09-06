import 'package:currency_converter_app/models/app_colors.dart';
import 'package:currency_converter_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/currency.dart';

class CurrencyList extends StatefulWidget {
  static const routename = 'currency-list';
  bool toCurr;
  var currVal = 0.0;
  var convertedVal = 0.0;
  var currency = '';
  var tocurrency = '';
  CurrencyList(this.currVal, this.convertedVal, this.currency, this.tocurrency,
      this.toCurr);
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  var isInit = true;
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
    }

    Provider.of<Currency>(context).fetchCurrencies().then((_) {
      setState(() {
        isLoading = false;
      });
    });
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<Currency>(context);
    final currencyLIST = currency.currencyList;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: currencyLIST.length,
              itemBuilder: (context, id) =>
                  Consumer<Currency>(builder: (context, currency, _) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.toCurr) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        tocurrency: currencyLIST[id],
                                        fromcurrency: widget.currency,
                                        currencyval: widget.currVal,
                                        convertedcurrencyval:
                                            widget.convertedVal,
                                      )));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        fromcurrency: currencyLIST[id],
                                        tocurrency: widget.tocurrency,
                                        currencyval: widget.currVal,
                                        convertedcurrencyval:
                                            widget.convertedVal,
                                      )));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.secondaryColor,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        child: Center(
                            child: Text(
                          currencyLIST[id],
                          style: TextStyle(fontSize: 30),
                        )),
                      ),
                    );
                  })),
    );
  }
}
