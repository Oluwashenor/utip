import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utip/providers/ThemeProvider.dart';
import 'package:utip/providers/TipCalculatorModel.dart';
import 'package:utip/widgets/tip_row.dart';
import 'widgets/bill_amount.dart';
import 'widgets/person_counter.dart';
import 'widgets/tip_slider.dart';
import 'widgets/total_per_person.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TipCalculatorModel()),
      ChangeNotifierProvider(create: (context) => Themeprovider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<Themeprovider>(context);
    return MaterialApp(
        title: 'UTip', theme: themeprovider.currentTheme, home: const UTip());
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TipCalculatorModel>(context);
    final themeProvider = Provider.of<Themeprovider>(context);
    //print("Current theme : ${themeProvider.currentTheme.colorScheme.toString()}");
    //print("Current theme : ${themeProvider.currentTheme.toString()}");
    var theme = Theme.of(context);
    final style = theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
        actions: const [ToggleThemeButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(
              style: style, total: model.totalPerPerson, theme: theme),
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
                        billAmount: model.billTotal.toString(),
                        onChanged: (value) {
                          model.updateBillTotal(double.parse(value));
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Split', style: theme.textTheme.titleMedium),
                          PersonCounter(
                            theme: theme,
                            personCount: model.personCount,
                            onDecrement: () {
                              if (model.personCount > 1) {
                                model.updatePersonCount(model.personCount - 1);
                              }
                            },
                            onIncrement: () {
                              model.updatePersonCount(model.personCount + 1);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TipRow(
                        theme: theme,
                        billTotal: model.billTotal,
                        percentage: model.tipPercentage,
                      ),
                    ),
                    Text('${(model.tipPercentage * 100).round()} %'),
                    TipSlider(
                      tipPercentage: model.tipPercentage,
                      onChanged: (double value) {
                        model.updateTipPercentage(value);
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

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context);
    return IconButton(
        onPressed: () {
          themeProvider.toggle();
        },
        icon: themeProvider.isDarkMode
            ? const Icon(Icons.sunny)
            : const Icon(Icons.nightlight_round));
  }
}
