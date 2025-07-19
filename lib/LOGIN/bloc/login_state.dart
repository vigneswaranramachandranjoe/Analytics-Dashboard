part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}


class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Authenticated extends LoginState {
  UserLoginModel loginModel;
  Authenticated({required this.loginModel});
  @override
  // TODO: implement props
  List<Object?> get props => [loginModel];
}

class Unauthenticated extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
