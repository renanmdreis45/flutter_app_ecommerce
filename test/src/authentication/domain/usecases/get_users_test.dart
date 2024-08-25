import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];
  test(
    'should call the [AuthRepo.getUsers] and return [List<User>]',
    () async {
      when(() => repository.getUsers()).thenAnswer(
        (_) async => const Right(tResponse),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
      verify(() => repository.getUsers()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
