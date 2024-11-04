// import 'package:flutter/material.dart';
// import 'package:prak_plugin/takepicture_widget.dart';

// @immutable
// class FilterItem extends StatelessWidget {
//   const FilterItem({
//     super.key,
//     required this.color,
//     this.onFilterSelected,
//   });
//   final Color color;
//   final VoidCallback? onFilterSelected;
  
//   get firstCamera => null;
  
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onFilterSelected,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: ClipOval(
//             child: TakepictureWidget(camera: firstCamera)
//             ),
//           ),
//         ),
//       );
//   }
// }

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatefulWidget {
  const FilterItem({
    super.key,
    required this.color,
    this.onFilterSelected,
  });
  final Color color;
  final VoidCallback? onFilterSelected;

  @override
  _FilterItemState createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Mengambil daftar kamera yang tersedia
    final cameras = await availableCameras();
    // Memilih kamera belakang (atau kamera pertama jika hanya satu)
    final camera = cameras.isNotEmpty ? cameras.first : null;

    if (camera != null) {
      _controller = CameraController(camera, ResolutionPreset.medium);
      _initializeControllerFuture = _controller.initialize();
      setState(() {}); // Memperbarui UI setelah kamera terinisialisasi
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFilterSelected,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      widget.color.withOpacity(0.5),
                      BlendMode.hardLight,
                    ),
                    child: CameraPreview(_controller),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

