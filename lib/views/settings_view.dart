import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _email, _plaidClientId, _plaidSecret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Plaid Client ID'),
                obscureText: true,
                onSaved: (value) => _plaidClientId = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Plaid Secret'),
                obscureText: true,
                onSaved: (value) => _plaidSecret = value!,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Save Settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      // Process data and save settings
      // For example, save to SharedPreferences or send to a server
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Settings Saved')));
    }
  }
}
