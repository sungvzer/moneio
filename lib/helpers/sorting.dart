import 'package:flutter/widgets.dart';

enum SortType { ByDate, ByName, ByAmount, ByCategory }
enum SortStrategy { Ascending, Descending }

String getSortTypeName(BuildContext context, SortType type) {
  switch (type) {
    case SortType.ByCategory:
      return "By Category";
    case SortType.ByAmount:
      return "By amount";
    case SortType.ByDate:
      return "By date";
    case SortType.ByName:
      return "By name";
  }
}
