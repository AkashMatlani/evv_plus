import 'dart:async';

import 'package:evv_plus/GeneralUtils/Utils.dart';

mixin Validators{

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (email,sink){
        if(Utils.isValidEmail(email)){
          sink.add(email);
        }else{
          sink.addError("Email is not valid");
        }
      }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (password,sink){
        if(Utils.isValidPassword(password)){
          sink.add(password);
        }else{
          sink.addError("Enter at least one letter, one number and one special character.");
        }
      }
  );

  var conformPasswordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (conformPassword,sink){
        if(Utils.isValidPassword(conformPassword)){
          sink.add(conformPassword);
        }else{
          sink.addError("Enter at least one letter, one number and one special character.");
        }
      }
  );

 

}