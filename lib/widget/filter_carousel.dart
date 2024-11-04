// import 'package:flutter/material.dart';
// import 'package:prak_plugin/takepicture_widget.dart';
// import 'package:prak_plugin/widget/filter_selector.dart';

// @immutable
// class PhotoFilterCarousel extends StatefulWidget {
//   const PhotoFilterCarousel({super.key});
//   @override
//   State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
// }

// class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
//   final _filters = [
//     Colors.white,
//     ...List.generate(
//       Colors.primaries.length,
//       (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
//     )
//   ];
//   final _filterColor = ValueNotifier<Color>(Colors.white);
//   void _onFilterChanged(Color value) {
//     _filterColor.value = value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.black,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: _buildPhotoWithFilter(),
//           ),
//           Positioned(
//             left: 0.0,
//             right: 0.0,
//             bottom: 0.0,
//             child: _buildFilterSelector(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPhotoWithFilter() {
//     return ValueListenableBuilder(
//       valueListenable: _filterColor,
//       builder: (context, color, child) {
//         // Anda bisa ganti dengan foto Anda sendiri
//         return TakepictureWidget(camera: firstCamera)
//       //     color: color.withOpacity(0.5),
//       //     colorBlendMode: BlendMode.color,
//       //     fit: BoxFit.cover,
//       //   );
//       // },
//       }
//     );

//   }

//   Widget _buildFilterSelector() {
//     return FilterSelector(
//       onFilterChanged: _onFilterChanged,
//       filters: _filters,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:prak_plugin/takepicture_widget.dart';
import 'package:prak_plugin/widget/filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatefulWidget {
  const PhotoFilterCarousel({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<PhotoFilterCarousel> createState() => _PhotoFilterCarouselState();
}

class _PhotoFilterCarouselState extends State<PhotoFilterCarousel> {
  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];
  final _filterColor = ValueNotifier<Color>(Colors.white);

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildPhotoWithFilter(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: _buildFilterSelector(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoWithFilter() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            color.withOpacity(0.05),
            BlendMode.color,
          ),
          child: TakepictureWidget(camera: widget.camera),
        );
      },
    );
  }

  Widget _buildFilterSelector() {
    return FilterSelector(
      onFilterChanged: _onFilterChanged,
      filters: _filters,
    );
  }
}
