import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_dashboard/LOGIN/model/login_model.dart';
import 'package:web_dashboard/LOGIN/repo/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {

    on(login);
    on(logout);
  }


  login(LoginRequested event, Emitter<LoginState> emit)async{
    emit(LoginLoading());
    try {
      UserLoginModel userLoginModel = await loginRepository.logIn(email: event.email, password: event.password);
      emit(Authenticated(loginModel: userLoginModel ));
    } catch (e) {
      print(e);
      emit(LoginError("Login failed: ${e.toString()}"));
    }
  }

  logout(LogoutRequested event , Emitter<LoginState> emit)async{
    await loginRepository.logOut();
    emit(Unauthenticated());
  }
}
