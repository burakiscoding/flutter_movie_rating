class FormValidation {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? validatePasword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 8 || value.length > 24) {
      return 'Password lenght must be 8-24';
    }

    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty || value.length > 30) {
      return 'Must be 1-30 length';
    }

    return null;
  }

  String? validateAboutMe(String? value) {
    if (value == null || value.isEmpty || value.length > 30) {
      return 'Must be 1-255 length';
    }

    return null;
  }

  String? validateComment(String? value) {
    if (value == null || value.length > 255) {
      return 'Must be 0-255';
    }

    return null;
  }
}
