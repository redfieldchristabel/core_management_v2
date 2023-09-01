import 'dart:io';

import 'package:core_management_v2/extensions/screen_layout_extension.dart';
import 'package:core_management_v2/mixins/image_input_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// widget to simply display all image
/// [onPick] an event that will trigger when
/// the pick an Image action from device is complete
class ImageInputBox<T extends ImageInputBoxBase> extends StatefulWidget {
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double? maximumHeight;
  final bool shrinkWrap;
  final bool disableInput;
  final String? fromCameraLabel;
  final String? fromGalleryLabel;
  final void Function(List<ImageInputBoxInstance>)? onChange;
  final void Function(List<File>)? onPick;
  final void Function(T)? onDestruction;
  final void Function(File)? onLocalDestruction;
  final List<T>? initialImages;

  const ImageInputBox(
      {Key? key,
      this.width,
      this.margin,
      this.onChange,
      this.onPick,
      this.initialImages,
      this.onDestruction,
      this.onLocalDestruction,
      this.shrinkWrap = true,
      this.disableInput = false,
      this.maximumHeight,
      this.fromCameraLabel,
      this.fromGalleryLabel})
      : super(key: key);

  @override
  State<ImageInputBox<T>> createState() => _ImageInputBoxState<T>();
}

class _ImageInputBoxState<T extends ImageInputBoxBase>
    extends State<ImageInputBox<T>> {
  final ImagePicker imagePicker = ImagePicker();

  final ValueNotifier<List<ImageInputBoxInstance<T>>> imagePathNotifier =
      ValueNotifier<List<ImageInputBoxInstance<T>>>(List.empty(growable: true));

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();

    widget.onPick?.call(selectedImages.map((e) => File(e.path)).toList());

    //save file to value notifier
    final List<ImageInputBoxInstance> imageFile =
        List<ImageInputBoxInstance>.from(imagePathNotifier.value);
    imageFile.addAll(selectedImages
        .map((e) => ImageInputBoxInstance<T>(file: File(e.path))));
    imagePathNotifier.value = List<ImageInputBoxInstance<T>>.from(imageFile);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      //call callback function
      widget.onPick?.call([File(image.path)]);

      //save file to value notifier
      final List<ImageInputBoxInstance> imageFile =
          List<ImageInputBoxInstance>.from(imagePathNotifier.value);
      imageFile.add(ImageInputBoxInstance<T>(file: File(image.path)));
      imagePathNotifier.value = List<ImageInputBoxInstance<T>>.from(imageFile);
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  void initState() {
    imagePathNotifier.value = widget.initialImages
            ?.map((e) => ImageInputBoxInstance(sourceInstance: e))
            .toList() ??
        List.empty(growable: true);
    imagePathNotifier.addListener(() {
      widget.onChange?.call(imagePathNotifier.value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = context.screenSize;
    final ThemeData themeData = context.themeData;
    return SizedBox(
      height: widget.maximumHeight,
      child: Align(
        child: Card(
          margin: widget.margin ?? const EdgeInsets.only(top: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: themeData.scaffoldBackgroundColor,
          child: SizedBox(
            // color: Colors.redAccent,
            // height: size.height * .35,
            width: widget.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<List<ImageInputBoxInstance<T>>>(
                builder: (BuildContext context, value, _) {
                  return GridView.builder(
                      shrinkWrap: widget.shrinkWrap,
                      itemCount: value.length + (widget.disableInput ? 0 : 1),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        late final ImageInputBoxInstance<T> imageInstance;
                        if (index != 0 || widget.disableInput) {
                          imageInstance =
                              value[index - (widget.disableInput ? 0 : 1)];
                        }
                        return Card(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue),
                                  color: themeData.scaffoldBackgroundColor),
                              margin: const EdgeInsets.all(5.0),
                              child: !widget.disableInput && index == 0
                                  ? IconButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return SizedBox(
                                                height: size.height * .2,
                                                child: ListView(
                                                  children: [
                                                    ListTile(
                                                      leading: Text(widget
                                                              .fromGalleryLabel ??
                                                          'From Gallery'),
                                                      onTap: selectImages,
                                                    ),
                                                    ListTile(
                                                      leading: Text(widget
                                                              .fromCameraLabel ??
                                                          'From Camera'),
                                                      onTap:
                                                          pickImageFromCamera,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });

                                        // Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        color: Colors.blue,
                                      ),
                                    )
                                  : _ImageRenderer(
                                      index: index,
                                      imageInputBox: widget,
                                      imagePathNotifier: imagePathNotifier,
                                      imageInstance: imageInstance,
                                    )),
                        );
                      });
                },
                valueListenable: imagePathNotifier,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageRenderer extends StatefulWidget {
  const _ImageRenderer({
    super.key,
    required this.index,
    required this.imageInputBox,
    required this.imagePathNotifier,
    required this.imageInstance,
  });

  final int index;
  final ImageInputBox imageInputBox;
  final ValueNotifier<List<ImageInputBoxInstance>> imagePathNotifier;
  final ImageInputBoxInstance imageInstance;

  @override
  State<_ImageRenderer> createState() => _ImageRendererState();
}

class _ImageRendererState extends State<_ImageRenderer> {
  final ValueNotifier<bool> activeNotifier = ValueNotifier(false);
  late ImageProvider imageProvider;

  @override
  void initState() {
    final imageInstance = widget.imageInstance;
    final ImageInputBoxBase sourceImage;

    if (imageInstance.file != null) {
      imageProvider = FileImage(imageInstance.file!);
      activeNotifier.value = true;
    } else {
      sourceImage = imageInstance.sourceInstance!;

      if (sourceImage is ImageInputBoxNetwork) {
        sourceImage.uri.then((value) {
          imageProvider = NetworkImage(value.toString());
          activeNotifier.value = true;
        });
      } else if (sourceImage is ImageInputBoxFile) {
        sourceImage.file.then((value) {
          imageProvider = FileImage(value);
          activeNotifier.value = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu.builder(
      actions: [
        if (!widget.imageInputBox.disableInput)
          CupertinoContextMenuAction(
            // isDefaultAction: true,
            isDestructiveAction: true,
            child: const Text("delete"),
            onPressed: () async {
              Future.delayed(const Duration(seconds: 1), () {
                activeNotifier.value = false;
              });
              Navigator.of(context, rootNavigator: true).pop();
              await Future.delayed(const Duration(seconds: 2));
              widget.imagePathNotifier
                  .value = List.from(widget.imagePathNotifier.value)
                ..removeAt(
                    widget.index - (widget.imageInputBox.disableInput ? 0 : 1));
              if (widget.imageInstance.file != null) {
                widget.imageInputBox.onLocalDestruction
                    ?.call(widget.imageInstance.file!);
              } else {
                widget.imageInputBox.onDestruction
                    ?.call(widget.imageInstance.sourceInstance!);
              }

              // Navigator.pop(context);
            },
          ),
        CupertinoContextMenuAction(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          isDestructiveAction: true,
          child: const Text("close"),
        ),
      ],
      enableHapticFeedback: true,
      builder: (BuildContext context, Animation<double> animation) {
        final double? animationValue = animation.value > 0.01 ? null : 100;

        final curveRadiosAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        );

        final topPadding = context.screenSize.height * 0.1;

        final radiosAnimation = TweenSequence([
          TweenSequenceItem(
              tween: Tween<double>(begin: 8, end: 45), weight: 0.1),
          TweenSequenceItem(
              tween: Tween<double>(begin: 45, end: 0), weight: 0.9),
        ]).animate(curveRadiosAnimation);

        return FittedBox(
          fit: BoxFit.cover,
          child: ValueListenableBuilder<bool>(
              valueListenable: activeNotifier,
              builder: (context, value, _) {
                return value
                    ? Image(
                        image: imageProvider,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: topPadding * curveRadiosAnimation.value),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(radiosAnimation.value),
                              child: child,
                            ),
                          );
                        },
                        fit: BoxFit.cover,
                        height: animationValue,
                        width: animationValue,
                      )
                    : const IgnorePointer(child: CupertinoActivityIndicator());
              }),
        );
      },
    );
  }
}

///model for only this widget,
class ImageInputBoxInstance<T extends ImageInputBoxBase> {
  T? sourceInstance;
  File? file;

  ImageInputBoxInstance({this.file, this.sourceInstance}) {
    if (sourceInstance == null && file == null) {
      throw Exception("both attribute cant be null at the sametime");
    }
  }
}
