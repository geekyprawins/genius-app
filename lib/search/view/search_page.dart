import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:genius/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final dio = Dio();
  String _searchTerm = "";

  void performSearch(String q) async {
    final response = await dio.get(
      Constants.searchUrl,
      queryParameters: {'q': q},
      options: Options(headers: Constants.headers),
    );
    print(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (v) {
                        _searchTerm = v;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search any song/artist',
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please enter a search term';
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          var isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            performSearch(_searchTerm);
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 10,
                        ),
                        child: const Text('Search'),
                      ),
                    ),
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
