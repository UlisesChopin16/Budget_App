import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/expense_model.dart';
import 'package:flutter/material.dart';

class ContainerDataList extends StatelessWidget {
  final String nameContainer;
  final List<ExpenseModel> listModel;

  const ContainerDataList({
    super.key,
    required this.nameContainer,
    required this.listModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: 260,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NormalPoppins(
            text: nameContainer,
            fontSize: 25,
            color: Colors.white,
          ),
          const Divider(
            indent: 30,
            endIndent: 30,
            thickness: 3,
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 210,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: ListView.builder(
              itemCount: listModel.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    NormalPoppins(
                      text: listModel[index].name,
                      color: Colors.white,
                    ),
                    NormalPoppins(
                      text: listModel[index].amount.toString(),
                      color: Colors.white,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
