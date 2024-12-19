import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rivo_app/core/constant/toast.dart';
import 'package:rivo_app/core/enum/device_type.dart';
import 'package:rivo_app/core/functions/validat.dart';
import 'package:rivo_app/core/widgets/logo_auth.dart';
import 'package:rivo_app/core/widgets/text_form_faild.dart';
import 'package:rivo_app/features/auth/domain/usecases/login.dart';
import 'package:rivo_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:rivo_app/features/auth/presentation/login/widgets/botton.dart';
import 'package:rivo_app/features/auth/presentation/login/widgets/text_rigester_account.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/info_widget.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/widgets/background_auth.dart';
import '../widgets/text_reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    loginBloc = LoginBloc();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Directionality(
          textDirection: TextDirection.rtl,
          child:
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            if (state.loginStatus == LoginStatus.loading) {
              log("success loading");
              Toast.showLoading();
            } else if (state.loginStatus == LoginStatus.failure) {
              log("failur loading");
              Toast.closeAllLoading();
              Toast.showText(text:state.message);
            } else if (state.loginStatus == LoginStatus.success) {
              log("success ui");
              Toast.closeAllLoading();
              context.pushNamed(AppRouter.splashScreen);
            }
          }, builder: ((context, state) {
            return Scaffold(
              body: InfoWidget(builder: (context, deviceType) {
                return Form(
                  key: _formKey,
                  child:deviceType.deviceType==DeviceType.Mobile? Stack(
                    alignment: Alignment.center,
                    children: [
                      const BackGroundAuthScreen(),
                      const CustomLogoAuth(authTypeName: "تسجيل الدخول"),
                      InfoWidget(builder: (context, devicetype) {
                        return SizedBox(
                          height: deviceType.localHeight,
                          width: deviceType.localWidth! / 1.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomBottonAuth(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<LoginBloc>(context).add(
                                        GetLoginEvent(LoginParams(
                                            username: userNameController.text,
                                            password:
                                                passwordController.text)));
                                  }
                                },
                                deviceInfo: deviceType,
                                title: 'تسجيل الدخول',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: CustomTextQuestionAuth(
                                  onPressed: () {
                                    context.pushNamed(AppRouter.register);
                                  },
                                  textQuestion: 'ليس لديك حساب؟',
                                  textAuthType: "أنشئ حساب",
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: deviceType.localWidth! / 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormFaild(
                                hintText: "اسم المستخدم",
                                textEditingController: userNameController,
                                validator: (val) {
                                  return validator(val!, 3, 20, "Name");
                                }),
                            CustomTextFormFaild(
                                obscureText: true,
                                hintText: "كلمة المرور",
                                textEditingController: passwordController,
                                validator: (val) {
                                  return validator(val!, 5, 20, "Password");
                                }),
                            CustomTextResetPassword(onPressed: () {}),
                          ],
                        ),
                      ),
                    ],
                  ):Stack(
                    alignment: Alignment.center,
                    children: [
                      const BackGroundAuthScreen(),
                      SizedBox(
                        width: deviceType.localWidth! / 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: deviceType.localWidth! / 4,
                              height: deviceType.localHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacer(flex: 2,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "تسجيل الدخول",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.primaryColorGreen,
                                            fontFamily:
                                                "ArbFONTS-Almarai-ExtraBold",
                                            fontWeight: FontWeight.bold,
                                            
                                            fontSize:
                                                deviceType.localHeight! * 0.05),
                                      ),
                                    ],
                                  ),
                                   SizedBox(
                                    height: deviceType.localHeight! * 0.05,
                                  ),
                                  CustomTextFormFaild(
                                      hintText: "اسم المستخدم",
                                      textEditingController: userNameController,
                                      validator: (val) {
                                        return validator(val!, 3, 20, "Name");
                                      }),
                                  CustomTextFormFaild(
                                      obscureText: true,
                                      hintText: "كلمة المرور",
                                      textEditingController: passwordController,
                                      validator: (val) {
                                        return validator(
                                            val!, 5, 20, "Password");
                                      }),
                                  CustomTextResetPassword(onPressed: () {}),
                                  Spacer(flex: 1,),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CustomBottonAuth(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(GetLoginEvent(LoginParams(
                                                    username:
                                                        userNameController.text,
                                                    password: passwordController
                                                        .text)));
                                          }
                                        },
                                        deviceInfo: deviceType,
                                        title: 'تسجيل الدخول',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        child: CustomTextQuestionAuth(
                                          onPressed: () {
                                            context
                                                .pushNamed(AppRouter.register);
                                          },
                                          textQuestion: 'ليس لديك حساب؟',
                                          textAuthType: "أنشئ حساب",
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(flex: 2,),
                                  
                                ],
                              ),
                            ),
                            SizedBox(
                                height: deviceType.localHeight! / 3,
                                          width: deviceType.localWidth! / 2.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.logoGreen,
                                    allowDrawingOutsideViewBox: true,
                                    height: deviceType.localHeight! / 6,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Rivo App",
                                    style: TextStyle(
                                        color: AppColors.primaryColorGreen,
                                        fontFamily: "ArbFONTS-Almarai-ExtraBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize: deviceType.localHeight! * 0.04),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            );
          }))),
    );
  }
}
