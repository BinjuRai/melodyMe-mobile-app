import 'package:batch34_b/core/common/card/lesson_card.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_event.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_state.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewWishlistPage extends StatefulWidget {
  final String userId;

  const ViewWishlistPage({super.key, required this.userId});

  @override
  State<ViewWishlistPage> createState() => _ViewWishlistPageState();
}

class _ViewWishlistPageState extends State<ViewWishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(LoadWishlist(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Wishlist")),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WishlistLoaded) {
            if (state.lessons.isEmpty) {
              return const Center(child: Text("Your wishlist is empty."));
            }
            return Padding(
              padding: const EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: state.lessons.length,
                itemBuilder: (context, index) {
                  final lesson = state.lessons[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LessonCard(lesson: lesson, userId: widget.userId),
                  );
                },
              ),
            );
          } else if (state is WishlistError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// class ViewWishlistPage extends StatelessWidget {
//   final String userId;

//   const ViewWishlistPage({super.key, required this.userId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your Wishlist")),
//       body: BlocBuilder<WishlistBloc, WishlistState>(
//         builder: (context, state) {
//           if (state is WishlistLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is WishlistLoaded) {
//             if (state.lessons.isEmpty) {
//               return const Center(child: Text("Your wishlist is empty."));
//             }
//             return Padding(
//               padding: const EdgeInsets.all(12),
//               child: ListView.builder(
//                 itemCount: state.lessons.length,
//                 itemBuilder: (context, index) {
//                   final lesson = state.lessons[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: LessonCard(lesson: lesson, userId: userId),
//                   );
//                 },
//               ),
//             );
//           } else if (state is WishlistError) {
//             return Center(child: Text(state.message));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
