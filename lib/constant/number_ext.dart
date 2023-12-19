import 'package:flutter/material.dart';

extension Box on num {
  ///Creates a sized box with the given number of space
  SizedBox get height {
    return SizedBox(
      height: toDouble(),
      width: 0,
    );
  }

  Widget get sliverHeight {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: toDouble(),
        width: 0,
      ),
    );
  }

  ///Creates a sized box with the given number of space
  Widget get width {
    return SizedBox(
      height: 0,
      width: toDouble(),
    );
  }
}

extension TypeNotifier<T> on T {
  ValueNotifier<T> get vn {
    return ValueNotifier<T>(this);
  }
}

extension ValueNotifierX<T> on ValueNotifier<T> {
  Widget watch({required Widget Function(T value) onData}) {
    return ValueListenableBuilder(
      valueListenable: this,
      builder: (context, value, child) => onData(value),
    );
  }
}
