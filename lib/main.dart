// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:prak_plugin/takepicture_widget.dart';
// import 'package:prak_plugin/widget/filter_carousel.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

  // runApp(MaterialApp(
  //   theme: ThemeData.dark(),
  //     home: TakepictureWidget(
  //       camera: firstCamera,
  //     ),
  // ));
// }

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:prak_plugin/widget/filter_carousel.dart';
import 'package:prak_plugin/widget/photo_filter_carousel.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Photo Filter Carousel'),),
        body: cameras.isNotEmpty
            ? PhotoFilterCarousel(camera: cameras.first)
            : Center(child: Text("No camera found")),
      ),
    );
  }
}
