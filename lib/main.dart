import 'package:flutter/material.dart';
import 'sqlite_db.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BMI(),
    );
  }
}

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  TextEditingController bmiController = TextEditingController();
  String identity = "Male";
  String message = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator", style: TextStyle(color: Colors.white)),backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Your Fullname",
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: TextField(
              controller: heightController,
              decoration: InputDecoration(
                labelText: "height in cm; 170",
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: TextField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: "Weight in KG",
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: TextField(
              controller: bmiController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "BMI Value",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
              child: RadioListTile(
                title: Text("Male"),
                  value: "Male",
                  groupValue: identity,
                  onChanged: (value) {
                    setState(() {
                      identity = value.toString();
                    });
                  },
              )),
              Container(
                width: 200,
              child: RadioListTile(
                title: Text("Female"),
                  value: "Female",
                  groupValue: identity,
                  onChanged: (value) {
                    setState(() {
                      identity = value.toString();
                    });
                  },
              ),)
            ],
          ),
          ElevatedButton(
              onPressed: (){
                String height = heightController.text.trim();
                String weight = weightController.text.trim();
                double _height = double.parse(height)/100;
                double _weight = double.parse(weight);
                double bmi = _weight/ (_height*_height);
                bmi = double.parse(bmi.toStringAsFixed(1));
                setState(() {
                  nameController.clear();
                  heightController.clear();
                  weightController.clear();
                  bmiController.text = bmi.toString();
                });

                if(identity == "Male"){
                  if(bmi < 18.5)
                    message = "Underweight. Careful during strong wind!";
                  else if(bmi >= 18.5 && bmi <= 24.9)
                    message = "That's ideal! Please maintain";
                  else if(bmi >= 25.0 && bmi <= 29.9)
                    message = "Overweight! Work out please";
                  else if(bmi >= 30.0)
                    message = "Whoa Obese! Dangerous mate!";
                }
                else{
                  if(bmi < 16)
                    message = "Underweight. Careful during strong wind!";
                  else if(bmi >= 16 && bmi <= 22)
                    message = "That's ideal! Please maintain";
                  else if(bmi >= 22 && bmi <= 27)
                    message = "Overweight! Work out please";
                  else if(bmi >= 27.0)
                    message = "Whoa Obese! Dangerous mate!";
                };

              },
              child: Text("Calculate BMI and Save")

          ),
          Text(message)
        ],
      ),
    );
  }
}
