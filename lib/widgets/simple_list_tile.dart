import 'package:core_management_v2/extensions/screen_layout_extension.dart';
import 'package:core_management_v2/mixins/simple_list_tile_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO add function to can only choose on
//TODO improve this function
class SimpleListTile<T extends SimpleListTileMixin<T>> extends StatefulWidget {
  const SimpleListTile({
    Key? key,
    required this.size,
    required this.valueNotifier,
    this.onTap,
    this.builder,
    required this.mainText,
    this.selectNotifier,
    this.shrinkWrap,
    this.refresh,
  }) : super(key: key);

  final Size size;
  final ValueNotifier<List<T>> valueNotifier;
  final void Function(T value, int index, bool selected,
      void Function({int? maximum}) selectItem)? onTap;
  final String Function(T) mainText;
  final bool? shrinkWrap;
  final ValueNotifier<List<T>>? selectNotifier;
  final VoidCallback? refresh;

  /// use [Theme] widget to override default theme for highlight item when selected
  /// [ThemeData.highlightColor] <-- override this value
  final Widget Function(BuildContext context, T indexValue, int index,
      bool selected, Widget child)? builder;

  @override
  State<SimpleListTile<T>> createState() => _SimpleListTileState<T>();
}

class _SimpleListTileState<T extends SimpleListTileMixin<T>>
    extends State<SimpleListTile<T>> {
  final ValueNotifier<List<T>> selectNotifierInternal =
  ValueNotifier(List.empty(growable: true));

  ValueNotifier<List<T>> get selectNotifier {
    return widget.selectNotifier ?? selectNotifierInternal;
  }

  @override
  void initState() {
    // if (widget.selectNotifier != null) {
    //   selectNotifier = widget.selectNotifier!;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
        valueListenable: widget.valueNotifier,
        builder: (context, value, _) {
          return value.isEmpty
              ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Tiada data ditetapkan",
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (widget.refresh != null)
                    CupertinoButton(
                        onPressed: widget.refresh,
                        child: const Text('kemaskini data')),
                ],
              ))
              : ListView.builder(
              shrinkWrap: widget.shrinkWrap ?? false,
              physics: const BouncingScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                final T indexValue = value[index];

                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: InkWell(
                    onTap: () {
                      void rawSelectItem() {
                        //change selected to true
                        // selectNotifier.value[index] =
                        //     !selectNotifier.value[index];
                        //invoke value notifer with new value

                        if (!selectNotifier.value.idContain(indexValue)) {
                          selectNotifier.value = List<T>.from(
                              selectNotifier.value..add(indexValue));
                        } else {
                          selectNotifier.value = List<T>.from(
                              selectNotifier.value..idRemove(indexValue));
                        }
                      }

                      /// select this item,
                      /// [maximum] cuurently not available
                      void selectItem({int? maximum}) {
                        //change selected to true
                        rawSelectItem();

                        //TODO fix maximum logic
                        // //set range of multiple select
                        // //add selected index to for historical use
                        // selectedIndex.add(index);
                        // //check if multi select have maximum value, default unlimited maximum value
                        // if (selectedIndex.length > (maximum ?? 0) &&
                        //     maximum != null &&
                        //     selectNotifier.value[index]) {
                        //   //remove and get oldest selected index
                        //   List<int> reverseSelectedIndex =
                        //       selectedIndex.reversed.toList();
                        //   int removeIndex =
                        //       reverseSelectedIndex.removeLast();
                        //   selectedIndex =
                        //       reverseSelectedIndex.reversed.toList();
                        //   //change oldest sellected index to unsleected
                        //   rawSelectItem(removeIndex);
                        // } else if (!selectNotifier.value[index]) {
                        //   selectedIndex.remove(index);
                        // }
                      }

                      widget.onTap?.call(
                          indexValue,
                          index,
                          selectNotifier.value.idContain(indexValue),
                          selectItem);
                    },
                    child: ValueListenableBuilder<List<T>>(
                      valueListenable: selectNotifier,
                      builder: (context, selectedValue, _) {
                        print(selectedValue);
                        final bool selected =
                        selectedValue.idContain(indexValue);
                        return Card(
                          color: selected
                              ? context.themeData.highlightColor
                              : null,
                          elevation: 11,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: widget.builder?.call(
                            context,
                            indexValue,
                            index,
                            selected,
                            SizedBox(
                              height: widget.size.height * .07,
                              child: Center(
                                  child: Text(
                                      widget.mainText(indexValue))),
                            ),
                          ) ??
                              SizedBox(
                                height: widget.size.height * .07,
                                child: Center(
                                    child:
                                    Text(widget.mainText(indexValue))),
                              ),
                        );
                      },
                    ),
                  ),
                );
              });
        });
  }
}

class SimpleListTileDismissible<T extends SimpleListTileMixin<T>>
    extends StatefulWidget {
  const SimpleListTileDismissible({
    Key? key,
    required this.size,
    required this.valueNotifier,
    this.onTap,
    this.builder,
    required this.mainText,
    this.onDismissed,
    this.backgroundOnDismissed,
    this.secondaryBackgroundOnDismissed,
    this.selectNotifier,
    this.refresh,
  }) : super(key: key);

  final Size size;
  final ValueNotifier<List<T>> valueNotifier;
  final void Function(T value, int index, bool selected,
      void Function({int? maximum}) selectItem)? onTap;
  final String Function(T) mainText;
  final void Function(
      DismissDirection direction, VoidCallback fun, T indexValue)? onDismissed;
  final Widget? backgroundOnDismissed;
  final Widget? secondaryBackgroundOnDismissed;
  final Widget Function(
      BuildContext context, T indexValue, int index, Widget child)? builder;
  final ValueNotifier<List<T>>? selectNotifier;
  final VoidCallback? refresh;

  @override
  State<SimpleListTileDismissible<T>> createState() =>
      _SimpleListTileDismissibleState<T>();
}

class _SimpleListTileDismissibleState<T extends SimpleListTileMixin<T>>
    extends State<SimpleListTileDismissible<T>> {
  final ValueNotifier<List<T>> selectNotifierInternal =
  ValueNotifier(List.empty(growable: true));

  ValueNotifier<List<T>> get selectNotifier {
    return widget.selectNotifier ?? selectNotifierInternal;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<T>>(
        valueListenable: widget.valueNotifier,
        builder: (context, value, _) {
          return value.isEmpty
              ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Tiada data ditetapkan",
                    style: TextStyle(color: Colors.grey),
                  ),
                  if (widget.refresh != null)
                    CupertinoButton(
                        onPressed: widget.refresh,
                        child: const Text('kemaskini data')),
                ],
              ))
              : ListView.builder(
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                final T indexValue = value[index];
                return Dismissible(
                  //to make sure all the receive element are different
                  key: Key(
                      '${indexValue.hashCode.toString()}${DateTime.now().millisecondsSinceEpoch}'),
                  onDismissed: (direction) {
                    ///function to after on dismiss are call to remove from real list also
                    void removeFromIndex() {
                      value.removeAt(index);
                      // valueNotifier.value.removeAt(index);
                      widget.valueNotifier.value = List.from(value);
                    }

                    if (widget.onDismissed == null) {
                      return removeFromIndex();
                    }

                    widget.onDismissed
                        ?.call(direction, removeFromIndex, indexValue);
                  },
                  background: widget.backgroundOnDismissed ??
                      const Card(
                          color: Colors.redAccent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 33),
                              child: Icon(Icons.delete),
                            ),
                          )),
                  secondaryBackground:
                  widget.secondaryBackgroundOnDismissed ??
                      const Card(
                          color: Colors.redAccent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 33),
                              child: Icon(Icons.delete),
                            ),
                          )),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: InkWell(
                      onTap: () {
                        void rawSelectItem() {
                          //change selected to true
                          // selectNotifier.value[index] =
                          //     !selectNotifier.value[index];
                          //invoke value notifer with new value

                          if (!selectNotifier.value.idContain(indexValue)) {
                            selectNotifier.value = List<T>.from(
                                selectNotifier.value..add(indexValue));
                          } else {
                            selectNotifier.value = List<T>.from(
                                selectNotifier.value..idRemove(indexValue));
                          }
                        }

                        ///select this item,
                        ///[maximum] cuurently not aviable
                        void selectItem({int? maximum}) {
                          //change selected to true
                          rawSelectItem();

                          //TODO fix maximum logic
                          // //set range of multiple select
                          // //add selected index to for historical use
                          // selectedIndex.add(index);
                          // //check if multi select have maximum value, default unlimited maximum value
                          // if (selectedIndex.length > (maximum ?? 0) &&
                          //     maximum != null &&
                          //     selectNotifier.value[index]) {
                          //   //remove and get oldest selected index
                          //   List<int> reverseSelectedIndex =
                          //       selectedIndex.reversed.toList();
                          //   int removeIndex =
                          //       reverseSelectedIndex.removeLast();
                          //   selectedIndex =
                          //       reverseSelectedIndex.reversed.toList();
                          //   //change oldest sellected index to unsleected
                          //   rawSelectItem(removeIndex);
                          // } else if (!selectNotifier.value[index]) {
                          //   selectedIndex.remove(index);
                          // }
                        }

                        widget.onTap?.call(
                            indexValue,
                            index,
                            selectNotifier.value.idContain(indexValue),
                            selectItem);
                      },
                      child: Card(
                        elevation: 11,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: widget.builder?.call(
                          context,
                          indexValue,
                          index,
                          SizedBox(
                            height: widget.size.height * .07,
                            child: Center(
                                child:
                                Text(widget.mainText(indexValue))),
                          ),
                        ) ??
                            SizedBox(
                              height: widget.size.height * .07,
                              child: Center(
                                  child: Text(widget.mainText(indexValue))),
                            ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
