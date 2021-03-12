import 'package:flutter/foundation.dart';

class TransactionCategory extends Comparable {
  String _key;
  String _name;
  String _emoji;

  String get uniqueID => _key;
  String get name => _name;
  String get emoji => _emoji;

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

  TransactionCategory._internal(this._key, this._name, this._emoji);

  Map<String, dynamic> toMap() {
    return {
      "key": _key,
      "name": _name,
      "emoji": _emoji,
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
    value &= other is TransactionCategory && uniqueID == other.uniqueID;

    return value;
  }

  @override
  int get hashCode => uniqueID.hashCode;

  @override
  String toString() {
    return "Category ($_key, $_name, $_emoji)";
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
