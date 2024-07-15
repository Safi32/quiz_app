import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/widgets/card_info.dart';
import 'package:quiz_app/widgets/checkbox.dart';
import 'package:quiz_app/widgets/payment_method.dart';

class PaymentScreen extends StatelessWidget {
  static const routeName = "payment";
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const PaymentMethod(
                  heading: "Email",
                  hintText: "Enter Your Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                const PaymentMethod(
                  heading: "Payment Method",
                  hintText: "Select Your Payment Method",
                  showIcon: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const PaymentMethod(
                  heading: "Cardholder Name",
                  hintText: "Enter First And Last Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                const PaymentMethod(
                  heading: "Card Number",
                  hintText: "Enter Your Number",
                  showImages: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardInfo(
                        heading: "Expiry Date",
                        hintText: "MM/YY",
                      ),
                      CardInfo(
                        heading: "Expiry Date",
                        hintText: "MM/YY",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomCheckbox(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Subscrible",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
