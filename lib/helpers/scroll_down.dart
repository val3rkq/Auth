import 'package:flutter/cupertino.dart';

void scrollDown(ScrollController scrollController,
    {Duration duration = const Duration(milliseconds: 500)}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    scrollController
        .animateTo(
      scrollController.position.maxScrollExtent,
      duration: duration,
      curve: Curves.ease,
    )
        .then((value) async {
      await Future.delayed(duration);
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: duration,
        curve: Curves.ease,
      );
    });
  });
}