import 'package:flutter/material.dart';

Widget searchBar(
  TextEditingController searchController,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(
      20,
      0,
      20,
      10,
    ),
    child: Container(
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 5,
            ),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration.collapsed(
                hintText: "search",
              ),
              controller: searchController,
            ),
          ),
        ],
      ),
    ),
  );
}
