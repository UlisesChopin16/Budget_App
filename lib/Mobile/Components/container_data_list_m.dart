import 'package:budget_app/Components/poppins_style_component.dart';
import 'package:flutter/material.dart';

class ContainerDataListM extends StatelessWidget {
  final String nameContainer;
  final List names;
  final List amounts;

  const ContainerDataListM({
    super.key,
    required this.names,
    required this.amounts,
    required this.nameContainer,
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
            itemCount: amounts.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  NormalPoppins(
                    text: names[index],
                    fontSize: 12,
                  ),
                  NormalPoppins(
                    text: amounts[index],
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
