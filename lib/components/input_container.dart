import 'package:flutter/material.dart';

import '../constants/constant.dart';

enum InputContainerType { number, icon, address }

class InputContainer extends StatelessWidget {
  final String title;
  final Color color;
  final TextEditingController? textController;
  final InputContainerType type;
  final double? width;

  const InputContainer(
      {super.key,
      required this.title,
      required this.color,
      required this.textController,
      required this.type,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Constants.heightContainer,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Center(child: getChild()),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(title, style: Constants.normalBlackTextStyle),
        )
      ],
    );
  }

  Widget getChild() {
    switch (type) {
      case InputContainerType.address:
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: textController,
            style: Constants.addressTextStyle,
            minLines: 2,
            enabled: false,
            maxLines: 6,
            decoration: const InputDecoration(
                border: InputBorder.none, counterText: ""),
          ),
        );

      case InputContainerType.number:
        return TextFormField(
          controller: textController,
          keyboardType: TextInputType.number,
          maxLength: 2,
          textAlign: TextAlign.center,
          style: Constants.timeNumbersTextStyle,
          decoration:
              const InputDecoration(border: InputBorder.none, counterText: ""),
        );

      case InputContainerType.icon:
        return const Icon(Icons.gps_fixed, size: 32, color: Colors.white);

      default:
        return const Icon(Icons.gps_fixed, size: 32, color: Colors.white);
    }
  }
}
