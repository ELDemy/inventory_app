import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/core/components/failure_screen.dart';
import 'package:inventory_app/di/injector.dart';

import '../../data/report_cubit/dashboard_cubit.dart';
import 'dashboard_content.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.register<DashboardCubit>(DashboardCubit()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تقارير العمل'),
          actions: [
            IconButton(
              icon: const Icon(Icons.repeat_on),
              onPressed: () => generateFakeOrders(200),
            ),
          ],
        ),
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashboardFailure) {
              return _failureScreen(state, context);
            } else if (state is DashboardSuccess) {
              return const DashboardContent();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  FailureScreen _failureScreen(DashboardFailure state, BuildContext context) {
    return FailureScreen(
      errMsg: state.errMsg,
      onTap: () => context.read<DashboardCubit>().getAllOrders(),
    );
  }

  void generateFakeOrders(int numberOfOrders) {
    final employees = [
      'محمود محمد احمد',
      "خالد مصطفى عبدالله",
      "عبدالرحمن محمد احمد",
      "احمد محمد احمد",
      "مؤمن صابر احمد",
      "مازن عادل محمود",
      "عبدالله مرزوق خديوي",
    ];

    final clientData = [
      {"name": "مصنع الفجر", "phone": "01012345678", "type": "مصنع"},
      {"name": "مؤسسة المستقبل", "phone": "01123456789", "type": "مورد"},
      {"name": "شركة الأمل", "phone": "01234567890", "type": "تاجر"},
      {"name": "مصنع النهضة", "phone": "01567890123", "type": "مصنع"},
      {"name": "مؤسسة النور", "phone": "01098765432", "type": "مورد"},
      {"name": "شركة النجاح", "phone": "01056789012", "type": "تاجر"},
      {"name": "مصنع الكوثر", "phone": "01187654321", "type": "مصنع"},
      {"name": "شركة البدر", "phone": "01223456789", "type": "مورد"},
      {"name": "شركة الهدى", "phone": "01554321678", "type": "تاجر"},
      {"name": "مصنع الرائد", "phone": "01034567891", "type": "مصنع"},
      {"name": "شركة الحرمين", "phone": "01176543210", "type": "مورد"},
      {"name": "مؤسسة الفتح", "phone": "01265432109", "type": "تاجر"},
      {"name": "مصنع التوفيق", "phone": "01543210987", "type": "مصنع"},
      {"name": "شركة الشروق", "phone": "01045678901", "type": "مورد"},
      {"name": "مؤسسة الإيمان", "phone": "01198765432", "type": "تاجر"},
      {"name": "مصنع السلام", "phone": "01278945601", "type": "مصنع"},
      {"name": "مؤسسة البركة", "phone": "01532109876", "type": "مورد"},
      {"name": "شركة التعاون", "phone": "01065432198", "type": "تاجر"},
      {"name": "مؤسسة الرؤية", "phone": "01134567890", "type": "مصنع"},
      {"name": "شركة المستقبل الباهر", "phone": "01298765432", "type": "مورد"},
      {"name": "شركة البناء", "phone": "01598765432", "type": "تاجر"},
      {"name": "مصنع الأنوار", "phone": "01012398765", "type": "مصنع"},
      {"name": "شركة الثقة", "phone": "01145678901", "type": "مورد"},
      {"name": "مؤسسة الرخاء", "phone": "01265498732", "type": "تاجر"},
      {"name": "مصنع الريادة", "phone": "01578965432", "type": "مصنع"}
    ];

    final products = [
      {
        "modelName": "غسالة سوبر 1000",
        "identifierSN": "A0016853660332407",
        "category": "غسالة",
        "price": 5000,
      },
      {
        "modelName": "ثلاجة كول 200",
        "identifierSN": "A5013800040002304",
        "category": "ثلاجة",
        "price": 7000,
      },
      {
        "modelName": "شاشة سمارت 500",
        "identifierSN": "802R2G124FC",
        "category": "شاشة",
        "price": 8000,
      },
      {
        "modelName": "كمبيوتر سريع 3000",
        "identifierSN": "8O1R5G324FC",
        "category": "كمبيوتر",
        "price": 15000,
      },
      {
        "modelName": "ميكروويف فائق 700",
        "identifierSN": "802R2G324FC",
        "category": "ميكروويف",
        "price": 3000,
      },
      {
        "modelName": "خلاط باور 150",
        "identifierSN": "80R75G324FC",
        "category": "خلاط",
        "price": 1200,
      },
      {
        "modelName": "مكيف بارد 4000",
        "identifierSN": "801R5G124FC",
        "category": "مكيف",
        "price": 10000,
      },
      {
        "modelName": "مكانس برو 900",
        "identifierSN": "A0016858410062407",
        "category": "مكنسة",
        "price": 2500,
      },
      {
        "modelName": "فرن كهربائي 2500",
        "identifierSN": "A5013801730002312",
        "category": "فرن",
        "price": 4000,
      },
      {
        "modelName": "غسالة صغيرة 800",
        "identifierSN": "B0016853660332407",
        "category": "غسالة",
        "price": 3000,
      },
      {
        "modelName": "ثلاجة عائلية 600",
        "identifierSN": "C5013800040002304",
        "category": "ثلاجة",
        "price": 9000,
      },
      {
        "modelName": "شاشة 4K بلس",
        "identifierSN": "D802R2G124FC",
        "category": "شاشة",
        "price": 10000,
      },
      {
        "modelName": "كمبيوتر ألعاب 5000",
        "identifierSN": "E8O1R5G324FC",
        "category": "كمبيوتر",
        "price": 20000,
      },
    ];

    final random = Random();

    for (int i = 0; i < numberOfOrders; i++) {
      // Select random employee
      final employee = employees[random.nextInt(employees.length)];

      // Select random client
      final client = clientData[random.nextInt(clientData.length)];

      // Select random product
      final Map<String, Object> product =
          products[random.nextInt(products.length)];

      // Generate unique serial numbers for the quantity
      final quantity =
          random.nextInt(10) + 1; // Random quantity between 1 and 10
      final serialNumbers = List.generate(quantity, (index) {
        String identifier = product['identifierSN'] as String;

        // Check if identifier starts with 'A'
        if (identifier.length > 17) {
          // Generate serial number for 'A' identifiers (17 characters identifier + 4 random numbers)
          return "${identifier.substring(0, 17)}${random.nextInt(10000)}"
              .padRight(21, '0');
        } else if (identifier.length > 11) {
          // Generate serial number for '8' identifiers (11 characters identifier + 5 random numbers)
          return "${identifier.substring(0, 11)}${random.nextInt(100000)}"
              .padRight(16, '0');
        }
        // Default case (if identifier doesn't start with 'A' or '8', you can add logic here if needed)
        return identifier;
      });

      // Generate random creation time within the last 6 months
      final creationTime = DateTime.now().subtract(Duration(
        days: random.nextInt(180), // Random day within 6 months
      ));

      // Log or save the generated order
      Map<String, dynamic> order = {
        "creationTime": creationTime,
        "employee": employee,
        "product": {
          "identifierSN": product["identifierSN"],
          "modelName": product["modelName"],
          "category": product["category"],
          "price": product["price"],
          "quantity": quantity,
          "power": product["power"],
          "input": product["input"],
          "output": product["output"],
        },
        "serialNumbers": serialNumbers,
        "price": (product["price"]! as num) * quantity,
        "quantity": quantity,
        "clientName": client["name"],
        "clientPhoneNumber": client["phone"],
        "clientType": client["type"],
      };

      Injector.ordersHistoryCollection.doc().set(order);

      print("$i - $creationTime -${order['product']['modelName']}");
    }
  }
}
