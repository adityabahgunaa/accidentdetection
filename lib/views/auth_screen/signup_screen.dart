import 'package:accident_response_app/consts/consts.dart';
import 'package:accident_response_app/widgets_common/applogo_widget.dart';
import 'package:accident_response_app/widgets_common/bg_widget.dart';
import 'package:accident_response_app/widgets_common/custom_textfield.dart';
import 'package:accident_response_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischeck = false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Allow resizing when the keyboard appears
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Add padding to prevent overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                children: [
                   // Reduce top spacing
                  applogoWidget(),
                  30.heightBox,
                  "Sign Up!".text.fontFamily(bold).white.size(22).make(),
                  10.heightBox,
                  Column(
                    children: [
                      customTextField(hint: nameHint, title: name),
                      customTextField(hint: emailHint, title: mobnumber),
                      customTextField(hint: passwordHint, title: password),
                      customTextField(hint: passwordHint, title: retypePassword),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: forgetPass.text.make(),
                        ),
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          Checkbox(
                            activeColor: redColor,
                            checkColor: whiteColor,
                            value: ischeck,
                            onChanged: (newValue) {
                              setState(() {
                                ischeck = newValue;
                              });
                            },
                          ),
                          Expanded( // Allows the RichText to take only available space
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: termAndcond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      5.heightBox,
                      ourButton(
                        color: ischeck == true ? redColor : lightGrey,
                        title: signup,
                        textColor: whiteColor,
                        onPress: (
                            //TODO : go to the next screen for OTP verification then next screen to clicking picture
                            ) {},
                      ).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: alreadyHaveAccount,
                              style: TextStyle(fontFamily: bold, color: fontGrey),
                            ),
                            TextSpan(
                              text: login,
                              style: TextStyle(fontFamily: bold, color: redColor),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Get.back();
                      }),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
