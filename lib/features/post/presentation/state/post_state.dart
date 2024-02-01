class PostState {
  final bool isLoading;
  final String? error;
  final bool? showMessage;

  PostState({
    required this.isLoading,
    this.error,
    this.showMessage,
  });

  factory PostState.initial() {
    return PostState(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  PostState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  @override
  String toString() => 'PostState(isLoading: $isLoading, error: $error)';
}
