import 'package:flutter/material.dart';
import 'package:quiz_app/utils/colors.dart';
import 'package:quiz_app/view/screens/payment_screen/payment_screen.dart';
import 'package:quiz_app/widgets/payment.dart';

class ChooseYourPlan extends StatelessWidget {
  static const routeName = "plan";
  const ChooseYourPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 30,
                    ),
                    child: Text(
                      "Choose Your Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Column(
                children: [
                  Payment(
                    title: "Yearly",
                    offerText: "BEST VALUE",
                    dollar: "\$120",
                    discount: "+ Save 50%",
                    discountOffer: "\$60",
                    freeTrail: "Get 7 Days Free",
                    year: "Yearly",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Payment(
                    title: "3 Months",
                    offerText: "MOST POPULAR",
                    dollar: "\$30",
                    discount: "+ Save 20%",
                    discountOffer: "\$25",
                    freeTrail: "Get 3 Days Free",
                    year: "Quater",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Payment(
                    title: "1Month",
                    dollar: "\$10",
                    discountOffer: "\$8.4",
                    freeTrail: "+ Save 16%  ",
                    year: "Monthly",
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Text(
                  "If you choose to purchase a subscription, payment will be charged to your iTunes account, and your account will be charged within 24-hours prior to the end of the current period for \$8.4/ months.You can cancel the automatic reward of your subscription at any time by going to your setting in the iTunes stores after purchase",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PaymentScreen.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: primaryColor,
                    ),
                    child: const Text(
                      "Continue to purchase",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
