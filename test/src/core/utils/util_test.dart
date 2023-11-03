import 'package:dartz/dartz.dart';
import 'package:parkingslot/src/core/utils/util.dart';
import 'package:test/test.dart';

void main() {
  group('EnumValues Tests', () {
    test('reverseMap should be correctly initialized from map', () {
      // Arrange
      final map = {
        'value1': 'enumValue1',
        'value2': 'enumValue2',
        'value3': 'enumValue3',
      };
      final enumValues = EnumValues<String>(map);

      // Act
      final reverseMap = enumValues.reverseMap;

      // Assert
      expect(reverseMap, isA<Map<String, String>>());
      expect(reverseMap, equals({'enumValue1': 'value1', 'enumValue2': 'value2', 'enumValue3': 'value3'}));
    });

    test('reverse should return the reverse map', () {
      // Arrange
      final map = {
        'value1': 'enumValue1',
        'value2': 'enumValue2',
      };
      final enumValues = EnumValues<String>(map);

      // Act
      final reverse = enumValues.reverse;

      // Assert
      expect(reverse, isA<Map<String, String>>());
      expect(reverse, equals({'enumValue1': 'value1', 'enumValue2': 'value2'}));
    });
  });

  group('EitherX Extension Tests', () {
    test('asRight should return the right value', () {
      // Arrange
      const rightValue = Right('Hello');
      const either = rightValue;

      // Act
      final result = either.asRight();

      // Assert
      expect(result, 'Hello');
    });

    test('asLeft should return the left value', () {
      // Arrange
      const leftValue = Left('Error');
      const either = leftValue;

      // Act
      final result = either.asLeft();

      // Assert
      expect(result, 'Error');
    });
  });
}
