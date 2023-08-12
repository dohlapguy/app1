import 'package:flutter/material.dart';
import 'package:app1/data/mock/mock.dart';

class MockScreen extends StatelessWidget {
  const MockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          getAppBar(context),
          getBody(context),
        ],
      ),
    );
  }

  SliverList getBody(context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87.withOpacity(0.5),
            ),
          ),
          const Divider(height: 20, thickness: 1.5),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: List.generate(10, (index) {
              return const ProductTile();
            }),
          )
        ]),
      );
    }, childCount: 1));
  }

  SliverAppBar getAppBar(context) {
    return SliverAppBar(
        snap: true,
        expandedHeight: 70,
        backgroundColor: Theme.of(context).canvasColor,
        floating: true,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 15,
                left: 15,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 232, 232, 232),
                  border: Border.all(color: Color.fromARGB(68, 196, 196, 196)),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: -3,
                        color: Color.fromARGB(137, 158, 158, 158),
                        offset: Offset(3, 3))
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: "Search what you're looking for"),
                ),
              ),
            ),
          ),
        ]);
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 2,
      height: 300,
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 255, 255, 255),
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(68, 130, 130, 130)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: -3,
              color: Color.fromARGB(137, 158, 158, 158),
              offset: Offset(3, 3))
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: (MediaQuery.of(context).size.width - 50) / 2,
              height: 190,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1518390643573-66f352c5492e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      stops: const [0.2, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.black.withOpacity(0.1),
                      ],
                    )),
              ),
            ),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.favorite_border,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {},
              )),
          Positioned(
            bottom: 120,
            right: 15,
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.yellow.shade600,
                  fill: 0.5,
                ),
                const SizedBox(width: 1),
                const Text(
                  "4.9",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          Positioned(
            top: 190,
            left: 4,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Tarmac, Water Bottle",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Vishal Market",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 11),
                      ),
                      SizedBox(height: 35),
                      Text(
                        "\$9.99",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 8,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(210, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(68, 130, 130, 130)),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: -3,
                        color: Color.fromARGB(137, 158, 158, 158),
                        offset: Offset(3, 3))
                  ],
                ),
                child: const Center(
                    child: Text(
                  "ADD",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 86, 201, 90),
                      fontSize: 13),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
