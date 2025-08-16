import 'package:flutter/material.dart';
import 'package:youtube_app/core/widgets/custom_text.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.channelName,
    required this.timing,
    required this.views,
    required this.channelImage,
    required this.timeVideo,
  });
  final String thumbnail,
      title,
      channelName,
      timing,
      views,
      channelImage,
      timeVideo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Image.network(
              thumbnail,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.black54,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                color: Colors.black54,
                child: CustomText(
                  title: timeVideo,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(radius: 20, child: Image.network(channelImage)),

              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(title: title, fontWeight: FontWeight.w400),
                    CustomText(
                      title: '$channelName    $views views   $timing',
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
