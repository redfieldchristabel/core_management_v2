import 'dart:async';

import 'package:core_management_v2/core_management_v2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingStateChip extends StatefulWidget {
  const LoadingStateChip({super.key, required this.loadingStateChipController});

  final LoadingStateChipController loadingStateChipController;

  @override
  State<LoadingStateChip> createState() => _LoadingStateChipState();
}

class _LoadingStateChipState extends State<LoadingStateChip>
    with TaskQueueMixin {
  late LoadingStateChipValue value;

  @override
  void initState() {
    value = widget.loadingStateChipController.loadingStateChipValue;
    widget.loadingStateChipController.addListener(() {
      enqueueTask(() {
        setState(() {
          value = widget.loadingStateChipController.loadingStateChipValue;
        });
      });
    });
    super.initState();
  }

// TODO make it as  animation
  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: value == LoadingStateChipValue.idle
          ? const Offset(1, 0)
          : Offset.zero,
      curve: Curves.elasticInOut,
      duration: const Duration(milliseconds: 999),
      child: SizedBox(
        width: context.screenSize.width * .35,
        child: Chip(
          label: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.loadingStateChipController.value,
              ),
              if (widget.loadingStateChipController.iconData != null)
                Icon(
                  widget.loadingStateChipController.iconData!,
                  color: context.themeData.primaryColor,
                ),
              if (value != LoadingStateChipValue.idle &&
                  widget.loadingStateChipController.iconData == null)
                const CupertinoActivityIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingStateChipController extends ChangeNotifier {
  late LoadingStateChipValue _loadingStateChipValue;
  Timer? _timer;
  String _value = '';
  IconData? _iconData;

  /// update this variable to control the state
  LoadingStateChipValue get loadingStateChipValue => _loadingStateChipValue;

  set loadingStateChipValue(LoadingStateChipValue value) {
    assert(value != LoadingStateChipValue.custom,
        'custom can\'t be use with this setter. try "setCustomValue"');
    _loadingStateChipValue = value;
    _value = value.name;
    _iconData = value.iconData;
    notifyListeners();
  }

  void setCustomValue(String value, {IconData? iconData}) {
    _loadingStateChipValue = LoadingStateChipValue.custom;
    _value = value;
    _iconData = iconData;
    notifyListeners();
  }

  String get value => _value;

  IconData? get iconData => _iconData;

  void animateState(LoadingStateChipValue value, {Duration? duration}) {
    _loadingStateChipValue = value;
    _value = value.name;
    _iconData = value.iconData;
    notifyListeners();

    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        _loadingStateChipValue = LoadingStateChipValue.idle;
        notifyListeners();
      },
    );
  }

  LoadingStateChipController() {
    _loadingStateChipValue = LoadingStateChipValue.idle;
  }
}

// TOD add better multi language support using best practice method.
enum LoadingStateChipValue {
  idle,
  loading,
  saving,
  uploading,
  sending,
  deleting,
  deleted(iconData: Icons.delete_rounded),
  saved(iconData: Icons.save_alt_rounded),
  completed(iconData: Icons.done_rounded),
  sent(iconData: Icons.done_rounded),
  failed(iconData: Icons.info_rounded),
  custom;

  const LoadingStateChipValue({this.iconData});

  final IconData? iconData;
}
