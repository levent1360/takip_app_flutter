String formatMoneyStringManual(String amount) {
  // Binlik ayraçları ekle (örneğin: 1234.56 → 1.234,56)
  List<String> parts = amount.split('.');
  String integerPart = parts[0];
  String decimalPart = parts.length > 1 ? parts[1] : '00';

  String formatted = '';
  int count = 0;

  // Sağdan sola binlik ayraç ekle
  for (int i = integerPart.length - 1; i >= 0; i--) {
    formatted = integerPart[i] + formatted;
    count++;
    if (count % 3 == 0 && i != 0) {
      formatted = '.$formatted';
    }
  }

  return '$formatted,$decimalPart'; // ₺1.234,56
}
