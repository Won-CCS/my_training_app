import 'package:flutter/material.dart';

class TrainingButton extends StatelessWidget {
  const TrainingButton({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        // 枠線
        border: Border.all(color: Colors.blue, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 70,),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Expanded(child: SizedBox()),
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
            )
          )
        ],
      ),
    );
  }

  StatefulWidget buildTrainingList(){
    return 
  }
}