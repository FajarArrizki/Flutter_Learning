import 'package:flutter_test/flutter_test.dart';
import 'package:getting_started_flutter/user_model.dart';

void main() {
  test('fromJson applies safe defaults for missing values', () {
    final user = UserModel.fromJson({'name': 'Budi Santoso', 'age': 22});

    expect(user.id, '');
    expect(user.name, 'Budi Santoso');
    expect(user.email, isNull);
    expect(user.age, 22);
    expect(user.isActive, isFalse);
  });

  test('toJson serializes all model properties', () {
    final user = UserModel(
      id: 'u-1',
      name: 'Budi Santoso',
      email: 'budi@example.com',
      age: 22,
      isActive: true,
    );

    expect(user.toJson(), {
      'id': 'u-1',
      'name': 'Budi Santoso',
      'email': 'budi@example.com',
      'age': 22,
      'isActive': true,
    });
  });
}
