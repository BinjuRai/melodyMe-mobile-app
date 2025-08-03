import 'package:batch34_b/core/common/sensor/shake_logout_mixin.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/get_profile_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view_model/profile_view_model/profile_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:batch34_b/features/auth/presentation/view_model/profile_view_model/profile_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileProvider extends StatelessWidget {
  final IUserRepository userRepository;

  ProfileProvider({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ProfileBloc(
            getProfile: GetProfile(userRepository: userRepository),
          )..add(LoadProfile()),
      child: ProfileView(), // removed `const`
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ShakeLogoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        foregroundColor: const Color(0xFF222740),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final user = state.user;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade300,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/img1.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // child: const Icon(
                    //   Icons.person,
                    //   size: 50,
                    //   color: Colors.grey,
                    // ),
                  ),
                  const SizedBox(height: 24),

                  // Info Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // _infoRow('👤 Name', user.username),
                          // const Divider(),
                          // _infoRow('📧 Email', user.email),
                          // const Divider(),
                          // _infoRow('📞 Phone', user.phoneno),
                          _infoRow('👤 Name', 'Lily' ?? 'Not provided'),
                          const Divider(),
                          _infoRow(
                            '📧 Email',
                            'lily@gmail.com' ?? 'Not provided',
                          ),
                          const Divider(),
                          _infoRow('📞 Phone', '987886757' ?? 'Not provided'),
                          // _infoRow('👤 Name', user.username ?? 'Not provided'),
                          // const Divider(),
                          // _infoRow('📧 Email', user.email ?? 'Not provided'),
                          // const Divider(),
                          // _infoRow('📞 Phone', user.phoneno ?? 'Not provided'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/auth/login');
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF222740),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Shake device to logout',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// class ProfileView extends StatelessWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Profile')),
//       body: BlocBuilder<ProfileBloc, ProfileState>(
//         builder: (context, state) {
//           if (state is ProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProfileLoaded) {
//             final user = state.user;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Name: ${user.username}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Email: ${user.email}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Phone: ${user.phoneno}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const Spacer(), // Pushes button to bottom
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/auth/login');
//                       },
//                       child: const Text('Logout'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is ProfileError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const Center(child: Text('Please wait...'));
//         },
//       ),
//     );
//   }
// }

// class ProfileView extends StatefulWidget {
//   const ProfileView({Key? key}) : super(key: key);

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> with ShakeLogoutMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Profile')),
//       body: BlocBuilder<ProfileBloc, ProfileState>(
//         builder: (context, state) {
//           if (state is ProfileLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProfileLoaded) {
//             final user = state.user;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Name: ${user.username}',
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Email: ${user.email}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Phone: ${user.phoneno}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const Spacer(),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed('/auth/login');
//                       },
//                       child: const Text('Logout'),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is ProfileError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const Center(child: Text('Please wait...'));
//         },
//       ),
//     );
//   }
// }
