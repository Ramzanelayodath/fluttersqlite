import 'package:flutter/material.dart';
import 'package:flutter_sqlite/DBHelper.dart';
import 'package:flutter_sqlite/Employee.dart';
import 'package:flutter_sqlite/EmployeeList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  BuildContext Context;
  @override
  Widget build(BuildContext context) {
    Context = context;
    return MaterialApp(
      title: "Sqlite",
      debugShowCheckedModeBanner: false,
      home: Sqliteclass()
    );

  }
}
class Sqliteclass extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SqliteclassState();
  }

}
class SqliteclassState extends State<Sqliteclass>
{
  Employee employee = new Employee("", "", "", "");
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String firstname;
  String lastname;
  String emailId;
  String mobileno;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Sqlite",
            style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.view_list),tooltip: 'View Employess', onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeList()),
              );
            })
          ],
        ),
        body: new Padding(padding: EdgeInsets.all(8.0),
            child: Form(key : formKey,child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (val) =>
                  val.length == 0 ?"Enter Firstname" : null,
                  onSaved: (val) =>this.firstname = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(labelText: 'Last Name'),
                  validator: (val) =>
                  val.length ==0 ? 'Enter LastName' : null,
                  onSaved: (val) => this.lastname = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(labelText: 'Mobile No'),
                  validator: (val) =>
                  val.length ==0 ? 'Enter Mobile No' : null,
                  onSaved: (val) => this.mobileno = val,
                ),
                new TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: new InputDecoration(labelText: 'Email Id'),
                  validator: (val) =>
                  val.length ==0 ? 'Enter Email Id' : null,
                  onSaved: (val) => this.emailId = val,
                ),
                new Container(margin: const EdgeInsets.only(top: 10.0),child: new RaisedButton(onPressed: _submit,
                  child: new Text('Login'),),)

              ],
            )))
    );
  }
  void _submit()
  {
       if(this.formKey.currentState.validate())
      {
        formKey.currentState.save();
      }
      else {return null;}
        var employee = Employee(firstname,lastname,mobileno,emailId);
        print(firstname);
        var dbHelper = DBHelper();
        dbHelper.saveEmployee(employee);
        _showsnackBar("Data Saved Successfully");


  }

  void _showsnackBar(text)
  {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
  }

}
