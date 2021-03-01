import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class changepasswordbloc extends Object with Validators implements BaseBloc {
  final _passwordController = BehaviorSubject<String>();
  final _conformpasswordController = BehaviorSubject<String>();

  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get conformpasswordChanged => _conformpasswordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get password => _passwordController.stream.transform(passwordValidator);
  Stream<String> get conformpassword =>
      _conformpasswordController.stream.transform(conformPasswordValidator)
      .doOnData((String c) {
        if (0 != _passwordController.value.compareTo(c)){
          // If they do not match, add an error
          _conformpasswordController.addError("No Match");
        }
      });


  Stream<bool> get submitCheck =>
      Rx.combineLatest2(password, conformpassword, (e, p) => true);

  submit() {
    print("xyx");
  }

  @override
  void dispose() {
    _passwordController?.close();
    _conformpasswordController?.close();
  }
}

abstract class BaseBloc {
  void dispose();
}