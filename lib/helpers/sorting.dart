import 'package:flutter/widgets.dart';
import 'package:moneio/generated/l10n.dart';

enum SortType { ByDate, ByTag, ByAmount, ByCategory }
enum SortStrategy { Ascending, Descending }

String getSortTypeName(BuildContext context, SortType type) {
  switch (type) {
    case SortType.ByCategory:
      return Localization.of(context).homeSortByCategory;
    case SortType.ByAmount:
      return Localization.of(context).homeSortByAmount;
    case SortType.ByDate:
      return Localization.of(context).homeSortByDate;
    case SortType.ByTag:
      return Localization.of(context).homeSortByTag;
  }
}
