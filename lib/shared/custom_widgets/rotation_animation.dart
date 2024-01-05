import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageRotationData {
  double rotation = -1.0;
  double translateY = -1.0;

  ImageRotationData({required this.rotation, required this.translateY});
}

class ImageRotationNotifier extends StateNotifier<ImageRotationData> {
  ImageRotationNotifier() : super(ImageRotationData(rotation: -1.0, translateY: -1.0));

  void startAnimation() {
    state = ImageRotationData(rotation: 1.0, translateY: 1.0);
  }
}