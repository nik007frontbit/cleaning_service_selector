class TextFieldValidation {
  TextFieldValidation._();

  static String? validation({
    String? value,
    String? message,
    bool isEmailValidator = false,
    bool isPhone = false,
    bool isPasswordValidator = false,
  }) {
    if (value!.isEmpty) {
      return "$message is required!";
    }
    if (isEmailValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$')
          // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter Valid $message';
      }
    } else if (isPhone == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (value.length < 10) {
        return 'Enter Valid $message';
      }
    } else if (isPasswordValidator == true) {
      RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (value.isEmpty) {
        return "$message is required!";
      } else {
        if (!regex.hasMatch(value)) {
          return 'Must Contains 8+ chars, A-Z, a-z, 0-9, !@#\$&*~';
        } else {
          return null;
        }
      }
    }
    return null;
  }
}
