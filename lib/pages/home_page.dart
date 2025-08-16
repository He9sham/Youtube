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

    // Debug: Print the response structure
    print('API Response structure: ${json.keys.toList()}');

    final result = json['contents'] as List;

    // Debug: Print first item structure if available
    if (result.isNotEmpty) {
      print('First item structure: ${result.first.keys.toList()}');
      if (result.first['video'] != null) {
        print('Video keys: ${result.first['video'].keys.toList()}');
      }
    }

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
            onSubmitted: (value) {
              setState(() {
                searchVideos(value);
              });
            },
            onTap: () {},
          ),
        ),

        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final video = item['video'];
            final channel = item['channel'];

            // Skip items that don't have video data
            if (video == null) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: VideoItem(
                timeVideo: _formatDuration(
                  int.parse(video['lengthSeconds']?.toString() ?? '0'),
                ),
                thumbnail: video['thumbnails']?.isNotEmpty == true
                    ? video['thumbnails'][0]['url']
                    : '',
                channelName: video['author']?['title'] ?? '',
                timing: video['publishedTimeText'] ?? '',
                views: _formatViews(
                  int.parse(video['stats']?['views']?.toString() ?? '0'),
                ),
                title: video['title'] ?? '',
                channelImage: video['author']?['avatar']?.isNotEmpty == true
                    ? video['author']['avatar'][0]['url']
                    : '',
              ),
            );
          },
        ),
      ),
    );
  }
}
