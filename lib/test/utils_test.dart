import 'package:flutter_test/flutter_test.dart';
import 'package:ip_locator_app/utils/utils.dart';

void main() {
  group('Utils', () {
    test('valid IP returns true', () {
      expect(Utils.isValidIP('192.168.1.1'), isTrue);
      expect(Utils.isValidIP('8.8.8.8'), isTrue);
    });

    test('invalid IP returns false', () {
      expect(Utils.isValidIP('999.999.999.999'), isFalse);
      expect(Utils.isValidIP('abc.def.ghi.jkl'), isFalse);
      expect(Utils.isValidIP('123'), isFalse);
    });
  });
}
