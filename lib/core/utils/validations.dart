String? validateNumber(String? value) {
  RegExp regex = RegExp(r'^[0-9]+$');
  if (!regex.hasMatch(value ?? '')) {
    return 'Please enter a valid number.';
  } else {
    return null;
  }
}
