import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 1; // Initial value

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: _value,
          min: 1,
          max: 10,
          divisions: 9,
          activeColor: Colors.blue,
          inactiveColor: Colors.blueGrey,
          onChanged: (double newValue) {
            setState(() {
              _value = newValue;
            });
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹ 1 L', style: TextStyle(color: Colors.white)),
              Text('₹ 10 L', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
