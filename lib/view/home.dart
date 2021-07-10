import 'package:employee_details/db_provider.dart';
import 'package:employee_details/model/employee_data.dart';
import 'package:employee_details/view/employee_details.dart';
import 'package:employee_details/widget/employee_item.dart';
import 'package:employee_details/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<EmployeeData> employeeData = [];
  List<EmployeeData> searchData = [];

  var isLoading = false;
  var _searchTextController = TextEditingController();

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    if (DBProvider.db.isDataBaseCreated()) {
    } else
      getEmployeeData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? LoadingWidget()
            : GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _searchTextController,
                                  decoration: InputDecoration(
                                      hintText: 'Search',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0, color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0, color: Colors.black26),
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  var searchKey = _searchTextController.text;
                                  if (searchKey == '') {
                                    final snackBar = SnackBar(
                                      content: Text('Search can\'t be empty'),
                                      backgroundColor: Colors.redAccent,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    searchEmployee(searchKey);
                                  }
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  child: Material(
                                    elevation: 5,
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(80),
                                    child: Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      ...searchData.map(
                        (data) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        EmployeeDetails(data: data)));
                          },
                          child: EmployeeItem(
                            data: data,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  searchEmployee(searchKey) async {
    searchData = await DBProvider.db.getSearchedEmployees(searchKey);

    setState(() {
      searchData =
          employeeData.where((element) => element.name == searchKey).toList();
    });

    print('search Data ::: $searchData');
  }

  getEmployeeData() async {
    print("Hit");

    var response = await http
        .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

    debugPrint('Response status :: ${response.statusCode}');
    setState(() {
      isLoading = false;
    });
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      employeeData = employeeDataFromJson(response.body);
      setState(() {
        searchData = employeeData;
      });
      //Inserting Data to DB
      (response.body as List).map((employee) {
        print('Inserting $employee');
        DBProvider.db.createEmployee(EmployeeData.fromJson(employee));
      }).toList();

      print("Employee data :: ${employeeData.length} ${employeeData[0].name}");
    }
  }
}
