import 'package:flutter/material.dart';

class CustomSearchSheet extends StatelessWidget {
  const CustomSearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> recommended = [
      "Ceviche",
      "Ratatouille",
      "Tajine",
      "Miso Soup",
      "Paella",
      "Vegan",
      "Seaweed Salad",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top search field
          TextField(
            decoration: InputDecoration(
              hintText: "Search recipes...",
              prefixIcon: const Icon(Icons.search, color: Colors.pink),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Recommended Recipes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: recommended
                .map((e) => Chip(
              label: Text(e),
              backgroundColor: Colors.pink.shade50,
              labelStyle: const TextStyle(color: Colors.pink),
            ))
                .toList(),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(Icons.add_circle, color: Colors.pink),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Add Allergies",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Search Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {},
              child: const Text(
                "Search",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
