import 'package:flutter/material.dart';

class AccountLinkingScreen extends StatefulWidget {
  @override
  _AccountLinkingScreenState createState() => _AccountLinkingScreenState();
}

class _AccountLinkingScreenState extends State<AccountLinkingScreen> {
  final TextEditingController _clientIdController = TextEditingController();
  final TextEditingController _secretController = TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();

  @override
  void dispose() {
    _clientIdController.dispose();
    _secretController.dispose();
    _publicKeyController.dispose();
    super.dispose();
  }

  void _linkAccount() {
    // Placeholder for account linking logic
    // IMPORTANT: Actual account linking should be handled server-side
    final String clientId = _clientIdController.text;
    final String secret = _secretController.text;
    final String publicKey = _publicKeyController.text;

    // Show a warning that this method is insecure and not recommended for production
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text(
              "Storing and using API keys on the client side is insecure and not recommended."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Linking'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _clientIdController,
              decoration: InputDecoration(labelText: 'Client ID'),
            ),
            TextField(
              controller: _secretController,
              decoration: InputDecoration(labelText: 'Secret'),
            ),
            TextField(
              controller: _publicKeyController,
              decoration: InputDecoration(labelText: 'Public Key'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _linkAccount,
              child: Text('Link Account'),
            ),
          ],
        ),
      ),
    );
  }
}
