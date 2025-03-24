import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';

class InvestmentWidget extends StatefulWidget {
  const InvestmentWidget({super.key});

  @override
  _InvestmentWidgetState createState() => _InvestmentWidgetState();
}

class _InvestmentWidgetState extends State<InvestmentWidget> {
  final TextEditingController _controller =
      TextEditingController(text: "₹ 1 L");
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "If you invested ",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.greyColor),
                    ),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                ),
              ),
              const Icon(Icons.edit, color: Colors.grey, size: 18), // Edit Icon
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                selectedBorderColor: Colors.transparent,
                fillColor: Colors.blue,
                color: Colors.grey,
                selectedColor: Colors.white,
                constraints: const BoxConstraints(minWidth: 60, minHeight: 35),
                isSelected: [_selectedIndex == 0, _selectedIndex == 1],
                onPressed: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: const [
                  Text(
                    "1-Time",
                    style: TextStyle(
                        fontSize: 12, overflow: TextOverflow.ellipsis),
                  ),
                  Text(
                    "Monthly SIP",
                    style: TextStyle(
                        fontSize: 12, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
