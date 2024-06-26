import 'package:core_management_v2/core_management_v2.dart';
import 'package:core_management_v2/widgets/loading_state_chip.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingChipWrapper extends StatefulWidget {
  const LoadingChipWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<LoadingChipWrapper> createState() => _LoadingChipWrapperState();
}

class _LoadingChipWrapperState extends State<LoadingChipWrapper> {
  final LoadingStateChipController _loadingStateChipController =
      LoadingStateChipController();

  @override
  void initState() {
    BaseFrameworkService.instance.initializeLoadingController(
        chipController: _loadingStateChipController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: LoadingStateChip(
                    loadingStateChipController: _loadingStateChipController),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
