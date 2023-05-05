import 'package:core_management_v2/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class DateInputField extends StatefulWidget {
  const DateInputField({
    Key? key,
    this.textEditingController,
    this.labelText,
    this.prefixIcon,
    this.inputDecoration,
    this.onPick,
    this.validator,
    this.disabled = false,
    this.withTime = false,
  }) : super(key: key);
  final TextEditingController? textEditingController;
  final String? labelText;
  final Widget? prefixIcon;
  final InputDecoration? inputDecoration;
  final Function(DateTime dateTime)? onPick;
  final String? Function(String?)? validator;
  final bool disabled;
  final bool withTime;

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  final TextEditingController _internalTextEditingController =
  TextEditingController();

  TextEditingController get controller =>
      widget.textEditingController ?? _internalTextEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //editing controller of this TextField
      validator: widget.validator,
      decoration: widget.inputDecoration?.copyWith(
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
      ) ??
          InputDecoration(
            labelText: widget.labelText ?? 'date',
            prefixIcon: widget.prefixIcon ?? Icon(Icons.calendar_month),
          ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: widget.disabled
          ? null
          : () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101))
            .then((value) {
          if (!widget.withTime) return value;

          if (value != null) {
            return showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(value))
                .then((timeOfDay) {
              return timeOfDay != null
                  ? value.withTimeOfDay(timeOfDay)
                  : null;
            });
          }

          return value;
        });

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          // String formattedDate = DateFormat.yMMMEd().format(pickedDate);
          String formattedDate = widget.withTime
              ? pickedDate.intlFormatWithTime
              : pickedDate.intlFormat;
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement
          controller.text = formattedDate;
          widget.onPick?.call(pickedDate);
        } else {
          print("Date is not selected");
        }
      },
    );
  }
}
