import 'package:dartz/dartz.dart';
import 'package:flutter_app_ecommerce/core/errors/exceptions.dart';
import 'package:flutter_app_ecommerce/core/errors/failure.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:flutter_app_ecommerce/src/features/auth/data/repositories/authentication_repository_implementation.dart';
import 'package:flutter_app_ecommerce/src/features/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException =
      APIException(message: 'Unknown Error Occurred', statusCode: 500);

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    test(
      'should call the [RemoteDataSource.createUser] and complete succesfully when the call to the remote source is succesfully',
      () async {
        when(() => remoteDataSource.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'))).thenAnswer((_) async => Future.value());

        final result =
            await repoImpl.createUser(createdAt: createdAt, name: name);

        expect(result, equals(const Right(null)));
        verify(() =>
                remoteDataSource.createUser(createdAt: createdAt, name: name))
            .called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
        'should return a [ServerFailure] when the call to the remote'
        'source is unsuccesful', () async {
      when(() => remoteDataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'))).thenThrow(tException);

      final result =
          await repoImpl.createUser(createdAt: createdAt, name: name);

      expect(
          result,
          equals(Left(ApiFailure(
              message: tException.message,
              statusCode: tException.statusCode))));

      verify(() =>
              remoteDataSource.createUser(createdAt: createdAt, name: name))
          .called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>]'
        'when call to remote source is successful', () async {
      const expectedUsers = [User.empty()];
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => expectedUsers,
      );

      final result = await repoImpl.getUsers();
      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return a [APIFailure] when the call to the remote'
        'source is unsuccessful', () async {
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      final result = await repoImpl.getUsers();

      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
