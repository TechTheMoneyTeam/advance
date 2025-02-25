import 'package:flutter/material.dart';

class BlaDatePicker extends StatefulWidget {
  final DateTime selectedDate;
  final DateTime minDate;
  final DateTime maxDate;
  final ValueChanged<DateTime>? onDateSelected;

  BlaDatePicker({
    Key? key,
    required DateTime selectedDate,
    DateTime? minDate,
    DateTime? maxDate,
    this.onDateSelected,
  })  : minDate = minDate ?? DateTime.now(),
        maxDate = maxDate ?? DateTime.now().add(const Duration(days: 90)),
        selectedDate = selectedDate.isBefore(minDate ?? DateTime.now())
            ? minDate ?? DateTime.now()
            : selectedDate.isAfter(maxDate ?? DateTime.now().add(const Duration(days: 90)))
                ? maxDate ?? DateTime.now().add(const Duration(days: 90))
                : selectedDate,
        super(key: key);

  @override
  State<BlaDatePicker> createState() => _BlaDatePickerState();
}

class _BlaDatePickerState extends State<BlaDatePicker> {
  late DateTime _selectedDate;
  late PageController _pageController;
  late int _currentMonthIndex;
  late List<DateTime> _months;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _months = _generateMonthsList();
    
    // Find the index of the selected month
    _currentMonthIndex = _months.indexWhere(
        (date) => date.year == _selectedDate.year && date.month == _selectedDate.month);
    
    // Initialize the PageController at the correct month
    _pageController = PageController(initialPage: _currentMonthIndex);
  }

  List<DateTime> _generateMonthsList() {
    List<DateTime> months = [];
    DateTime current = DateTime(widget.minDate.year, widget.minDate.month);
    DateTime lastMonth = DateTime(widget.maxDate.year, widget.maxDate.month);

    while (current.isBefore(lastMonth) || current.isAtSameMomentAs(lastMonth)) {
      months.add(current);
      current = DateTime(current.year, current.month + 1);
    }
    return months;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Select a Date',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _months.length,
              onPageChanged: (index) {
                setState(() {
                  _currentMonthIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildMonthView(_months[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthView(DateTime month) {
    return Center(
      child: Text(
        "${month.year}-${month.month.toString().padLeft(2, '0')}",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
