import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DurationPisckerScreen extends StatefulWidget {
  final ValueChanged<int> selectDuration;

  const DurationPisckerScreen({super.key, required this.selectDuration});

  @override
  State<DurationPisckerScreen> createState() => _DurationPisckerScreenState();
}

class _DurationPisckerScreenState extends State<DurationPisckerScreen> {
  final List<int> _durations = [5, 10, 15, 20, 30, 40, 50, 60];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _durations.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Center(
                child: Text(
                  "< ${_durations[index].toString()} ${AppLocalizations.of(context)!.minutes.toLowerCase()}",
                ),
              ),
              onTap: () => pickDuration(_durations[index]),
            );
          },
        ),
      ),
    );
  }

  pickDuration(int selectedMinutes) {
    widget.selectDuration(selectedMinutes);
    Navigator.of(context).pop();
  }
}
