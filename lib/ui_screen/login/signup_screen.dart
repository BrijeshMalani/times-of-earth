import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../Service/ApiService.dart';
import '../../common/constant.dart';
import '../../common/image_path.dart';
import '../../network_checker/network_cheker.dart';
import '../dashboard/dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ConnectivityProvider _connectivityProvider =
      Get.put(ConnectivityProvider());
  var uuid = const Uuid();
  final _formkey = GlobalKey<FormState>();
  var email = "";
  bool? isCheckedValue = true;

  final emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivityProvider.startMonitoring();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConnectivityProvider>(
        builder: (controller) {
          // if (controller.isOnline!) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(ImagePath.backgroundLogin),
              fit: BoxFit.fill,
            )),
            child: Form(
              key: _formkey,
              child: SizedBox(
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          const Text(
                            "Signup For Free",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'PoetsenOne'),
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: TextFormField(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'PoetsenOne'),
                              textAlign: TextAlign.center,
                              cursorRadius: Radius.zero,
                              validator: (value) {
                                if (!EmailValidator.validate(value!)) {
                                  return 'Invalid Email';
                                }
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color(0xFFC4C4C4).withOpacity(0.4),
                                contentPadding: EdgeInsets.zero,
                                hintText: "enter your email",
                                hintStyle: const TextStyle(
                                    color: Color(0xFFffffff),
                                    fontSize: 17,
                                    fontFamily: 'PoetsenOne',
                                    fontWeight: FontWeight.w500),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 3, color: Color(0xFF78B5DD)),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 3, color: Color(0xFF78B5DD)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 3, color: Color(0xFF78B5DD)),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.red),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 3, color: Color(0xFF78B5DD)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 35),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: InkWell(
                              onTap: () async {
                                try {
                                  if (_formkey.currentState!.validate()) {
                                    // LoadingDialog().showDialog();
                                    var result = await PostService.loginUser(
                                      reqBody: {
                                        "email": emailController.text,
                                        "uuid": "${Constant.osUserID}",
                                      },
                                    );

                                    if (result["flag"] == true) {
                                      print("LOGIN => $result");
                                      Constant.userSession = result["user_id"];
                                      Constant()
                                          .storage
                                          .write("id", "${result["user_id"]}");

                                      print(Constant.userSession);
                                      print("Constant.userSession");
                                      if (mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardScreen(),
                                          ),
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            "Something went wrong! Retry Login",
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }
                                  }
                                } catch (e) {
                                  print("Error: $e");
                                  Fluttertoast.showToast(
                                      msg: "Network Error! Please try again.");
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.blue.withOpacity(0.5),
                                      const Color(0xFFC576F6).withOpacity(0.7),
                                    ],
                                  ),
                                  border: Border.all(
                                    width: 3,
                                    color: const Color(0xFF78B5DD),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontFamily: 'PoetsenOne',
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CheckboxListTile(
                        title: const Text(
                          "agree with terms and conditions",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'PoetsenOne'),
                        ),
                        value: isCheckedValue,
                        contentPadding: const EdgeInsets.all(5),
                        activeColor: Colors.yellow,
                        onChanged: (newValue) {
                          setState(() {
                            isCheckedValue = newValue;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );

          //
          //
          //   //   SingleChildScrollView(
          //   //   child: Form(
          //   //     key: _formkey,
          //   //     child: Column(
          //   //       mainAxisAlignment: MainAxisAlignment.center,
          //   //       children: [
          //   //         const SizedBox(
          //   //           height: 30,
          //   //         ),
          //   //         Padding(
          //   //           padding: const EdgeInsets.all(20.0),
          //   //           child: Image(
          //   //             image: AssetImage(ImagePath.logo),
          //   //             width: 150,
          //   //             height: 150,
          //   //             fit: BoxFit.cover,
          //   //           ),
          //   //         ),
          //   //         Container(
          //   //           width: Get.width,
          //   //           padding: const EdgeInsets.symmetric(horizontal: 25),
          //   //           child: const CommonText(
          //   //             text: "Sign In",
          //   //             size: 26,
          //   //             color: Colors.black,
          //   //             weight: FontWeight.w500,
          //   //             textAlign: TextAlign.left,
          //   //           ),
          //   //         ),
          //   //         Container(
          //   //           width: Get.width,
          //   //           padding: const EdgeInsets.symmetric(horizontal: 25),
          //   //           child: const CommonText(
          //   //             text: "Enter your credentials to continue",
          //   //             size: 16,
          //   //             color: Colors.grey,
          //   //             textAlign: TextAlign.left,
          //   //           ),
          //   //         ),
          //   //         const SizedBox(height: 20),
          //   //         Padding(
          //   //           padding: const EdgeInsets.all(15.0),
          //   //           child: CommonTextField(
          //   //             validator: (value) {
          //   //               if (!EmailValidator.validate(value!)) {
          //   //                 return 'Invalid Email';
          //   //               }
          //   //             },
          //   //             controller: emailController,
          //   //             obSecure: false,
          //   //             label: 'Email',
          //   //             hint: 'Enter your email',
          //   //             hintcolor: Colors.grey,
          //   //           ),
          //   //         ),
          //   //         Container(
          //   //           width: Get.width,
          //   //           padding:
          //   //               const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          //   //           child: const CommonText(
          //   //             text:
          //   //                 "By continuing you agree to our Terms of Service and Privacy Policy.",
          //   //             size: 14,
          //   //             color: Colors.grey,
          //   //             textAlign: TextAlign.left,
          //   //           ),
          //   //         ),
          //   //         const SizedBox(
          //   //           height: 30,
          //   //         ),
          //   //         MaterialButton(
          //   //           onPressed: () async {
          //   //             if (_formkey.currentState!.validate()) {
          //   //               // LoadingDialog().showDialog();
          //   //               var result = await PostService.loginUser(
          //   //                 reqBody: {
          //   //                   "email": emailController.text,
          //   //                   "uuid": "${Constant.osUserID}",
          //   //                 },
          //   //               );
          //   //
          //   //               if (result["flag"] == true) {
          //   //                 print("LOGIN => $result");
          //   //                 Constant.userSession = result["user_id"];
          //   //                 Constant()
          //   //                     .storage
          //   //                     .write("id", "${result["user_id"]}");
          //   //
          //   //                 print(Constant.userSession);
          //   //                 print("Constant.userSession");
          //   //
          //   //                 Navigator.pushReplacement(
          //   //                   context,
          //   //                   MaterialPageRoute(
          //   //                     builder: (context) => const DashboardScreen(),
          //   //                   ),
          //   //                 );
          //   //               } else {
          //   //                 Fluttertoast.showToast(
          //   //                   msg: "Something went wrong! Retry Login",
          //   //                   gravity: ToastGravity.CENTER,
          //   //                 );
          //   //               }
          //   //             }
          //   //           },
          //   //           height: 56,
          //   //           minWidth: Get.width * .8,
          //   //           color: Colors.black,
          //   //           shape: const RoundedRectangleBorder(
          //   //             borderRadius: BorderRadius.all(
          //   //               Radius.circular(10),
          //   //             ),
          //   //           ),
          //   //           child: const Text(
          //   //             "Sign In",
          //   //             style: TextStyle(
          //   //               color: Colors.white,
          //   //               fontSize: 18,
          //   //               fontWeight: FontWeight.normal,
          //   //             ),
          //   //           ),
          //   //         ),
          //   //         const SizedBox(height: 10),
          //   //       ],
          //   //     ),
          //   //   ),
          //   // );
          // } else {
          //   return const NetworkError();
          // }
        },
      ),
    );
  }
}
