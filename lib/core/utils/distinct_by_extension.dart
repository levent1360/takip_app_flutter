extension DistinctByExtension<T> on List<T> {
  List<T> distinctBy<K>(K Function(T) keySelector) {
    final seenKeys = <K>{};
    final result = <T>[];

    for (var element in this) {
      final key = keySelector(element);
      if (seenKeys.add(key)) {
        result.add(element);
      }
    }

    return result;
  }
}
