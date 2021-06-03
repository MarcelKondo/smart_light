import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chewieListItem.dart';

class TutorialCard extends StatefulWidget {
  final String text;
  TutorialCard({this.text});

  @override
  _TutorialCardState createState() => _TutorialCardState();
}

class _TutorialCardState extends State<TutorialCard> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.play_arrow),
              InkWell(
                onTap: () {
                  setState(() {
                    check = !check;
                  });
                },
                child: Checkbox(
                    value: check,
                    onChanged: (bool value) {
                      setState(() {
                        check = !check;
                      });
                    }),
              ),
              Text(widget.text),
              SizedBox()
            ],
          ),
        ),
        children: [
          ChewieListItem(
            videoPlayerController: VideoPlayerController.asset(
              'videos/IntroVideo.mp4',
            ),
          ),
        ],
      ),
    );
  }
}
