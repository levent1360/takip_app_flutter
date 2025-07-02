String normalizeTurkishCharacters(String input) {
  final Map<String, String> turkishMap = {
    'ç': 'c',
    'ğ': 'g',
    'ı': 'i',
    'İ': 'i',
    'ö': 'o',
    'ş': 's',
    'ü': 'u',
  };

  return input
      .split('')
      .map((char) {
        return turkishMap[char] ?? char;
      })
      .join('');
}
