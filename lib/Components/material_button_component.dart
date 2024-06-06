import 'package:flutter/material.dart';

class MaterialButtonComponent extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  

  const MaterialButtonComponent({
    super.key,
    this.onPressed,
    this.child, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding,
      elevation: 20,
      onPressed: onPressed,
      splashColor: Colors.grey,
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
