import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:budget_app/expense_model.dart';
import 'package:flutter/material.dart';

class ContainerDataListM extends StatelessWidget {
  final String nameContainer;
  final List<ExpenseModel> listModel;

  const ContainerDataListM({
    super.key,
    required this.nameContainer,
    required this.listModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NormalPoppins(
          text: nameContainer,
        ),
        Container(
          padding: const EdgeInsets.all(7),
          height: 200,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: Colors.black,
              width: 1,
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
                    fontSize: 12,
                  ),
                  NormalPoppins(
                    text: listModel[index].amount.toString(),
                    fontSize: 12,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
