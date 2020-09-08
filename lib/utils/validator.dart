class MyValidator {

  String emailValidator (value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value.trim())){
      return 'Email Address is Invalid';
    }
    else {
      return null;
    }
  }

  String password (String value) {
    if (value.trim().length < 6) {
      return 'Password must be longer than 6 characters';
    }
    else {
      return null;
    }
  }

  // Validate Card Number

  static String validateCardNumWithLuhnAlgorithm(String input) {
    if (input.isEmpty) {
      return 'Please Enter Card Number';
    }

    input = input.trim();

    if (input.length < 8) { // No need to even proceed with the validation if it's less than 8 characters
      return 'Card Number is Invalid';
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return null;
  }

  // CVV

  static String cVVCheck (String cvv) {
    cvv = cvv.trim();
    if (cvv.length < 3  || cvv.length > 4) {
      return 'Code Not Valid';
    }
    return null;
  }
}