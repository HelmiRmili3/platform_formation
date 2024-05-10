import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimePickerWidget extends StatefulWidget {
  final Formation formation;
  const DateTimePickerWidget({Key? key, required this.formation})
      : super(key: key);

  @override
  DateTimePickerWidgetState createState() => DateTimePickerWidgetState();
}

class DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  final FormateurController controller = Get.find<FormateurController>();

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: controller.selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          controller.selectedDate = pickedDate;
          controller.selectedTime = pickedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Selected Date: ${controller.selectedDate.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Text(
          'Selected Time: ${controller.selectedTime.format(context)}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _selectDateAndTime(context),
          child: const Text('Select Date and Time'),
        ),
        const SizedBox(height: 200),
        ElevatedButton(
          onPressed: () {
            controller.addSeance(widget.formation.id);
            Navigator.pop(context);
          },
          child: const Text('Confirme'),
        ),
      ],
    );
  }
}
