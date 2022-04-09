import 'package:flutter/material.dart';

import '../app_theme.dart';

class CWSearchbar extends StatelessWidget {
  const CWSearchbar({Key? key, required this.searchKeyWord}) : super(key: key);

  final String searchKeyWord;

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    // Container(
    //   color: Colors.yellow,
    //   child: IconButton(
    //       onPressed: () {},
    //       icon: const Icon(
    //         Icons.wrap_text_rounded,
    //         size: 28.0,
    //       )),
    // )
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: InkWell(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: AppThemeData.appColorLightGrey,
              filled: true,
              hintText: 'Search',
              suffixIconColor: AppThemeData.appColorLightGrey,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppThemeData.appColorGrey,
              ),
            ),
            controller: _searchController,
            keyboardType: TextInputType.text,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
