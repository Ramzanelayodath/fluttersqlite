
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/DBHelper.dart';
import 'package:flutter_sqlite/Employee.dart';

Future<List<Employee>> fetchEmployeesFromDatabase() async {
  var dbHelper = DBHelper();
  Future<List<Employee>> employees = dbHelper.getEmployees();
  return employees;
}

class EmployeeList extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmployeeListState();
  }


}

class EmployeeListState extends State<EmployeeList>
{


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Employee List",style: TextStyle(color: Colors.black))),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<List<Employee>>(
            future: fetchEmployeesFromDatabase(),
            builder: (context,snapshot)
        {
          if(snapshot.hasData)
            {
              return ListView.builder(itemCount : snapshot.data.length,
                  itemBuilder: (context,index){

                   return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       new Text(snapshot.data[index].firstName,
                          style:TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,

                          ),
                        ),
                       new Text(snapshot.data[index].lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 14.0
                        ),),
                       new Divider()
                      ],
                    );
                  });
            }
            else if(snapshot.hasError)
              {
                print(snapshot.error);
                return  Text("${snapshot.error}");
              }
              return Container(
                alignment: AlignmentDirectional.center,
                child:CircularProgressIndicator()
              );
        }),
      ) ,
    );
  }

}