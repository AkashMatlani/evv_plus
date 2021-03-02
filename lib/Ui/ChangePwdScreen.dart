import 'package:evv_plus/Blocs/change_pwd_bloc.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:flutter/material.dart';

class ChangePwdScreen extends StatefulWidget {
  @override
  _ChangePwdScreenState createState() => _ChangePwdScreenState();
}

class _ChangePwdScreenState extends State<ChangePwdScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = change_pwd_bloc();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      labelText: "Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                stream: bloc.conformpassword,
                builder: (context, snapshot) => TextField(
                   onChanged: bloc.conformpasswordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Conform password",
                      labelText: "Conform Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                //stream: bloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed: () =>
                      {Utils.navigateReplaceToScreen(context, LoginScreen())},
                  child: Text("Reset"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
