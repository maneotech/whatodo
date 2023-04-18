import 'package:flutter/material.dart';
import 'package:whatodo/components/activity_container.dart';
import 'package:whatodo/components/circle_discount.dart';


class PriceContainer extends StatefulWidget {
  final String title;
  final Color color;
  final String iconPath;
  final Function? onTap;
  final bool isActive;
  final String price;
  final String? discount;

  const PriceContainer(
      {super.key,
      required this.title,
      required this.color,
      required this.iconPath,
      required this.onTap,
      required this.price,
      this.discount,
      this.isActive = false});

  @override
  State<PriceContainer> createState() => _PriceContainerState();
}

class _PriceContainerState extends State<PriceContainer> {
  late bool isActive;

  @override
  void initState() {
    isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 10.0),
            child: Column(
              children: [
                ActivityContainer(
                    title: widget.title,
                    color: widget.color,
                    iconPath: widget.iconPath,
                    isActive: true,
                    onTap: widget.onTap),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    widget.price,
                    style: TextStyle(
                        fontSize: 12.0,
                        color: widget.color,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Hellix"),
                  ),
                ),
              ],
            ),
          ),
          if (widget.discount != null)
            Positioned(
              top: 0,
              right: 0,
              child: CircleDiscount(text: widget.discount!),
            ),
        ],
      ),
    );
  }
}
