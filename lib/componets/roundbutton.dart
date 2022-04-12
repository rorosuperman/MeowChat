
import 'package:flutter/material.dart';
class Roundedbutton extends StatelessWidget {


  Roundedbutton ({@required this.onpressed,this.colors,this.title,this.style});
  final Color?colors ;
  final String? title ;
  final void Function()? onpressed ;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        color: colors,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed:onpressed,
          minWidth: 200.0,
          height: 80.0,
          child: Text(
            title!,
            style:style,
          ),
        ),
      ),
    );
  }
}
