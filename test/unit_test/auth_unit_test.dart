import 'package:bigtalk/features/auth/domain/use_case/login_usecase.dart';
import 'package:bigtalk/features/auth/domain/use_case/register_usecase.dart';
import 'package:bigtalk/features/auth/presentation/auth_viewmodel/auth_viewmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginUseCase>(),
  MockSpec<RegisterUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late LoginUseCase loginUseCase;
  late RegisterUseCase registerUseCase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    loginUseCase = MockLoginUseCase();
    registerUseCase = MockRegisterUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(registerUseCase, loginUseCase),
        ),
      ],
    );
  });

  test('check for the initial state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  test('Login test with valid user', () async {
    when(loginUseCase.loginUser('kafle.susan671@outlook.com', 'susan123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(loginUseCase.loginUser('kafle.susan671@outlook.com', 'sdas'))
        .thenAnswer((_) => Future.value(const Right(false)));
        
    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'kafle.susan671@outlook.com', 'susan123');
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });
}
