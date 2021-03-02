import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/Ui/LoginScreen.dart';
import 'package:flutter/material.dart';

import '../Blocs/login_block.dart';
import '../Blocs/forgot_pwd_bloc.dart';
import 'ChangePwdScreen.dart';
class ForgotPwdScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()  => _ForgotPwdScreen();

}
class _ForgotPwdScreen extends State<ForgotPwdScreen> {

  changeThePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }


  @override
  Widget build(BuildContext context) {
    final bloc = forgot_pwd_bloc();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Forgot Password"),
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
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) => RaisedButton(
                  color: Colors.tealAccent,
                  onPressed:
                       () =>
                       {
                         if(snapshot.hasData){
                           changeThePage(context)
                         } else
                           {
                             ToastUtils.showToast(context, "Please enter valid email id", Colors.red)
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