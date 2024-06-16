import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:utip/widgets/tip_row.dart';

import 'widgets/bill_amount.dart';
import 'widgets/person_counter.dart';
import 'widgets/tip_slider.dart';
import 'widgets/total_per_person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'UTip',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const UTip());
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 100;

  //Methods

  double totalPerPerson() {
    return (((_billTotal * _tipPercentage) + (_billTotal)) / _personCount);
  }

  double totalTip() {
    return ((_billTotal * _tipPercentage));
  }

  void increment() {
    setState(() {
      _personCount++;
    });
  }

  void decrement() {
    if (_personCount > 1) {
      setState(() {
        _personCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double total = totalPerPerson();
    double totalT = totalTip();
    final style = theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(style: style, total: total, theme: theme),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 2)),
                child: Column(
                  children: [
                    BillAmountField(
                        billAmount: _billTotal.toString(),
                        onChanged: (value) {
                          setState(() {
                            _billTotal = double.parse(value);
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Split', style: theme.textTheme.titleMedium),
                          PersonCounter(
                            theme: theme,
                            personCount: _personCount,
                            onDecrement: decrement,
                            onIncrement: increment,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TipRow(theme: theme, totalT: totalT),
                    ),
                    Text('${(_tipPercentage * 100).round()} %'),
                    TipSlider(
                      tipPercentage: _tipPercentage,
                      onChanged: (double value) {
                        setState(() {
                          _tipPercentage = value;
                        });
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
