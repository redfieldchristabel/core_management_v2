import 'dart:io';
import 'package:core_management_v2/extensions/screen_layout_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

//TODO make this as core management package Widget
/// widget to simply display all image
/// [onPick] an event that will trigger when
/// the pick an Image action from device is complete
class ImageInputBox<T extends ImageInputBoxNetwork> extends StatefulWidget {
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
  final void Function(T)? onLocalDestruction;
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

class _ImageInputBoxState<T extends ImageInputBoxNetwork>
    extends State<ImageInputBox<T>> {
  final ImagePicker imagePicker = ImagePicker();

  final ValueNotifier<List<ImageInputBoxInstance<T>>> imagePathNotifier =
  ValueNotifier<List<ImageInputBoxInstance<T>>>(List.empty(growable: true));

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages != null) {
      //call callback function
      widget.onPick?.call(selectedImages.map((e) => File(e.path)).toList());

      //save file to value notifier
      final List<ImageInputBoxInstance> imageFile =
      List<ImageInputBoxInstance>.from(imagePathNotifier.value);
      imageFile.addAll(selectedImages
          .map((e) => ImageInputBoxInstance<T>(file: File(e.path))));
      imagePathNotifier.value = List<ImageInputBoxInstance<T>>.from(imageFile);
    }

    Navigator.pop(context);
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

    Navigator.pop(context);
  }

  @override
  void initState() {
    imagePathNotifier.value = widget.initialImages
        ?.map((e) => ImageInputBoxInstance(fileNetwork: e))
        .toList() ??
        List.empty(growable: true);
    imagePathNotifier.addListener(() {
      widget.onChange?.call(imagePathNotifier.value);
    });
    super.initState();
  }

  //TODO outline for the input imagebox to fit with dark mode
  @override
  Widget build(BuildContext context) {
    final Size size = context.screenSize;
    final ThemeData themeData = context.themeData;
    final FToast fToast = FToast()..init(context);
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
                                  : FutureBuilder<File>(
                                  future: imageInstance.fileNetwork?.file ??
                                      Future.value(imageInstance.file!),
                                  builder: (context, snapshot) {
                                    ValueNotifier<bool> activeNotifier =
                                    ValueNotifier(true);
                                    return snapshot.hasData
                                        ? CupertinoContextMenu(
                                      previewBuilder: (BuildContext
                                      context,
                                          Animation<double> animation,
                                          Widget child) {
                                        return FittedBox(
                                          fit: BoxFit.cover,
                                          // This ClipRRect rounds the corners of the image when the
                                          // CupertinoContextMenu is open, even though it's not rounded when
                                          // it's closed. It uses the given animation to animate the corners
                                          // in sync with the opening animation.
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                64.0 *
                                                    animation
                                                        .value),
                                            child: child,
                                          ),
                                        );
                                      },
                                      actions: [
                                        if (!widget.disableInput)
                                          CupertinoContextMenuAction(
                                            // isDefaultAction: true,
                                            isDestructiveAction: true,
                                            child:
                                            const Text("delete"),
                                            onPressed: () async {
                                              Future.delayed(
                                                  const Duration(
                                                      seconds: 1),
                                                      () {
                                                    activeNotifier.value =
                                                    false;
                                                  });
                                              Navigator.of(context,
                                                  rootNavigator:
                                                  true)
                                                  .pop();
                                              await Future.delayed(
                                                  const Duration(
                                                      seconds: 2));
                                              imagePathNotifier
                                                  .value =
                                              List.from(value)
                                                ..removeAt(index -
                                                    (widget.disableInput
                                                        ? 0
                                                        : 1));
                                              if (imageInstance
                                                  .file !=
                                                  null) {
                                                widget
                                                    .onLocalDestruction
                                                    ?.call(imageInstance
                                                    .fileNetwork!);
                                              } else {
                                                widget.onDestruction
                                                    ?.call(imageInstance
                                                    .fileNetwork!);
                                              }

                                              // Navigator.pop(context);
                                            },
                                          ),
                                        CupertinoContextMenuAction(
                                          onPressed: () =>
                                              Navigator.of(context,
                                                  rootNavigator:
                                                  true)
                                                  .pop(),
                                          isDestructiveAction: true,
                                          child: const Text("close"),
                                        ),
                                      ],
                                      child: ValueListenableBuilder<
                                          bool>(
                                          valueListenable:
                                          activeNotifier,
                                          builder:
                                              (context, value, _) {
                                            return value
                                                ? ClipRRect(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  8),
                                              child: Image.file(
                                                snapshot.data!,
                                                fit: BoxFit
                                                    .cover,
                                              ),
                                            )
                                                : const IgnorePointer(
                                                child:
                                                CupertinoActivityIndicator());
                                          }),
                                    )
                                        : const CupertinoActivityIndicator();
                                  })),
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

//TODO include this in Core management Model
//TODO create new mixin for this widget to only take generic Type that implement that mixin
///model for only this widget,
class ImageInputBoxInstance<T extends ImageInputBoxNetwork> {
  T? fileNetwork;
  File? file;

  ImageInputBoxInstance({this.file, this.fileNetwork}) {
    if (fileNetwork == null && file == null) {
      throw Exception("both attribute cant be null at the sametime");
    }
  }
}

///implement this mixin within your class
///so it can be generic type of [ImageInputBoxInstance]
///class,
mixin ImageInputBoxNetwork {
  ///get [File] instance from the network
  Future<File> get file;
}
