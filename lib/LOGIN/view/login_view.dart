import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_dashboard/CONSTANT/app_colors.dart';
import 'package:web_dashboard/CONSTANT/app_strings.dart';
import 'package:web_dashboard/CONSTANT/app_url.dart';
import 'package:web_dashboard/CUSTOM_WIDGETS/custom_text.dart';
import 'package:web_dashboard/CUSTOM_WIDGETS/custom_text_formfield.dart';
import 'package:web_dashboard/DASHBOARD/dash_board.dart';
import 'package:web_dashboard/LOGIN/repo/login_repository.dart';
import 'package:web_dashboard/SERVICES/alert_service.dart';

import '../bloc/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ValueNotifier<bool> isHide = ValueNotifier(true);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
              AppColors.backgroundColor,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: w > 800 ? 500 : w * 0.9),
              child: Card(
                color: AppColors.cardBg,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Image.network(
                            AppUrl.logoUrl,
                            height: w > 800 ? h * 0.15 : h * 0.1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: CustomText(
                            txt: "Welcome to Analytics Dashboard Login",
                            clr: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            size: 18,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFormField(
                          hintTxt: AppStrings.email,
                          manitTxt: AppStrings.email,
                          suffix: Icon(
                            Icons.email,
                            color: AppColors.primaryColor,
                          ),
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        ValueListenableBuilder(
                          valueListenable: isHide,
                          builder: (context, value, child) {
                            return CustomTextFormField(
                              hintTxt: AppStrings.password,
                              manitTxt: AppStrings.password,
                              obscure: value,
                              maxLn: 1,
                              controller: passwordController,
                              suffix: InkWell(
                                onTap: () {
                                  isHide.value = !isHide.value;
                                  print(value);
                                },
                                child: value == true
                                    ? Icon(
                                        Icons.remove_red_eye_outlined,
                                        color: AppColors.primaryColor,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye,
                                        color: AppColors.primaryColor,
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        RepositoryProvider(
                          create: (context) => LoginRepository(),
                          child: BlocProvider(
                            create: (context) => LoginBloc(
                              loginRepository:
                                  RepositoryProvider.of<LoginRepository>(
                                    context,
                                  ),
                            ),
                            child: BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is Authenticated) {
                                  AlertService().showSnackBar(
                                    context: context,
                                    msg: AppStrings.loginSuccess,
                                    isEr: false,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashBoardView(),
                                    ),
                                  );
                                } else if (state is LoginError) {
                                  print(state.message);
                                  AlertService().showSnackBar(
                                    context: context,
                                    msg: state.message,
                                    isEr: true,
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor:
                                          AppColors.backgroundColor,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<LoginBloc>().add(
                                          LoginRequested(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: CustomText(
                                      txt: AppStrings.login,
                                      clr: AppColors.backgroundColor,
                                      size: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
