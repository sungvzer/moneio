import 'package:test/test.dart';
import 'package:moneio/models/transaction.dart';

main() {
  Transaction a = new Transaction(amount: 1.0);
  Transaction aNegative = new Transaction(amount: -1.0);

  Transaction c = new Transaction(amount: 10.0);
  Transaction cNegative = new Transaction(amount: -10.0);

  Transaction d = new Transaction(amount: 100.0);
  Transaction dNegative = new Transaction(amount: -100.0);

  Transaction e = new Transaction(amount: 1000.0);
  Transaction eNegative = new Transaction(amount: -1000.0);

  Transaction f = new Transaction(amount: 10000.0);
  Transaction fNegative = new Transaction(amount: -10000.0);

  Transaction g = new Transaction(amount: 100000.0);
  Transaction gNegative = new Transaction(amount: -100000.0);

  Transaction h = new Transaction(amount: 1000000.0);
  Transaction hNegative = new Transaction(amount: -1000000.0);

  group('positive getSeparatedAmountString', () {
    test('Positive: Single digit - 1', () {
      expect(a.getSeparatedAmountString(), '1,00');
    });

    test('Positive: Two digits - 10', () {
      expect(c.getSeparatedAmountString(), '10,00');
    });

    test('Positive: Three digits - 100', () {
      expect(d.getSeparatedAmountString(), '100,00');
    });

    test('Positive: Four digits - 1000', () {
      expect(e.getSeparatedAmountString(), '1.000,00');
    });

    test('Positive: Five digits - 10000', () {
      expect(f.getSeparatedAmountString(), '10.000,00');
    });
    test('Positive: Six digits - 100000', () {
      expect(g.getSeparatedAmountString(), '100.000,00');
    });
    test('Positive: Seven digits - 1000000', () {
      expect(h.getSeparatedAmountString(), '1.000.000,00');
    });
  });
  group('negative getSeparatedAmountString', () {
    test('Negative: Single digit - 1', () {
      expect(aNegative.getSeparatedAmountString(), '1,00');
    });

    test('Negative: Two digits - 10', () {
      expect(cNegative.getSeparatedAmountString(), '10,00');
    });

    test('Negative: Three digits - 100', () {
      expect(dNegative.getSeparatedAmountString(), '100,00');
    });

    test('Negative: Four digits - 1000', () {
      expect(eNegative.getSeparatedAmountString(), '1.000,00');
    });

    test('Negative: Five digits - 10000', () {
      expect(fNegative.getSeparatedAmountString(), '10.000,00');
    });
    test('Negative: Six digits - 100000', () {
      expect(gNegative.getSeparatedAmountString(), '100.000,00');
    });
    test('Negative: Seven digits - 1000000', () {
      expect(hNegative.getSeparatedAmountString(), '1.000.000,00');
    });
  });
}
