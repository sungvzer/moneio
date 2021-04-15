import 'package:moneio/models/transaction_category.dart';
import 'package:test/test.dart';
import 'package:moneio/models/transaction.dart';

main() {
  var cat = TransactionCategory("NONE");
  var now = DateTime.now();
  Transaction a = Transaction(amount: 100, date: now, category: cat);
  Transaction aNegative = Transaction(amount: -100, date: now, category: cat);

  Transaction c = Transaction(amount: 1000, date: now, category: cat);
  Transaction cNegative = Transaction(amount: -1000, date: now, category: cat);

  Transaction d = Transaction(amount: 10000, date: now, category: cat);
  Transaction dNegative = Transaction(amount: -10000, date: now, category: cat);

  Transaction e = Transaction(amount: 100000, date: now, category: cat);
  Transaction eNegative =
      Transaction(amount: -100000, date: now, category: cat);

  Transaction f = Transaction(amount: 1000000, date: now, category: cat);
  Transaction fNegative =
      Transaction(amount: -1000000, date: now, category: cat);

  Transaction g = Transaction(amount: 10000000, date: now, category: cat);
  Transaction gNegative =
      Transaction(amount: -10000000, date: now, category: cat);

  Transaction h = Transaction(amount: 100000000, date: now, category: cat);
  Transaction hNegative =
      Transaction(amount: -100000000, date: now, category: cat);
  group('Transaction getSeparatedAmountString', () {
    group('positive getSeparatedAmountString', () {
      test('Positive: Single digit - 1', () {
        expect(a.getSeparatedAmountString(), '1.00');
      });

      test('Positive: Two digits - 10', () {
        expect(c.getSeparatedAmountString(), '10.00');
      });

      test('Positive: Three digits - 100', () {
        expect(d.getSeparatedAmountString(), '100.00');
      });

      test('Positive: Four digits - 1000', () {
        expect(e.getSeparatedAmountString(), '1,000.00');
      });

      test('Positive: Five digits - 10000', () {
        expect(f.getSeparatedAmountString(), '10,000.00');
      });
      test('Positive: Six digits - 100000', () {
        expect(g.getSeparatedAmountString(), '100,000.00');
      });
      test('Positive: Seven digits - 1000000', () {
        expect(h.getSeparatedAmountString(), '1,000,000.00');
      });
    });
    group('negative getSeparatedAmountString', () {
      test('Negative: Single digit - 1', () {
        expect(aNegative.getSeparatedAmountString(), '1.00');
      });

      test('Negative: Two digits - 10', () {
        expect(cNegative.getSeparatedAmountString(), '10.00');
      });

      test('Negative: Three digits - 100', () {
        expect(dNegative.getSeparatedAmountString(), '100.00');
      });

      test('Negative: Four digits - 1000', () {
        expect(eNegative.getSeparatedAmountString(), '1,000.00');
      });

      test('Negative: Five digits - 10000', () {
        expect(fNegative.getSeparatedAmountString(), '10,000.00');
      });
      test('Negative: Six digits - 100000', () {
        expect(gNegative.getSeparatedAmountString(), '100,000.00');
      });
      test('Negative: Seven digits - 1000000', () {
        expect(hNegative.getSeparatedAmountString(), '1,000,000.00');
      });
    });
  });
  group('Transaction compareTo', () {
    test('Equal transactions return 0', () {
      final DateTime now = DateTime.now();
      Transaction a = Transaction(
        amount: 320,
        category: TransactionCategory("FOOD"),
        currency: "EUR",
        date: now,
        tag: "Food!",
      );
      Transaction b = Transaction(
        amount: 320,
        category: TransactionCategory("FOOD"),
        currency: "EUR",
        date: now,
        tag: "Food!",
      );
      expect(a.compareTo(b), 0);
    });

    test('Different transactions return date compareTo', () {
      Transaction a = Transaction(
        amount: 5,
        category: TransactionCategory("CLOTHING"),
        currency: "USD",
        date: DateTime(2000, 1, 1),
        tag: "T-Shirt!",
      );
      Transaction b = Transaction(
        amount: 320,
        category: TransactionCategory("FOOD"),
        currency: "EUR",
        date: DateTime(2000, 1, 2),
        tag: "Food!",
      );
      expect(a.compareTo(b) < 0, true);
    });
  });
}
