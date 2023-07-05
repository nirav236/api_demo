import 'dart:convert';

import 'package:datafetch/models/new_model.dart';
import 'package:datafetch/product_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = ScrollController();

  int page = 1;
  int limit = 8;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchPosts();
    scrollController.addListener(scrollListener);
  }

  final url = 'https://dummyjson.com/products';

  Future<void> fetchPosts() async {
    final uri = Uri.parse("$url?_page=$page&_limit=$limit");
    // final uri = Uri.parse("$url?_page=$page");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        newModel = NewModel.fromjson(json);
      });
    } else {
      // print("Unexpected response");
    }
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      page = page + 1;
      await fetchPosts();

      setState(() {
        isLoading = false;
      });
    }
  }

  NewModel? newModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Demo'),
      ),
      body: newModel != null
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              controller: scrollController,
              itemCount: newModel!.products?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (index < newModel!.products!.length) {
                  var product = isLoading
                      ? newModel!.products![index]
                      : newModel!.products![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductView(
                          image: product.images ?? [],
                          description: product.description.toString(),
                          brand: product.brand.toString(),
                        );
                      }));
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 105,
                            width: double.infinity,
                            child: Image.network(
                              "${product.thumbnail}",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "${product.title}",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "${product.discountPercentage} % off",
                                style: const TextStyle(fontSize: 16),
                              )),
                              Text(
                                "₹${product.price}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Text(
                            "Rating:${product.rating}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  Center(child: CircularProgressIndicator());
                }
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
