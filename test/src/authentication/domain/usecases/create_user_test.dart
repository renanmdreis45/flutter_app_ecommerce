import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/repositories/authentication_repository.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = const CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {

    when(
      () => repository.createUser(createdAt: any(named: 'createdAt'), name: any(named: 'name')),
    ).thenAnswer((_) async => const Right(null));

    final result = usecase(params);

    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () =>
          repository.createUser(createdAt: params.createdAt, name: params.name),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
