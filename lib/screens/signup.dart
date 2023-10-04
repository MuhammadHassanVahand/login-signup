import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:signupform/customWidget/customFormBuilderText.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passordController = TextEditingController();
  bool obscureText = true;
  bool isSignup = false;

  signupAuth(emailAddress, password, formData) async {
    try {
      isSignup = true;
      setState(() {});
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      emailController.clear();
      passordController.clear();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign up successfull"),
        ),
      );
      isSignup = false;
      setState(() {});
      print(formData);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isSignup = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        isSignup = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("The account already exists for that email."),
          ),
        );
      }
    } catch (e) {
      isSignup = false;
      setState(() {});
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Stack(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomBuilderText(
                      formTextName: "full name",
                      labelText: "Full Name",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    CustomBuilderText(
                      controller: emailController,
                      formTextName: "email",
                      labelText: "Email",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    CustomBuilderText(
                      formTextName: "phone number",
                      labelText: "Phone Number",
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.minLength(10),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    CustomBuilderText(
                      controller: passordController,
                      formTextName: "password",
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(8),
                      ]),
                      obscureText: obscureText,
                    ),
                    const SizedBox(height: 20),
                    CustomBuilderText(
                      formTextName: "confirm_password",
                      labelText: "Confirm Password",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          _formKey.currentState?.fields['password']?.value !=
                                  value
                              ? "No Coinciden"
                              : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      obscureText: obscureText,
                    ),
                    const SizedBox(height: 20),
                    CustomBuilderDateOfBirth(
                      formFieldName: "date_of_birth",
                      labelText: "Date_of_Birth",
                      validator: (value) {
                        if (value == null) {
                          return 'Date of birth is required';
                        }

                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GenderDropdown(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final formData = _formKey.currentState!.value;
                          final emailAddress = formData["email"];
                          final password = formData["password"];
                          signupAuth(emailAddress, password, formData);
                        }

                        const CircularProgressIndicator();
                      },
                      child: Text('Sign Up'),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Visibility(
                          visible: isSignup,
                          child: const CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
        ),
      ),
    );
  }
}
