import 'package:breathin/core/constants/index.dart';
import 'package:breathin/core/constants/text_styles.dart';
import 'package:breathin/core/extensions/sizedbox_extension.dart';
import 'package:breathin/core/routes/routes.dart';
import 'package:breathin/core/widgets/custom_loader.dart';
import 'package:breathin/core/widgets/custom_text_field.dart';
import 'package:breathin/features/auth/signup/signup_view_modal.dart';

import '../../../../core/enums/view_state.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => ModalProgressHUD(
          inAsyncCall: model.state == ViewState.busy,
          progressIndicator: const CustomLoader(),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Sign Up",
                  style: kTextStyle3,
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Name Field
                      CustomTextField(
                        onChanged: (value) => model.userData =
                            model.userData.copyWith(name: value),
                        validator: (value) => model.validateName(value!),
                        labelText: "Name",
                        prefixIcon: const Icon(Icons.person),
                      ),

                      15.h.ph,

                      // Email Field
                      CustomTextField(
                        onChanged: (value) => model.userData =
                            model.userData.copyWith(email: value),
                        validator: (value) => model.validateEmail(value!),
                        keyboardType: TextInputType.emailAddress,
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.email),
                      ),

                      15.h.ph,

                      // Password Field
                      CustomTextField(
                        onChanged: (value) => model.password = value,
                        validator: (value) => model.validatePassword(value!),
                        obscureText: model.obscurePassword,
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(model.obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: model.togglePasswordVisibility,
                        ),
                      ),

                      15.h.ph,
                      // Confirm Password Field
                      CustomTextField(
                        validator: (value) => model.validateConfirmPassword(
                            model.password, value!),
                        obscureText: model.obscureConfirmPassword,
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(model.obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: model.toggleConfirmPasswordVisibility,
                        ),
                      ),

                      15.h.ph,
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: kTextStyle6,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: kTextStyle5,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  model.navigationService.nav
                                      .pushReplacementNamed(NamedRoute.signIn);
                                },
                            ),
                          ],
                        ),
                      ),
                      25.h.ph,

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            model.signUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "Sign Up",
                          style: kTextStyle5,
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
    );
  }
}
