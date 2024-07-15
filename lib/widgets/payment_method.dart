import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
    required this.heading,
    required this.hintText,
    this.showIcon = false,
    this.showImages = false,
  });

  final String heading;
  final String hintText;
  final bool showIcon;
  final bool showImages;

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                widget.heading,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: widget.hintText,
              fillColor: Colors.grey.shade200,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.showImages)
                    const Row(
                      children: [
                        ImageIcon(
                          AssetImage("assets/card1.png"),
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        ImageIcon(
                          AssetImage("assets/card2.png"),
                          size: 32,
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  if (widget.showIcon)
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: 40,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


