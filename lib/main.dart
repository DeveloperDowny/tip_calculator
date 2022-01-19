import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tip Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100),
                child: IntrinsicWidth(
                  child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Enter amount",
                        labelText: "Enter amount",
                        border: OutlineInputBorder(),
                      )),
                )),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(amountStr: amountController.text),
                      ),
                    );
                  },
                  child: const Text("Enter")),
            )
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key, required this.amountStr}) : super(key: key);

  final String amountStr;
  final percentageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tip Calculator"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Amount entered: " + amountStr.toString(),
                style: const TextStyle(
                    fontSize: 24, fontFamily: 'RobotoMono' // need to check this
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 50),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: percentageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter percentage",
                      labelText: "Enter percentage",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    var tip = double.parse(amountStr) *
                        (double.parse(percentageController.text) / 100);
                    var roundedTip = tip.toStringAsFixed(2);
                    var totalAmount = double.parse(amountStr) + tip;
                    var roundedTotal = totalAmount.toStringAsFixed(2);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Tip Calculated!'),
                        content: Text('Amount: ${double.parse(amountStr).toStringAsFixed(2)}\nTip: $roundedTip\nTotal: $roundedTotal'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("Calculate")),
            ],
          ),
        ));
  }
}
