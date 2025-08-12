import 'package:flutter/material.dart';
import 'package:youtube_app/core/widgets/appbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: AppbarWidget(
            focusNode: focusNode,
            controller: controller,
            onSubmitted: (value) {},
            onTap: () {},
          ),
        ),
        
      ),
    );
  }
}
