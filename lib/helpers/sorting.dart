import 'package:flutter/widgets.dart';

enum SortType { ByDate, ByTag, ByAmount, ByCategory }
enum SortStrategy { Ascending, Descending }

String getSortTypeName(BuildContext context, SortType type) {
  switch (type) {
    case SortType.ByCategory:
      return "By Category";
    case SortType.ByAmount:
      return "By amount";
    case SortType.ByDate:
      return "By date";
    case SortType.ByTag:
      return "By tag";
  }
}
