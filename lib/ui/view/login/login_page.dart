import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/ui/widgets/button.dart';
import 'package:curiumlife/ui/widgets/edit_text_field.dart';
import 'package:curiumlife/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LogInPage extends ViewModelBuilderWidget<LogInViewModel>{

  @override
  Widget builder(BuildContext context, LogInViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: TapOutsideUnFocus(
          child: Form(
            key: viewModel.logInFormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0,right: 16.0, top: 20, bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Image.asset(Images.appLogo, width: MediaQuery.of(context).size.width,),

                      EditTextField(
                        "Login Id",
                        viewModel.loginIdController,
                        placeholder: "Enter your Login Id",
                        onChanged: (value){},
                        onSubmitted: (val){
                          viewModel.passwordController.focusNode.requestFocus();
                        },
                      ),

                      VerticalSpacing.custom(value: 15.0),

                      EditTextField.password(
                        "Password ",
                        viewModel.passwordController,
                        placeholder: "Enter your password",
                        onChanged: (value){},
                        onSubmitted: (val){
                          FocusNode().requestFocus();
                        },
                      ),
                      VerticalSpacing.custom(value: 20.0),

                      Button(
                          "Login",
                          key: const ValueKey("btnLogin"),
                          width: double.infinity,

                          isLoading: viewModel.state == ViewState.Busy,
                          onPressed: (){
                            if(viewModel.logInFormKey.currentState!.validate()){
                             viewModel.login();
                            }
                          }
                      ),

                      VerticalSpacing.custom(value: 25.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  LogInViewModel viewModelBuilder(BuildContext context) => LogInViewModel();

}
