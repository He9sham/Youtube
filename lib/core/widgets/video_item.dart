import 'package:flutter/cupertino.dart';
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
            // Only show image if thumbnail URL is not empty
            if (thumbnail.isNotEmpty)
              Image.network(
                thumbnail,

                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CupertinoActivityIndicator()],
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Image not available',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              // Show placeholder when no thumbnail
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'No thumbnail',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
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
              // Improved channel image loading
              if (channelImage.isNotEmpty)
                CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: Image.network(
                      channelImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person, size: 20);
                      },
                    ),
                  ),
                )
              else
                CircleAvatar(radius: 20, child: Icon(Icons.person, size: 20)),

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
