import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_details/constants/string_constants.dart';
import 'package:employee_details/model/employee_data.dart';
import 'package:employee_details/widget/image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatefulWidget {
  final EmployeeData data;

  const EmployeeDetails({Key? key, required this.data}) : super(key: key);

  @override
  _EmployeeDetailsState createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: Text('${widget.data.name}',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:  CachedNetworkImage(
                    imageUrl: '${widget.data.profileImage??noImage}',
                    height: 90,
                    width: 90,
                    // fit: BoxFit.contain,

                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(150))),
                    ),

                    placeholder: (ctx, url) => Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                      ),
                    ),
                  )
                ),
                SizedBox(
                  height: 30,
                ),
                buildTextPair('Name', widget.data.name),
                buildTextPair('User Name', widget.data.username),
                buildTextPair('Email Address', widget.data.email),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.9)),
                ),
                buildTextPair('Street', widget.data.address?.street??''),
                buildTextPair('City', widget.data.address?.city??''),
                buildTextPair('Zipcode', widget.data.address?.zipcode??''),
                SizedBox(
                  height: 20,
                ),

                buildTextPair('Phone', widget.data.phone??'- -'),
                buildTextPair('Website', widget.data.website),
                buildTextPair('Company', widget.data.company?.name),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${widget.data.company?.catchPhrase}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Colors.black.withOpacity(0.7)),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }


  Widget buildTextPair(label,content) => Column(
crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      SizedBox(
        height: 10,
      ),
      Text(
        "$label",
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black.withOpacity(0.5)),
      ),
      SizedBox(
        height: 2,
      ),
      Text(
        "$content",
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black),
      )




    ],
  );
}
