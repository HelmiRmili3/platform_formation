import 'package:eplatfrom/presentation/controllers/formateur_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepperFormScreen extends GetView<FormateurController> {
  const StepperFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Formation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: controller.nameController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.formateurController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(labelText: 'Formateur'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const SafeArea(
                            minimum: EdgeInsets.all(16),
                            child: DateTimePickerWidget());
                      },
                    );
                  },
                  child: const Text('Add Seance'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.descriptionController,
                  onChanged: (value) {},
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.addFormation(),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimePickerWidget extends StatefulWidget {
  const DateTimePickerWidget({Key? key}) : super(key: key);

  @override
  DateTimePickerWidgetState createState() => DateTimePickerWidgetState();
}

class DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final FormateurController controller = Get.find<FormateurController>();

  Future<void> _selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
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
          'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Text(
          'Selected Time: ${selectedTime.format(context)}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _selectDateAndTime(context),
          child: const Text('Select Date and Time'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Confirme'),
        ),
      ],
    );
  }
}
