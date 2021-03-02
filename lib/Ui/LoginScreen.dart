import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/ForgotPwdScreen.dart';
import 'package:flutter/material.dart';
import '../Blocs/login_block.dart';
import 'ChangePwdScreen.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _LoginScreen();

}
class _LoginScreen extends State<LoginScreen> {



  @override
  Widget build(BuildContext context) {
    final bloc = login_block();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
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
                stream: bloc.email,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.emailChanged,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter email",
                      labelText: "Email",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.passwordChanged,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter password",
                      labelText: "Password",
                      errorText: snapshot.error),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () => {
                  Utils.navigateReplaceToScreen(context, ForgotPwdScreen())
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue
                  ))
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed:
                       () =>
                       {
                         if(snapshot.hasData){
                          Utils.navigateReplaceToScreen(context, ChangePwdScreen())
                         } else
                           {
                             ToastUtils.showToast(context, "Fill all details", Colors.red)
                           }
                       },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}