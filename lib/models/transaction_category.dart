class TransactionCategory extends Comparable {
  String key;
  String name;
  String emoji;

  bool get hasEmoji => emoji != "";

  static Map<String, TransactionCategory> _cache = {};

  factory TransactionCategory(String key,
      [String name = "", String emoji = ""]) {
    assert(key != "", "Category key must not be empty");

    key = key.toUpperCase();

    TransactionCategory? cat = _cache[key];
    if (cat != null) return cat;

    cat = TransactionCategory._internal(key, name, emoji);
    _cache[key] = cat;
    return cat;
  }

  TransactionCategory._internal(this.key, this.name, this.emoji);

  Map<String, dynamic> toMap() {
    return {
      "key": key,
      "name": name,
      "emoji": emoji,
    };
  }

  factory TransactionCategory.fromMap(Map<String, dynamic> map) {
    assert(
        map.containsKey("key") &&
            map.containsKey("name") &&
            map.containsKey("emoji"),
        "Invalid map used to construct a Category");
    return TransactionCategory._internal(map["key"], map["name"], map["emoji"]);
  }

  bool operator ==(Object other) {
    bool value = true;
    value &= identical(other, this);
    value &= runtimeType == other.runtimeType;
    value &= other is TransactionCategory && key == other.key;

    return value;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  String toString() {
    return "Category ($key, $name, $emoji)";
  }

  @override
  int compareTo(other) {
    if (other is! TransactionCategory) throw TypeError();
    bool equal = true;
    final int nameCompare = this.name.compareTo(other.name);
    equal &= this.emoji == other.emoji;
    equal &= this.hashCode == other.hashCode;
    equal &= nameCompare == 0;
    if (equal) return 0;
    return nameCompare;
  }

  Map<String, dynamic> toJson() => toMap();
}
