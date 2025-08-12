import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/core/widgets/custom_text.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.controller,
    required this.onTap,
    required this.onSubmitted, required this.focusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function() onTap;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            cursorColor: Colors.white,
            placeholder: 'Search...',
            suffix: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.cancel_sharp, color: Colors.black54, size: 20),
            ),
            prefix: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                CupertinoIcons.search,
                color: Colors.black54,
                size: 19,
              ),
            ),
            placeholderStyle: TextStyle(color: Colors.black54),
            controller: controller,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            onTap: onTap,
            onSubmitted: onSubmitted,
          ),
        ),
        SizedBox(width: 15),
        Image.asset('assets/youtube_logo.png', width: 37),
        SizedBox(width: 15),
        CustomText(title: 'Youtube', fontWeight: FontWeight.bold),
      ],
    );
  }
}
