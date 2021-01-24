import 'package:test/test.dart';
import 'package:moneio/models/transaction.dart';

main() {
  Transaction a = new Transaction(amount: 0.0);
  Transaction b = new Transaction(amount: 1.0);
  Transaction c = new Transaction(amount: 10.0);
  Transaction d = new Transaction(amount: 100.0);
  Transaction e = new Transaction(amount: 1000.0);
  Transaction f = new Transaction(amount: 10000.0);
  Transaction g = new Transaction(amount: 100000.0);
  Transaction h = new Transaction(amount: 1000000.0);

  group('getSeparatedAmountString', () {
    test('Single digit - 0', () {
      expect(a.getSeparatedAmountString(), '0,00');
    });

    test('Single digit - 1', () {
      expect(b.getSeparatedAmountString(), '1,00');
    });

    test('Two digits - 10', () {
      expect(c.getSeparatedAmountString(), '10,00');
    });

    test('Three digits - 100', () {
      expect(d.getSeparatedAmountString(), '100,00');
    });

    test('Four digits - 1000', () {
      expect(e.getSeparatedAmountString(), '1.000,00');
    });

    test('Five digits - 10000', () {
      expect(f.getSeparatedAmountString(), '10.000,00');
    });
    test('Six digits - 100000', () {
      expect(g.getSeparatedAmountString(), '100.000,00');
    });
    test('Seven digits - 1000000', () {
      expect(h.getSeparatedAmountString(), '1.000.000,00');
    });
  });
}
