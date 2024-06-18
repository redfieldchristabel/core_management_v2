import 'package:core_management_v2/controllers/loading_animation.dart';
import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';

class LoadingAnimationWrapper extends StatefulWidget {
  const LoadingAnimationWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<LoadingAnimationWrapper> createState() =>
      _LoadingAnimationWrapperState();
}

class _LoadingAnimationWrapperState extends State<LoadingAnimationWrapper>
    with TaskQueueMixin {
  final LoadingAnimationController _controller = LoadingAnimationController();

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  OverlayEntry? loadingOverlay;

  @override
  void initState() {
    BaseFrameworkService.instance
        .initializeLoadingController(animationController: _controller);

    enqueueTask(() {
      _controller.addListener(() {
        if (_controller.state == LoadingAnimationState.loading &&
            loadingOverlay == null) {
          loadingOverlay = OverlayEntry(
              builder: (context) =>
                  const AbsorbPointer(child: LoadingAnimation()));
          _overlayKey.currentState?.insert(loadingOverlay!);
        } else if (_controller.state == LoadingAnimationState.idle &&
            loadingOverlay != null) {
          loadingOverlay?.remove();
          loadingOverlay = null;
        }
      });
    });
    super.initState();
  }

  // get controller => BaseFrameworkService.instance.loadingAnimationController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(builder: (context) => widget.child),
        ],
      ),
    );
  }
}
