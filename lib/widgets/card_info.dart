import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.heading,
    required this.hintText,
  });

  final String heading;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: Colors.grey.shade300,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
