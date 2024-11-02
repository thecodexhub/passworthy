import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    User createSubject({
      String id = '123',
      String name = 'User 1',
      String email = 'abc@abc.com',
      String createdAt = '02-11-2024T00:00:00.000Z',
    }) {
      return User(
        id: id,
        name: name,
        email: email,
        createdAt: createdAt,
      );
    }

    test('constructor works correctly', () {
      expect(createSubject, returnsNormally);
    });

    test('supports value equality', () {
      expect(createSubject(), equals(createSubject()));
    });

    test('name will be set to User if not provided', () {
      const user = User(id: 'id');
      expect(user.name, isNotNull);
      expect(user.name, equals('User'));
    });

    test('props are correct', () {
      final user = createSubject();
      expect(
        user.props,
        equals(
          <Object?>[
            '123', // id
            'User 1', // name
            'abc@abc.com', // email
            '02-11-2024T00:00:00.000Z', // createdAt
          ],
        ),
      );
    });

    test('empty returns user with empty id', () {
      const empty = User.empty;
      expect(empty.id, equals(''));
      expect(empty.email, isNull);
    });

    group('isUnauthenticated', () {
      test('returns true when user is empty', () {
        const user = User.empty;
        expect(user.isUnauthenticated, isTrue);
      });

      test('returns false when user is not empty', () {
        final user = createSubject();
        expect(user.isUnauthenticated, isFalse);
      });
    });

    group('isAuthenticated', () {
      test('returns true when user is not empty', () {
        final user = createSubject();
        expect(user.isAuthenticated, isTrue);
      });

      test('returns false when user is empty', () {
        const user = User.empty;
        expect(user.isAuthenticated, isFalse);
      });
    });
  });
}
