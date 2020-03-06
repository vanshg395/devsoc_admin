import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xFF030D18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
              child: Text(
                'TIMELINE',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: PhotoView(
                  backgroundDecoration: BoxDecoration(
                    color: Color(0x00000000),
                  ),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained,
                  imageProvider: AssetImage(
                    'assets/img/others/timeline.jpg',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
