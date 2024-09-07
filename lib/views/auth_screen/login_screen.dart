import 'package:accident_response_app/consts/consts.dart';
import 'package:accident_response_app/consts/list.dart';
import 'package:accident_response_app/views/auth_screen/signup_screen.dart';
import 'package:accident_response_app/views/home_screen/home_screen.dart';
import 'package:accident_response_app/widgets_common/applogo_widget.dart';
import 'package:accident_response_app/widgets_common/bg_widget.dart';
import 'package:accident_response_app/widgets_common/custom_textfield.dart';
import 'package:accident_response_app/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [

              (context.screenHeight*0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Welcome Back!".text.fontFamily(bold).white.size(30).make(),
              30.heightBox,
              Column(
                children: [
                  customTextField(hint:emailHint,title: mobnumber),
                  customTextField(hint:passwordHint,title: password),
                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {}, child: forgetPass.text.make())),
                    5.heightBox,
                   // ourButton().box.width(context.screenWidth-50).make()
                   ourButton(color: redColor, title: login, textColor: whiteColor, onPress: (){
                    Get.to(()=> const MeasureDistanceApp());
                   })
                   
                   .box
                   .width(context.screenWidth - 50)
                   .make(),
                   20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      createNewAccount.text.color(fontGrey).fontFamily(bold).make(),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignupScreen());
                        },
                        child: "Sign Up".text.color(redColor).fontFamily(bold).minFontSize(15).make(),
                      ),
                    ],
                  ),
                   50.heightBox,
                   loginwith.text.color(fontGrey).size(15).make(),
                   5.heightBox,
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index)=> Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(
                          socialIconList[index],
                          width: 30,
                          ),
                        
                      ),
                    )),
                   )
                ],
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make()
            ]),
        ),
      )
    );
  }
}