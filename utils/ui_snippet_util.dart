import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notetask/main.dart';


/// Hold place with easy abstraction
class Hold extends StatelessWidget {
  const Hold(this.height, [this.width, Key? key])
      : super(key: key);

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? 0,
    );
  }
}


/// For good perforamance state management 
class StateSaver extends StatelessWidget {
  const StateSaver({ Key? key ,required this.value, required this.onValue}) : super(key: key);

  final ValueListenable value;
  final Widget Function(dynamic value) onValue;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(    
      valueListenable: value,
      builder: (context,value,child)=>onValue(value),
    );
  }
}




//----------------------------------- Debug Section -----------------------------------//

/// Debug Button with easy abstraction
Widget dbutton(String name,VoidCallback listen)
{
   return ElevatedButton(    
    child:  Text(name),
    onPressed: listen,
   );
}


/// Debug Value Input with easy abstraction
Widget dInput(String hint,Function(String value) output,{TextInputType? inputType})
{ 
  var _key = GlobalKey<FormState>();
  final _controller = TextEditingController();
  return SizedBox(
    width: 100,
    child: Column(    
      children: [    
        TextFormField(
          key: _key,
          controller:_controller,
          validator: (stream)=>null,
          keyboardType: inputType ?? TextInputType.text,
          decoration: InputDecoration(hintText: hint),
        ),
        dbutton('Submit',(){
          st("Submit is clicked");
          output(_controller.text);
        })
      ],
    ),
  );
}


//----------------------------------- End Section -----------------------------------//
