import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tasks/core/routes/routes.dart';

import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../widgets/costum_bottom_navbar.dart';
import '../../widgets/default_app_bar.dart';
import 'widgets/my_list_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DefaultAppBar(color: Colors.white, title: "profile"),
            ListTile(
              leading: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image.network(
                  "https://images.unsplash.com/photo-1506863530036-1efeddceb993?q=80&w=3444&auto=format&fit=crop",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                "John weak",
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_square, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // _iconText(
            //   context,
            //   icon: Icons.mail_rounded,
            //   body: "email@mail.com",
            // ),
            // _iconText(
            //   context,
            //   icon: Icons.location_on_rounded,
            //   body: "My location",
            // ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("setting", style: TextStyle(color: Colors.grey)),
                    Expanded(
                      child: ListView(
                        children: [
                          MyListTile(
                            title: "notification",
                            trailing: Switch(value: false, onChanged: (v) {}),
                          ),
                          MyListTile(
                            onTap: () =>
                                Navigator.pushNamed(context, "clientAccount"),
                            title: "account",
                          ),
                          MyListTile(
                            onTap: () =>
                                Navigator.pushNamed(context, "clientSecurity"),
                            title: "security",
                          ),
                          MyListTile(
                            onTap: () =>
                                Navigator.pushNamed(context, "clientHelp"),
                            title: "help",
                          ),
                          MyListTile(
                            onTap: () =>
                                Navigator.pushNamed(context, "clientAbout"),
                            title: "about",
                          ),
                        ],
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutRequested());

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.login,
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text("logout"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CostumBottomNavbar(),
    );
  }
}
