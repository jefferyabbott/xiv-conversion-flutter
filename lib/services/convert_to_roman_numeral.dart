String convertToRoman(int number) {
  if (number < 1 || number > 3999) {
    throw ArgumentError('Number out of range (1-3999)');
  }

  final List<String> romanNumerals = [
    'I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M'
  ];

  final List<int> decimalValues = [
    1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000
  ];

  String roman = '';
  int i = 12;

  while (number > 0) {
    int div = number ~/ decimalValues[i];
    number %= decimalValues[i];

    while (div > 0) {
      roman += romanNumerals[i];
      div--;
    }
    i--;
  }

  return roman;
}

