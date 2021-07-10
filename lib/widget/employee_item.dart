import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee_details/constants/string_constants.dart';
import 'package:employee_details/model/employee_data.dart';
import 'package:flutter/material.dart';

class EmployeeItem extends StatelessWidget {
  final EmployeeData data;

  const EmployeeItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: '${data.profileImage ?? noImage}',
                height: 80,
                width: 80,
                // fit: BoxFit.contain,

                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(150))),
                ),

                placeholder: (ctx, url) => Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.name}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data.company?.name ?? ''}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data.email}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
