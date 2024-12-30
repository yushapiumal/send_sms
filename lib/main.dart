import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Listener App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SmsHomePage(),
    );
  }
}

class SmsHomePage extends StatefulWidget {
  @override
  _SmsHomePageState createState() => _SmsHomePageState();
}

class _SmsHomePageState extends State<SmsHomePage> {
  final SmsReceiver receiver = SmsReceiver();

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermissions();
    receiver.onSmsReceived?.listen((SmsMessage msg) {
      // Handle incoming SMS here
      print('Received SMS: ${msg.body} from ${msg.sender}');
    });
  }

  Future<void> _checkAndRequestPermissions() async {
    // Check and request SMS permissions
    if (await Permission.sms.request().isGranted) {
      print("SMS permission granted");
    } else {
      print("SMS permission denied");
      // Handle denied permissions
    }
  }

  Future<void> sendSms(String message, List<String> recipients) async {
    try {
      String result = await sendSMS(
        message: message,
        recipients: recipients,
      );
      print(result);
    } catch (error) {
      print(error);
    }
  }

  void _sendMessages() async {
    // Check permissions before sending SMS
    if (await Permission.sms.isGranted) {
      sendSms("Your first message", ["+94768024806"]); // Replace with actual number
      sendSms("Your second message", ["+1234567890"]); // Replace with actual number
    } else {
      _checkAndRequestPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SMS Listener')),
      body: Center(
        child: ElevatedButton(
          onPressed: _sendMessages,
          child: const Text('Send SMS Messages'),
        ),
      ),
    );
  }
}
