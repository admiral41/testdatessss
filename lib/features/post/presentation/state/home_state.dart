import 'package:bigtalk/features/post/presentation/view/bottomview/dashboard_view.dart';
import 'package:bigtalk/features/post/presentation/view/bottomview/favorite_view.dart';
import 'package:bigtalk/features/post/presentation/view/bottomview/post_view.dart';
import 'package:bigtalk/features/post/presentation/view/bottomview/profile_view.dart';
import 'package:bigtalk/features/post/presentation/view/bottomview/search_view.dart';
import 'package:flutter/material.dart';

class HomeState {
  final int index;
  final List<Widget> listWidgets;

  HomeState({required this.index, required this.listWidgets});

  HomeState.initialState()
      : index = 0,
        listWidgets = const [
          HomeView(),
          SearchView(),
          PostView(),
          FavoriteView(),
          ProfileView(),
        ];
  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
      listWidgets: listWidgets,
    );
  }
}
