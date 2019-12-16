import 'package:aurora_mail/database/app_database.dart';
import 'package:aurora_mail/generated/i18n.dart';
import 'package:aurora_mail/modules/mail/screens/messages_list/messages_list_route.dart';
import 'package:aurora_mail/modules/settings/blocs/settings_bloc/bloc.dart';
import 'package:aurora_mail/theming/app_theme.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';
import 'package:aurora_mail/main.dart' as main;
import 'app_navigation.dart';
import 'auth/blocs/auth_bloc/bloc.dart';
import 'auth/screens/login/login_route.dart';
import 'contacts/blocs/contacts_bloc/bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _authBloc = new AuthBloc();
  final _settingsBloc = new SettingsBloc();
  ContactsBloc _contactsBloc;
  PackageInfo _appInfo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initApp();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      main.isBackground = true;
    } else if (state == AppLifecycleState.resumed) {
      main.isBackground = false;
      _settingsBloc.add(OnResume());
    }
    super.didChangeAppLifecycleState(state);
  }

  void _initApp() async {
    _appInfo = await PackageInfo.fromPlatform();
    _authBloc.add(InitUserAndAccounts());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _settingsBloc.add(UpdateConnectivity(result));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _authBloc.close();
    _settingsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        condition: (_, state) => state is InitializedUserAndAccounts,
        builder: (_, authState) {
          if (authState is InitializedUserAndAccounts) {
            if (authState.user != null) {
              _contactsBloc = new ContactsBloc(
                apiUrl: AuthBloc.apiUrl,
                token: AuthBloc.currentUser.token,
                userId: AuthBloc.currentUser.serverId,
                appDatabase: DBInstances.appDB,
              );
              _settingsBloc.add(InitSettings(authState.user));
              _contactsBloc.add(GetContacts());
            }
            return BlocBuilder<SettingsBloc, SettingsState>(
                bloc: _settingsBloc,
                builder: (_, settingsState) {
                  if (settingsState is SettingsLoaded) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<AuthBloc>.value(
                          value: _authBloc,
                        ),
                        BlocProvider<SettingsBloc>.value(
                          value: _settingsBloc,
                        ),
                        BlocProvider<ContactsBloc>.value(
                          value: _contactsBloc,
                        ),
                      ],
                      child: MaterialApp(
                        title: _appInfo.appName,
                        onGenerateRoute: AppNavigation.onGenerateRoute,
                        theme: settingsState.darkThemeEnabled
                            ? AppTheme.dark
                            : AppTheme.light,
                        localizationsDelegates: [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          S.delegate
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        localeResolutionCallback: S.delegate.resolution(
                            fallback: new Locale("en", ""), withCountry: false),
                        locale: settingsState.language != null
                            ? settingsState.language.toLocale()
                            : null,
                        initialRoute: authState.needsLogin
                            ? LoginRoute.name
                            : MessagesListRoute.name,
                      ),
                    );
                } else {
                  return Material();
                }
              });
        } else {
          return Material();
        }
      },
    );
  }
}

