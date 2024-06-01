import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_code_camp/constants.dart';
import 'package:free_code_camp/helpers/loading/loading_screen.dart';
import 'package:free_code_camp/services/auth/firebase_auth_provider.dart';
import 'package:free_code_camp/services/bloc/auth_bloc.dart';
import 'package:free_code_camp/services/bloc/auth_event.dart';
import 'package:free_code_camp/services/bloc/auth_state.dart';
import 'package:free_code_camp/views/forgot_password_view.dart';
import 'package:free_code_camp/views/login_view.dart';
import 'package:free_code_camp/views/notes/create_update_note_view.dart';
import 'package:free_code_camp/views/notes/notes_view.dart';
import 'package:free_code_camp/views/register_view.dart';
import 'package:free_code_camp/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      primarySwatch: Colors.blue,
      useMaterial3: true,
    ),
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: const HomePage(),
    ),
    routes: {
      createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please Wait a Moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
