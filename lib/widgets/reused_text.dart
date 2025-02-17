import 'package:flutter/material.dart';

class ReusedText extends StatelessWidget {
  const ReusedText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Expanded(
        child: Row(
          children: [
            const Flexible(
              flex: 2,
              child: Icon(
                Icons.done,
              ),
            ),
            const Flexible(
              flex: 1,
              child: SizedBox(
                width: 10,
              ),
            ),
            Flexible(
              flex: 20,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
