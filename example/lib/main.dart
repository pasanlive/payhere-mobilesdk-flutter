import 'package:flutter/material.dart';

import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';

void main() {
  // MaterialApp is being initialized like this,
  // instead of it being inside a separate class due
  // to a context issue when showing AlertDialog(s) later
  // in the app.
  //
  // See:
  // "No MaterialLocalizations found - MyApp widgets require MaterialLocalizations to be
  // provided by a Localizations widget ancestor"
  // https://stackoverflow.com/questions/56275595/no-materiallocalizations-found-myapp-widgets-require-materiallocalizations-to

  runApp(MaterialApp(home: App()));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  void showAlert(BuildContext context, String title, String msg) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void startOneTimePayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": false, // true if using Sandbox Merchant ID
      "merchant_id": "1223220", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "5.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": 30.00,
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("One Time Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("One Time Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("One Time Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startRecurringPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": false, // true if using Sandbox Merchant ID
      "merchant_id": "1223220", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": 50.00,
      "quantity_1": "1",
      "item_number_2": "002",
      "item_name_2": "Test Item #1",
      "amount_2": "25.00",
      "quantity_2": "2",
      "amount": 100.00,
      "recurrence": "1 Month", // Recurring payment frequency
      "duration": "1 Year", // Recurring payment duration
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
      "delivery_address": "No. 46, Galle road, Kalutara South",
      "delivery_city": "Kalutara",
      "delivery_country": "Sri Lanka",
      "custom_1": "",
      "custom_2": ""
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Recurring Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("Recurring Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Recurring Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startTokenizationPayment(BuildContext context,
      {bool setAmount = false}) async {
    Map paymentObject = {
      "sandbox": false, // true if using Sandbox Merchant ID
      "preapprove": true, // Required
      "merchant_id": "1223220", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "currency": "LKR",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    if (setAmount) {
      paymentObject['amount'] = '30.00';
    }

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Tokenization Payment Success. Payment Id: $paymentId");
      showAlert(context, "Payment Success!", "Payment Id: $paymentId");
    }, (error) {
      print("Tokenization Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Tokenization Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  void startHoldOnCardPayment(BuildContext context) async {
    Map paymentObject = {
      "sandbox": false, // true if using Sandbox Merchant ID
      "authorize": true, // Required
      "merchant_id": "1223220", // Replace your Merchant ID
      "notify_url": "https://ent13zfovoz7d.x.pipedream.net/",
      "order_id": "ItemNo12345",
      "items": "Hello from Flutter!",
      "currency": "LKR",
      "item_number_1": "001",
      "item_name_1": "Test Item #1",
      "amount_1": "15.00",
      "quantity_1": "2",
      "item_number_2": "002",
      "item_name_2": "Test Item #2",
      "amount_2": "20.00",
      "quantity_2": "1",
      "amount": "50.00",
      "first_name": "Saman",
      "last_name": "Perera",
      "email": "samanp@gmail.com",
      "phone": "0771234567",
      "address": "No.1, Galle Road",
      "city": "Colombo",
      "country": "Sri Lanka",
    };

    PayHere.startPayment(paymentObject, (paymentId) {
      print("Hold-on-Card Payment Success.");
      showAlert(context, "Payment Success!", "");
    }, (error) {
      print("Hold-on-Card Payment Failed. Error: $error");
      showAlert(context, "Payment Failed", "$error");
    }, () {
      print("Hold-on-Card Payment Dismissed");
      showAlert(context, "Payment Dismissed", "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  startOneTimePayment(context);
                },
                child: Text('Start One Time Payment!')),
            TextButton(
                onPressed: () {
                  startRecurringPayment(context);
                },
                child: Text('Start Recurring Payment!')),
            TextButton(
                onPressed: () {
                  startTokenizationPayment(context);
                },
                child: Text('Start Tokenization Payment!')),
            TextButton(
                onPressed: () {
                  startTokenizationPayment(context, setAmount: true);
                },
                child: Text('Start Tokenization Payment (with amount)!')),
            TextButton(
                onPressed: () {
                  startHoldOnCardPayment(context);
                },
                child: Text('Start Hold on Card Payment!')),
          ],
        ),
      ),
    );
  }
}
