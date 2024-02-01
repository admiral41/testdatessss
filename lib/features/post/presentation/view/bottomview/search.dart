// import 'package:bigtalk/core/common/snackbar/my_snackbar.dart';
// import 'package:bigtalk/features/auth/domain/entity/auth_entity.dart';
// import 'package:bigtalk/features/auth/domain/use_case/search_usecase.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SearchView extends ConsumerStatefulWidget {
//   const SearchView({Key? key}) : super(key: key);

//   @override
//   ConsumerState<SearchView> createState() => _SearchViewState();
// }

// class _SearchViewState extends ConsumerState<SearchView> {
//   final searchController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   List<AuthEntity> searchResults = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search View'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 key: const ValueKey('search'),
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   hintText: 'Search users by name',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     final result = await ref
//                         .read(searchUserByNameUseCaseProvider)
//                         .execute(searchController.text);

//                     result.fold(
//                       (failure) {
//                         showSnackBar(
//                           message: 'Search failed: ${failure.error}',
//                           color: Colors.red,
//                           context: context,
//                         );
//                       },
//                       (users) {
//                         setState(() {
//                           searchResults = users;
//                         });

//                         if (users.isEmpty) {
//                           showSnackBar(
//                             message: 'No users found',
//                             color: Colors.black,
//                             context: context,
//                           );
//                         }
//                       },
//                     );
//                   }
//                 },
//                 child: const Text('Search'),
//               ),
//               const SizedBox(height: 20),
//               if (searchResults.isNotEmpty)
//                 SizedBox(
//                   height: 400,
//                   child: ListView.builder(
//                     itemCount: searchResults.length,
//                     itemBuilder: (context, index) {
//                       AuthEntity user = searchResults[index];
//                       return Card(
//                         color: Colors.white,
//                         child: ListTile(
//                           title: Text(
//                             'Name: ${user.name}',
//                             style: const TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                           subtitle: Text(
//                             'Email: ${user.email}',
//                             style: const TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
