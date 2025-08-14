import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_app/constans.dart';
import 'package:youtube_app/core/widgets/appbar_widget.dart';
import 'package:youtube_app/core/widgets/video_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  List items = [];
  // search Video
  Future<void> searchVideos(String keyWord) async {
    final uri = '${AppConsts.baseUrl}/search/?q=$keyWord&hl=en&gl=US';

    final url = Uri.parse(uri);

    final response = await http.get(url, headers: AppConsts.headers);

    final json = jsonDecode(response.body) as Map;

    final result = json['contents'] as List;
    setState(() {
      items = result;
    });
  }

  @override
  void initState() {
    searchVideos('flutter');
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

        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VideoItem(
                thumbnail:
                    'https://plus.unsplash.com/premium_photo-1664392147011-2a720f214e01?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D',
                channelName: 'Hesham',
                timing: '8 day ago',
                views: '490k',
                title: 'Movie',
              ),
            );
          },
        ),
      ),
    );
  }
}
