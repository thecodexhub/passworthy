// ignore_for_file: prefer_const_constructors

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_memory_cache/in_memory_cache.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase/supabase.dart' as supabase;

class MockSupabaseClient extends Mock implements supabase.SupabaseClient {}

class MockGoTrueClient extends Mock implements supabase.GoTrueClient {}

class MockAuthResponse extends Mock implements supabase.AuthResponse {}

class MockInMemoryCacheClient extends Mock implements InMemoryCacheClient {}

class MockAuthState extends Mock implements supabase.AuthState {}

class MockSession extends Mock implements supabase.Session {}

class MockUser extends Mock implements supabase.User {}

void main() {
  const id = '123';
  const email = 'test@test.com';
  const password = 'password';
  const name = 'test-name';
  const createdAt = '02-11-2024T00:00:00.000Z';

  group('AuthenticationRepository', () {
    late supabase.SupabaseClient supabaseClient;
    late supabase.GoTrueClient goTrueClient;

    late supabase.AuthState authState;
    late supabase.User user;
    late supabase.Session session;

    late InMemoryCacheClient cacheClient;
    late AuthenticationRepository repository;

    setUp(() {
      supabaseClient = MockSupabaseClient();
      goTrueClient = MockGoTrueClient();

      authState = MockAuthState();
      user = MockUser();

      session = MockSession();
      cacheClient = MockInMemoryCacheClient();

      when(() => supabaseClient.auth).thenReturn(goTrueClient);

      repository = AuthenticationRepository(
        supabaseClient: supabaseClient,
        cacheClient: cacheClient,
      );
    });

    group('signUp', () {
      setUp(() {
        when(
          () => goTrueClient.signUp(
            password: any(named: 'password'),
            email: any(named: 'email'),
            data: any(named: 'data'),
          ),
        ).thenAnswer((_) async => Future.value(MockAuthResponse()));
      });

      test('calls the signUp method from supabase.auth', () async {
        await repository.signUp(name: name, email: email, password: password);
        verify(
          () => supabaseClient.auth.signUp(
            email: email,
            password: password,
            data: {'name': name},
          ),
        ).called(1);
      });

      test('succeeds when signUp method from supabase.auth succeeds', () async {
        expect(
          repository.signUp(name: name, email: email, password: password),
          completes,
        );
      });

      test(
          'throws SignUpWithEmailAndPasswordFailure when signUp method '
          'from supabase.auth throws', () async {
        when(
          () => goTrueClient.signUp(
            password: any(named: 'password'),
            email: any(named: 'email'),
            data: any(named: 'data'),
          ),
        ).thenThrow(Exception('oops'));
        expect(
          repository.signUp(name: name, email: email, password: password),
          throwsA(isA<SignUpWithEmailAndPasswordFailure>()),
        );
      });
    });

    group('signIn', () {
      setUp(() {
        when(
          () => goTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value(MockAuthResponse()));
      });

      test('calls the signIn method from supabase.auth', () async {
        await repository.signIn(email: email, password: password);
        verify(
          () => supabaseClient.auth.signInWithPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('succeeds when signIn method from supabase.auth succeeds', () {
        expect(
          repository.signIn(email: email, password: password),
          completes,
        );
      });

      test(
          'throws SignInWithEmailAndPasswordFailure when signIn method '
          'from supabase.auth throws', () async {
        when(
          () => goTrueClient.signInWithPassword(
            password: any(named: 'password'),
            email: any(named: 'email'),
          ),
        ).thenThrow(Exception('oops'));
        expect(
          repository.signIn(email: email, password: password),
          throwsA(isA<SignInWithEmailAndPasswordFailure>()),
        );
      });
    });

    group('signOut', () {
      setUp(() {
        when(() => goTrueClient.signOut()).thenAnswer((_) async {});
      });

      test('calls the signOut method from supabase.auth', () async {
        await repository.signOut();
        verify(() => supabaseClient.auth.signOut()).called(1);
      });

      test('succeeds when signOut method from supabase.auth succeeds', () {
        expect(repository.signOut(), completes);
      });

      test(
          'throws SignOutFailure when signOut method from '
          'supabase.auth throws', () async {
        when(() => goTrueClient.signOut()).thenThrow(Exception('oops'));
        expect(repository.signOut(), throwsA(isA<SignOutFailure>()));
      });
    });

    group('user', () {
      setUp(() {
        when(() => user.id).thenReturn('');
        when(() => session.user).thenReturn(user);
        when(() => authState.session).thenReturn(session);
        when(() => goTrueClient.onAuthStateChange)
            .thenAnswer((_) => Stream.value(authState));
      });

      test('emits User.empty when session is null', () async {
        when(() => authState.session).thenReturn(null);
        await expectLater(repository.user, emitsInOrder([User.empty]));
        verify(
          () => cacheClient.write(
            key: AuthenticationRepository.userCacheKey,
            value: User.empty,
          ),
        ).called(1);
      });

      test('emits User.empty when session user id is empty', () async {
        await expectLater(repository.user, emitsInOrder([User.empty]));
        verify(
          () => cacheClient.write(
            key: AuthenticationRepository.userCacheKey,
            value: User.empty,
          ),
        ).called(1);
      });

      test(
          'emits user when session is not null and session user id '
          'is not empty', () async {
        final supabaseUser = MockUser();

        when(() => supabaseUser.id).thenReturn(id);
        when(() => supabaseUser.email).thenReturn(email);
        when(() => supabaseUser.createdAt).thenReturn(createdAt);
        when(() => supabaseUser.userMetadata).thenReturn({'name': name});

        when(() => session.user).thenReturn(supabaseUser);

        final me = User(id: id, name: name, email: email, createdAt: createdAt);
        await expectLater(repository.user, emitsInOrder(<User>[me]));

        verify(
          () => cacheClient.write(
            key: AuthenticationRepository.userCacheKey,
            value: me,
          ),
        ).called(1);
      });
    });

    group('currentUser', () {
      test('returns User.empty when cached user is null', () {
        when(
          () => cacheClient.read(key: AuthenticationRepository.userCacheKey),
        ).thenReturn(null);
        expect(
          repository.currentUser,
          equals(User.empty),
        );
      });

      test('returns the user when cached user is not null', () {
        final me = User(id: id, name: name, email: email, createdAt: createdAt);
        when(
          () => cacheClient.read<User>(
            key: AuthenticationRepository.userCacheKey,
          ),
        ).thenReturn(me);
        expect(repository.currentUser, equals(me));
      });
    });
  });
}
