import 'dart:async';
import '../validator.dart';
import 'package:rxdart/rxdart.dart';

class forgot_pwd_bloc extends Object with Validators implements BaseBloc {
  final _emailController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Stream<String> get email => _emailController.stream.transform(emailValidator);

  //Stream<bool> get submitCheck => Rx.combineLatest(email, (values) => false);


  submit() {
    print("xyx");
  }

  @override
  void dispose() {
    _emailController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}