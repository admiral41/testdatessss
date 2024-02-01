import 'package:bigtalk/features/auth/domain/entity/auth_entity.dart';
import 'package:bigtalk/features/auth/domain/use_case/follow_usercase.dart';
import 'package:bigtalk/features/auth/domain/use_case/search_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<AuthEntity> searchResults = [];
  bool isSearchLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                key: const ValueKey('search'),
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  hintText: 'Search users by name',
                  hintStyle: const TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.white), // Set border color here
                  ),
                  labelStyle: const TextStyle(color: Colors.white),
                  hintMaxLines: 1,
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
                onFieldSubmitted: (value) {
                  _performSearch();
                },
              ),
              const SizedBox(height: 20),
              if (isSearchLoading)
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
              if (!isSearchLoading && searchResults.isEmpty)
                const Text(
                  'Enter a name to find users',
                  style: TextStyle(color: Colors.redAccent),
                ),
              if (!isSearchLoading && searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      AuthEntity user = searchResults[index];
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            'Name: ${user.name}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Email: ${user.email}',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              _followUser(user.userId); // Call follow method
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text('Follow'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _followUser(String? userId) async {
    if (userId != null) {
      final followResult =
          await ref.read(followUserUseCaseProvider).execute(userId);

      followResult.fold(
        (failure) {
          // Handle follow failure
          // You can use Riverpod to show a snackbar or handle it in your preferred way
        },
        (success) {
          // Handle follow success
          // You may want to update the UI to reflect the followed status
          setState(() {
            // Update the search results to reflect the followed status
            for (var user in searchResults) {
              if (user.userId == userId) {
                // Toggle the follow status
                if (user.followers?.contains(userId) == true) {
                  user.followers?.remove(userId);
                } else {
                  user.followers?.add(userId);
                }
              }
            }
          });
        },
      );
    } else {
      // Handle the case when userId is null, if needed
    }
  }

  void _performSearch() async {
    if (searchController.text.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return; // Exit early if the search query is empty
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        isSearchLoading = true;
      });

      final result = await ref
          .read(searchUserByNameUseCaseProvider)
          .execute(searchController.text);

      result.fold(
        (failure) {
          // Handle search failure
          // You can use Riverpod to show a snackbar or handle it in your preferred way
        },
        (users) {
          setState(() {
            searchResults = users;
            isSearchLoading = false;
          });

          // Optional: Show a snackbar or handle the empty list case
        },
      );
    }
  }
}
