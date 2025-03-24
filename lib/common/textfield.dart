// import 'package:flutter/material.dart';
//
// class CommonTextField extends StatelessWidget {
//   TextEditingController? controller;
//   String? hint;
//   Color? hintcolor;
//   double? hintsize;
//   Widget? suffixIcon;
//   TextInputType? keyboardType;
//   dynamic maxLength;
//   dynamic textInputAction;
//   String? label;
//   Color? cursorColor;
//   final bool obSecure;
//   String? Function(String?)? validator;
//
//   CommonTextField(
//       {this.controller,
//       this.hint,
//       this.hintcolor,
//       this.hintsize,
//       this.suffixIcon,
//       this.keyboardType,
//       this.maxLength,
//       required this.obSecure,
//       this.label,
//       this.cursorColor = Colors.black,
//       this.textInputAction,
//       this.validator});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorColor: cursorColor,
//       textInputAction: textInputAction,
//       validator: validator ??
//           (value) {
//             if (value!.isEmpty) {
//               return '* required';
//             } else {
//               return null;
//             }
//           },
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLength: maxLength,
//       obscureText: obSecure,
//       decoration: InputDecoration(
//         suffixIcon: suffixIcon,
//         counterText: "",
//         hintText: hint,
//         hintStyle: TextStyle(
//           color: hintcolor,
//           fontSize: hintsize,
//         ),
//         labelText: label,
//         fillColor: Colors.transparent,
//         filled: true,
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//         // enabledBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.grey),
//         // ),
//         // focusedBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.grey),
//         // ),
//         // errorBorder: OutlineInputBorder(
//         //   borderSide: BorderSide(color: Colors.grey),
//         // ),
//       ),
//     );
//   }
// }
