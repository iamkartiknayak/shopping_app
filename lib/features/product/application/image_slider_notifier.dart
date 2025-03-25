import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImageSliderNotifier extends StateNotifier<int> {
  ImageSliderNotifier() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}

final imageSliderProvider = StateNotifierProvider<ImageSliderNotifier, int>(
  (ref) => ImageSliderNotifier(),
);
