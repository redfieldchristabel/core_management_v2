import 'package:core_management_v2/controllers/loading_animation.dart';
import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingAnimationWrapper extends StatefulWidget {
  const LoadingAnimationWrapper(
      {super.key, required this.child, this.noMaterialApp = false});

  final Widget child;
  final bool noMaterialApp;

  @override
  State<LoadingAnimationWrapper> createState() =>
      _LoadingAnimationWrapperState();
}

class _LoadingAnimationWrapperState extends State<LoadingAnimationWrapper>
    with TaskQueueMixin {
  final LoadingAnimationController _controller = LoadingAnimationController();

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();

  OverlayEntry? loadingOverlay;

  RiveAnimationController? get riveAnimationController {
    try {
      return framework.riveAnimationController;
    } on UnimplementedError catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    framework.initializeLoadingController(animationController: _controller);

    Artboard? artBoard;
    RiveAnimationController? ctrl;

    enqueueTask(() {
      _controller.addListener(() async {
        if (_controller.state == LoadingAnimationState.loading &&
            loadingOverlay == null) {
          loadingOverlay = OverlayEntry(
              builder: (context) => AbsorbPointer(
                  child: LoadingAnimation(
                      controller: riveAnimationController,
                      onInit: (art) {
                        artBoard = art;
                        ctrl = framework.onRiveAnimationLoadingInit?.call(art);
                      })));
          _overlayKey.currentState?.insert(loadingOverlay!);
        } else if (_controller.state == LoadingAnimationState.idle &&
            loadingOverlay != null) {
          loadingOverlay?.remove();
          loadingOverlay = null;
          artBoard?.remove();
          artBoard = null;
        } else if (_controller.state == LoadingAnimationState.completed &&
            loadingOverlay != null) {
          if (artBoard != null) {
            await framework.onRiveAnimationLoadingComplete
                ?.call(artBoard!, ctrl);
          }
          framework.loadingAnimationController.state =
              LoadingAnimationState.idle;
        }
      });
    });
    super.initState();
  }

  BaseFrameworkService get framework => BaseFrameworkService.instance;

  // get controller => BaseFrameworkService.instance.loadingAnimationController;

  @override
  Widget build(BuildContext context) {
    if (widget.noMaterialApp) {
      return Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(builder: (context) => widget.child),
        ],
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: BaseFrameworkService.instance.themeData,
      home: Overlay(
        key: _overlayKey,
        initialEntries: [
          OverlayEntry(builder: (context) => widget.child),
        ],
      ),
    );
  }
}
