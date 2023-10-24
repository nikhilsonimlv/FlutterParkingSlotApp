class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map) : reverseMap = map.map((k, v) => MapEntry(v, k));

  Map<T, String> get reverse {
    return reverseMap;
  }
}
