//import 'package:email_validator/email_validator.dart';
import 'package:finnaport/provider/validation/validation_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpValidation extends ChangeNotifier {
  ValidationItem _username = ValidationItem('', '');
  ValidationItem _email = ValidationItem('', '');
  ValidationItem _password = ValidationItem('', '');
  ValidationItem _confirmPassword = ValidationItem('', '');

  ValidationItem get username => _username;
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  ValidationItem get confirmPassword => _confirmPassword;
  bool get isValid {
    if (_username.value != null &&
        _email.value != null &&
        _password.value == _confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  void changeUsername(String value) {
    if (value.length > 3) {
      _username = ValidationItem(value, '');
    } else {
      _username = ValidationItem('', "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changeEmail(String value) {
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      _email = ValidationItem('', "Please enter a valid email");
    } else {
      _email = ValidationItem(value, '');
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.length > 3) {
      _password = ValidationItem(value, '');
    } else {
      _password =
          ValidationItem('', "Password must be longer than 3 characters ");
    }
    notifyListeners();
  }

  void changeConfirmPassword(String value) {
    if (password.value == confirmPassword.value) {
      _confirmPassword = ValidationItem(value, '');
    } else {
      _confirmPassword = ValidationItem('', "Password do not match");
    }
    notifyListeners();
  }

  void submitData() {
    print(
        "Username: ${username.value}, Email: ${email.value}, Password: ${password.value}, Password: ${confirmPassword.value}");
  }
}
