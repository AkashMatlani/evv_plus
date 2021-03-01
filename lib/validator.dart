import 'dart:async';

mixin Validators{

  var emailValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (email,sink){
        if(email.contains("@")){
          sink.add(email);
        }else{
          sink.addError("Email is not valid");
        }
      }
  );

  var passwordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (password,sink){
        if(password.length>4){
          sink.add(password);
        }else{
          sink.addError("Password length should be greater than 4 chars.");
        }
      }
  );

  var conformPasswordValidator = StreamTransformer<String,String>.fromHandlers(
      handleData: (conformPassword,sink){
        if(conformPassword.length>4){
          sink.add(conformPassword);
        }else{
          sink.addError("Password length should be greater than 4 chars.");
        }
      }
  );

  // var matchPasswordValidator = StreamTransformer<String,String,String>.fromHandlers(
  //     handleData: (password,sink){
  //       if(newpassword.length>4){
  //         sink.add(newpassword);
  //       }else{
  //         sink.addError("Password length should be greater than 4 chars.");
  //       }
  //     }
  // );


  //!conformpassword.text.toString().equals(password.text.toString())

}