import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rivo_app/core/enum/device_type.dart';
import 'package:rivo_app/core/functions/validat.dart';
import 'package:rivo_app/features/auth/domain/usecases/register.dart';
import 'package:rivo_app/features/auth/presentation/register/bloc/register_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/images.dart';
import '../../../../../core/constant/info_widget.dart';
import '../../../../../core/constant/routes.dart';
import '../../../../../core/constant/toast.dart';
import '../../../../../core/widgets/background_auth.dart';
import '../../../../../core/widgets/text_form_faild.dart';
import '../../login/widgets/botton.dart';
import '../../login/widgets/text_rigester_account.dart';
import '../widgets/drop_down_city.dart';
import '../widgets/drop_down_gender.dart';
import '../widgets/faild_date_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late int gender;
  late int city;
  late RegisterBloc registerBloc;
  late final TextEditingController userNameController;
  late final TextEditingController passwordController;
  late final TextEditingController fullNameController;
  late final TextEditingController dateOfBrithController;
  late final TextEditingController passwordConfirmationController;
  late final TextEditingController phoneController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    gender = 1;
    city = 1;
    registerBloc = RegisterBloc();
    phoneController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
    fullNameController = TextEditingController();
    dateOfBrithController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    super.initState();
  }

  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registerBloc,
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
            builder: ((context, state) {
          return Center(
            child: InfoWidget(builder: (context, deviceType) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  const BackGroundAuthScreen(),
                  deviceType.deviceType==DeviceType.Mobile?
                   Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: deviceType.localHeight! / 3,
                              width: deviceType.localWidth! / 2.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.logoGreen,
                                    color: AppColors.textColorBlack,
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
                                        fontFamily:
                                            "ArbFONTS-Almarai-ExtraBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            deviceType.localHeight! * 0.05),
                                  ),
                                  Text(
                                    "إنشاء حساب",
                                    style: TextStyle(
                                        color: AppColors.primaryColorGreen,
                                        fontFamily:
                                            "ArbFONTS-Almarai-ExtraBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            deviceType.localHeight! * 0.03),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceType.localHeight! / 2,
                          width: deviceType.localWidth! / 1.5,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               
                                CustomTextFormFaild(
                                    hintText: "الاسم الكامل",
                                    textEditingController: fullNameController,
                                    validator: (val) {
                                      return validator(
                                          val!, 3, 20, "Full Name");
                                    }),
                                CustomDatePickerFaild(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            lastDate: DateTime(2024))
                                        .then((value) {
                                      BlocProvider.of<RegisterBloc>(context)
                                          .add(ChangeRegisterFailed(
                                              dateOfBrith: value.toString()));
                                      dateOfBrithController.text =
                                          value.toString();
                                    });
                                  },
                                  hintText: state.dateOfBrith,
                                  textEditingController: dateOfBrithController,
                                  validator: (val) {
                                    return null;
                                  },
                                ),
                                CustomDropDownGender(
                                    gender: gender,
                                    onChanged: (val) {
                                      log("val= ${val.toString()}");
                                      gender = val!;
                                      log("gender= ${gender.toString()}");
                                    }),
                                CustomDropDownCities(
                                  city: city,
                                  onChanged: (val) {
                                    city = val!;
                                  },
                                ),
                                CustomTextFormFaild(
                                    hintText: "اسم المستخدم",
                                    textEditingController: userNameController,
                                    validator: (val) {
                                      return validator(
                                          val!, 3, 10, "user name");
                                    }),
                                CustomTextFormFaild(
                                    hintText: "رقم الهاتف",
                                    textEditingController: phoneController,
                                    validator: (val) {
                                      return validator(
                                          val!, 3, 20, "Phone Number");
                                    }),
                                CustomTextFormFaild(
                                    obscureText: true,
                                    hintText: "كلمة المرور",
                                    textEditingController: passwordController,
                                    validator: (val) {
                                      return validator(val!, 8, 30, "password");
                                    }),
                                CustomTextFormFaild(
                                    obscureText: true,
                                    hintText: "تأكيد كلمةالمرور",
                                    textEditingController:
                                        passwordConfirmationController,
                                    validator: (val) {
                                      return validator(
                                          val!, 8, 30, "password Confirmation");
                                    }),
                              
                                
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: deviceType.localWidth!/1.5,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: [CustomBottonAuth(
                                      title: "إنشاء حساب",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<RegisterBloc>(context)
                                              .add(GetRegisterEvent(
                                                  registerParams: RegisterParams(
                                                      phone: phoneController.text,
                                                      gender: gender,
                                                      cityId: city,
                                                      dateOfBirth:
                                                          dateOfBrithController
                                                              .text,
                                                      fullname:
                                                          fullNameController.text,
                                                      password:
                                                          passwordController.text,
                                                      passwordConfirmation:
                                                          passwordConfirmationController
                                                              .text,
                                                      username: userNameController
                                                          .text)));
                                        }
                                      },
                                      deviceInfo: deviceType),
                                      
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: CustomTextQuestionAuth(
                                      textAuthType: "تسجيل الدخول",
                                      textQuestion: "لديك حساب بالفعل؟",
                                      onPressed: () {
                                        context.pop();
                                      },
                                    ),
                                  )],),
                        )
                      ],
                    ),
                  )
                  :Form(
                    key: _formKey,
                    child: SizedBox(
                      height: deviceType.localHeight! / 0.5,
                      width: deviceType.localWidth! / 0.5,
                      child: Column(
                        children: [
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "إنشاء حساب ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.primaryColorGreen,
                                        fontFamily:
                                            "ArbFONTS-Almarai-ExtraBold",
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            deviceType.localHeight! * 0.05),
                                  ),
                                  SizedBox(
                                    height: deviceType.localHeight! / 2.3,
                                    width: deviceType.localWidth! / 2,
                                    child: GridView(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 5,
                                              crossAxisSpacing: 5),
                                      children: [
                                        CustomTextFormFaild(
                                            hintText: "الاسم الكامل",
                                            textEditingController:
                                                fullNameController,
                                            validator: (val) {
                                              return validator(
                                                  val!, 3, 20, "Full Name");
                                            }),
                                        CustomDatePickerFaild(
                                          onTap: () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime(2024))
                                                .then((value) {
                                              BlocProvider.of<RegisterBloc>(
                                                      context)
                                                  .add(ChangeRegisterFailed(
                                                      dateOfBrith:
                                                          value.toString()));
                                              dateOfBrithController.text =
                                                  value.toString();
                                            });
                                          },
                                          hintText: state.dateOfBrith,
                                          textEditingController:
                                              dateOfBrithController,
                                          validator: (val) {
                                            return null;
                                          },
                                        ),
                                        CustomDropDownGender(
                                            gender: gender,
                                            onChanged: (val) {
                                              log("val= ${val.toString()}");
                                              gender = val!;
                                              log("gender= ${gender.toString()}");
                                            }),
                                        CustomDropDownCities(
                                          city: city,
                                          onChanged: (val) {
                                            city = val!;
                                          },
                                        ),
                                        CustomTextFormFaild(
                                            hintText: "اسم المستخدم",
                                            textEditingController:
                                                userNameController,
                                            validator: (val) {
                                              return validator(
                                                  val!, 3, 10, "user name");
                                            }),
                                        CustomTextFormFaild(
                                            hintText: "رقم الهاتف",
                                            textEditingController:
                                                phoneController,
                                            validator: (val) {
                                              return validator(
                                                  val!, 10, 20, "Phone Number");
                                            }),
                                        CustomTextFormFaild(
                                            obscureText: true,
                                            hintText: "كلمة المرور",
                                            textEditingController:
                                                passwordController,
                                            validator: (val) {
                                              return validator(
                                                  val!, 8, 30, "password");
                                            }),
                                        CustomTextFormFaild(
                                            obscureText: true,
                                            hintText: "تأكيد كلمةالمرور",
                                            textEditingController:
                                                passwordConfirmationController,
                                            validator: (val) {
                                              return validator(val!, 8, 30,
                                                  "password Confirmation");
                                            }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  SizedBox(
                                    width: deviceType.localWidth! / 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomBottonAuth(
                                            title: "إنشاء حساب",
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<RegisterBloc>(
                                                        context)
                                                    .add(GetRegisterEvent(
                                                        registerParams: RegisterParams(
                                                            phone: phoneController
                                                                .text,
                                                            gender: gender,
                                                            cityId: city,
                                                            dateOfBirth:
                                                                dateOfBrithController
                                                                    .text,
                                                            fullname:
                                                                fullNameController
                                                                    .text,
                                                            password:
                                                                passwordController
                                                                    .text,
                                                            passwordConfirmation:
                                                                passwordConfirmationController
                                                                    .text,
                                                            username:
                                                                userNameController
                                                                    .text)));
                                              }
                                            },
                                            deviceInfo: deviceType),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 2),
                                          child: CustomTextQuestionAuth(
                                            textAuthType: "تسجيل الدخول",
                                            textQuestion: "لديك حساب بالفعل؟",
                                            onPressed: () {
                                              context.pop();
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: deviceType.localHeight! / 3,
                                    width: deviceType.localWidth! / 2.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.logoGreen,
                                          color: AppColors.textColorBlack,
                                          allowDrawingOutsideViewBox: true,
                                          height: deviceType.localHeight! / 6,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Rivo App",
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              fontFamily:
                                                  "ArbFONTS-Almarai-ExtraBold",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  deviceType.localHeight! *
                                                      0.05),
                                        ),
                                        Text(
                                          "إنشاء حساب",
                                          style: TextStyle(
                                              color:
                                                  AppColors.primaryColorGreen,
                                              fontFamily:
                                                  "ArbFONTS-Almarai-ExtraBold",
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  deviceType.localHeight! *
                                                      0.03),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        }), listener: (context, state) {
          if (state.registerStatus == RegisterStatus.loading) {
            log("success loading");
            Toast.showLoading();
          } else if (state.registerStatus == RegisterStatus.failure) {
            log("failur loading");
            Toast.closeAllLoading();
            Toast.showText(text: state.message);
          } else if (state.registerStatus == RegisterStatus.success) {
            log("success ui");
            Toast.closeAllLoading();
            context.pushNamed(AppRouter.splashScreen);
          }
        }),
      ),
    );
  }
}

