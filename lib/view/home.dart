import 'package:employee_details/model/employee_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container();

  }
  
  
  getEmployeeData() async{
    
    
    var response = await http.get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));


    debugPrint('Response status :: ${response.statusCode}');

    if(response.statusCode >=200 && response.statusCode<=299){
      var employeeData = employeeDataFromJson(response.body);
      print("Employee data :: ${employeeData.length} ${employeeData[0].name}");
    }
    
    
  }
  
  
}
