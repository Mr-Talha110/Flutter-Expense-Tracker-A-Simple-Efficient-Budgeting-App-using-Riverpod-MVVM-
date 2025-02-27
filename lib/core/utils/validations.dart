String? validateDouble(String? value) {
  RegExp regex = RegExp(r'^\d*\.?\d+$');
  if (!regex.hasMatch(value ?? '')) {
    return 'Please enter a valid amount.';
  }
  return null;
}
