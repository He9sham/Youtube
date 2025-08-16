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
  // Convert seconds to MM:SS format
  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // Format large numbers to K, M, B format
  String _formatViews(int views) {
    if (views >= 1000000000) {
      return '${(views / 1000000000).toStringAsFixed(1)}B';
    } else if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)}M';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    } else {
      return views.toString();
    }
  }

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
    searchVideos('despacito');
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
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final video = item['video'];
            final channel = item['channel'];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VideoItem(
                timeVideo: _formatDuration(
                  int.parse(video['lengthSeconds'].toString()),
                ),
                thumbnail: video['thumbnails'][1]['url'],
                channelName: video['author']['title'],
                timing: video['publishedTimeText'],
                views: _formatViews(
                  int.parse(video['stats']['views'].toString()),
                ),
                title: video['title'],
                channelImage: video['author']['avatar'][0]['url'],
              ),
            );
          },
        ),
      ),
    );
  }
}
