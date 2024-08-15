
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_hng11/features/auth/providers/auth.provider.dart';
import 'package:flutter_boilerplate_hng11/features/auth/screen/company_signup_screen.dart';
import 'package:flutter_boilerplate_hng11/features/auth/screen/forgot_password.dart';
import 'package:flutter_boilerplate_hng11/features/auth/screen/single_user_signup.dart';
import 'package:flutter_boilerplate_hng11/utils/global_colors.dart';
import 'package:flutter_boilerplate_hng11/utils/validator.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/custom_button.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/custom_snackbar.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/custom_text_field.dart';
import 'package:flutter_boilerplate_hng11/utils/widgets/password_textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static final TextEditingController _emailController = TextEditingController();

  static final TextEditingController _passwordController =
      TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final isChecked = ref.watch(checkBoxState);
    final authStateProvider = ref.watch(authProvider);
  //  final loadingGoogle = ref.watch(loadingGoogleButton);


    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48.h,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.inter(
                      color: const Color(0xFF141414),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  "Welcome back, please enter your details",
                  style: GoogleFonts.inter(
                      color: GlobalColors.darkOne,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 28.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: const BorderSide(color: Colors.grey),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    onPressed: () {
                      ref.read(authProvider.notifier).googleSignin(context);
                    },
                    child: authStateProvider.googleButtonLoading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2.w,
                            ),
                          )
                        : Image.asset(
                            'assets/images/google.png',
                            fit: BoxFit.contain,
                            width: 200.w,
                          ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 105.w, child: const Divider()),
                    const Spacer(),
                    Text(
                      "or continue with",
                      style: GoogleFonts.inter(
                          color: GlobalColors.darkOne,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    SizedBox(width: 105.w, child: const Divider()),
                  ],
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomTextField(
                  label: "Email",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter your email",
                  validator: (v) => Validators.emailValidator(v),
                ),
                SizedBox(
                  height: 16.h,
                ),
                PasswordTextField(
                  label: "Password",
                  controller: _passwordController,
                  hintText: "Enter your password",
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () {
                            ref.read(authProvider.notifier).setCheckBoxState =
                           !authStateProvider.checkBoxState;
                          },
                          child: Icon(
                            authStateProvider.checkBoxState
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: authStateProvider.checkBoxState
                                ? GlobalColors.orange
                                : GlobalColors.darkOne,
                          ),
                        )),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "Remember Me",
                      style: GoogleFonts.inter(
                          color: const Color(0XFF0A0A0A),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen()),
                        );
                        //:TODO add function for forgot password
                      },
                      child: Text(
                        "Forgot Passworud?",
                        style: GoogleFonts.inter(
                            color: GlobalColors.orange,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomButton(
                    loading: authStateProvider.normalButtonLoading,
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        ref.read(authProvider.notifier).login({
                          'email': _emailController.text,
                          'password': _passwordController.text,
                        }, context);
                      }
                    },
                    borderColor: GlobalColors.borderColor,
                    text: "Login",
                    height: 48.h,
                    containerColor: GlobalColors.orange,
                    width: 342.w,
                    textColor: Colors.white),
                SizedBox(
                  height: 8.h,
                ),
                // CustomButton(
                //     onTap: () {},
                //     borderColor: GlobalColors.borderColor,
                //     text: "Use Magic Link instead",
                //     height: 48.h,
                //     containerColor: Colors.white,
                //     width: 342.w,
                //     textColor: GlobalColors.darkOne),
                const SizedBox(
                  height: 23.5,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: TextStyle(color: GlobalColors.darkOne),
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                                color: GlobalColors.orange,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleUserSignUpScreen()),
                                );
                              }),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 49.h,
                ),
                SizedBox(
                  width: 342.w,
                  height: 48.h,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By logging in, you agree with our ',
                      style: GoogleFonts.inter(
                          color: GlobalColors.bgsurface700,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                          text: 'Terms & \nUse ',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: GlobalColors.orange,
                              fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: 'and ',
                          style: GoogleFonts.inter(
                            color: GlobalColors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy.',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: GlobalColors.orange,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

//SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 48.h,
//                 ),
//                 Text(
//                   "Login",
//                   style: GoogleFonts.inter(
//                       color: const Color(0xFF141414),
//                       fontSize: 24.sp,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 Text(
//                   "Welcome back, please enter your details",
//                   style: GoogleFonts.inter(
//                       color: GlobalColors.darkOne,
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(
//                   height: 28.h,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     //:TODO add google sign up feature
//                   },
//                   child: Container(
//                     height: 52.h,
//                     width: 342.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       border: Border.all(color: GlobalColors.borderColor),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             // kindly uncomment the code below when the login screen has been changed to a consumer stateless widget
//                             //  ref.read(authProvider.notifier).googleSignin(context);
//                           },
//                           child: SizedBox(
//                               height: 24.h,
//                               width: 24.w,
//                               child:
//                                   Image.asset("assets/images/googleIcon.png")),
//                         ),
//                         SizedBox(
//                           width: 10.w,
//                         ),
//                         Text(
//                           "Google",
//                           style: GoogleFonts.inter(
//                               fontSize: 16.sp, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(width: 105.w, child: const Divider()),
//                     const Spacer(),
//                     Text(
//                       "or continue with",
//                       style: GoogleFonts.inter(
//                           color: GlobalColors.darkOne,
//                           fontSize: 13.sp,
//                           fontWeight: FontWeight.w400),
//                     ),
//                     const Spacer(),
//                     SizedBox(width: 105.w, child: const Divider()),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 28.h,
//                 ),
//                 CustomTextField(
//                   label: "Email",
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   hintText: "Enter your email",
//                   validator:(v)=> Validators.emailValidator(v),
//                 ),
//                 SizedBox(
//                   height: 16.h,
//                 ),
//                 CustomTextField(
//                   label: "Password",
//                   obscureText: true,
//                   controller: _passwordController,
//                   hintText: "Enter your password",
//                   suffixIcon: const Icon(Icons.visibility_off),
//                 ),
//                 SizedBox(
//                   height: 16.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Container(
//                         padding: EdgeInsets.zero,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isChecked = !isChecked;
//                             });
//                           },
//                           child: Icon(
//                             isChecked
//                                 ? Icons.check_box
//                                 : Icons.check_box_outline_blank,
//                             color: isChecked
//                                 ? GlobalColors.orange
//                                 : GlobalColors.darkOne,
//                           ),
//                         )),
//                     SizedBox(
//                       width: 8.w,
//                     ),
//                     Text(
//                       "Remember Me",
//                       style: GoogleFonts.inter(
//                           color: const Color(0XFF0A0A0A),
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const ForgotPasswordScreen()),
//                         );
//                         //:TODO add function for forgot password
//                       },
//                       child: Text(
//                         "Forgot Password?",
//                         style: GoogleFonts.inter(
//                             color: GlobalColors.orange,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400),
//                       ),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 32.h,
//                 ),
//                 CustomButton(
//                     onTap: () async {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         setState(() {
//                           isLoading = false;
//                         });
//                         try {
//                           final response = await authApi.loginUser(
//                               {
//                             'email': _emailController.text,
//                             'password': _passwordController.text
//                           });
//                           if (response != null) {
//                             //Navigate to the next screen
//                           }
//                         } catch (e) {
//                           debugPrint(
//                               'Error occured during login: ${e.toString()}');
//                         } finally {
//                           setState(() {
//                             isLoading = false;
//                           });
//                         }
//                       }
//
//                       //:TODO
//                       // add logic for login
//                     },
//                     borderColor: GlobalColors.borderColor,
//                     text: "Login",
//                     height: 48.h,
//                     containerColor: GlobalColors.orange,
//                     width: 342.w,
//                     textColor: Colors.white),
//                 SizedBox(
//                   height: 8.h,
//                 ),
//                 CustomButton(
//                     onTap: () {},
//                     borderColor: GlobalColors.borderColor,
//                     text: "Use Magic Link instead",
//                     height: 48.h,
//                     containerColor: Colors.white,
//                     width: 342.w,
//                     textColor: GlobalColors.darkOne),
//                 const SizedBox(
//                   height: 23.5,
//                 ),
//                 Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Don\'t have an account? ',
//                       style: TextStyle(color: GlobalColors.darkOne),
//                       children: [
//                         TextSpan(
//                             text: 'Sign Up',
//                             style: TextStyle(
//                                 color: GlobalColors.orange,
//                                 fontWeight: FontWeight.bold),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           CompanySignUpScreen()),
//                                 );
//                               }),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 49.h,
//                 ),
//                 SizedBox(
//                   width: 342.w,
//                   height: 48.h,
//                   child: RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                       text: 'By logging in, you agree with our ',
//                       style: GoogleFonts.inter(
//                           color: GlobalColors.bgsurface700,
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.w400),
//                       children: [
//                         TextSpan(
//                           text: 'Terms & \nUse ',
//                           style: GoogleFonts.inter(
//                               fontSize: 14.sp,
//                               color: GlobalColors.orange,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         TextSpan(
//                           text: 'and ',
//                           style: GoogleFonts.inter(
//                             color: GlobalColors.black,
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'Privacy Policy.',
//                           style: GoogleFonts.inter(
//                               fontSize: 14.sp,
//                               color: GlobalColors.orange,
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
