import 'package:flutter/material.dart';

import '../../../../../core/constant/colors.dart';

class CustomDropDownGender extends StatelessWidget {
  final int gender;
  final void Function(int?)? onChanged;

  const CustomDropDownGender(
      {super.key, required this.gender, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
          hint: const Text("الجنس"),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
              filled: true,
              hintText: "الجنس",
              hintStyle: const TextStyle(
                fontFamily: "ArbFONTS-Almarai-Bold",
              ),
              fillColor: AppColors.secoundColorOne.withOpacity(0.7),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none)),
          items: const [
            DropdownMenuItem(
              value: 1,
              child: Text("أنثى"),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text("ذكر"),
            ),
          ],
          value: gender,
          onChanged: onChanged),
    );
  }
}
