import 'package:flutter/material.dart';

import 'widgets/person_counter.dart';

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

  //Methods
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
    final style = theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      'Total Per Person',
                      style: style,
                    ),
                    Text('\$23.89',
                        style: style?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontSize: theme.textTheme.displaySmall?.fontSize))
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: theme.colorScheme.primary, width: 2)),
                child: Column(
                  children: [
                    TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.attach_money),
                            labelText: 'Bill Amount'),
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {}),
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
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
