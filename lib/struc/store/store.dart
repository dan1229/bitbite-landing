/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

import 'package:flutter/material.dart';
import 'package:bitbite_landing/models/user.dart';
import 'package:bitbite_landing/services/service_manager.dart';
import 'package:bitbite_landing/services/shared_preferences.dart';
import 'package:bitbite_landing/widgets/dialogs/toasts.dart';
import 'package:http/http.dart';

/// ===============================================================================
/// STORE =========================================================================
/// ===============================================================================

class Store extends ChangeNotifier {
  late Client client;
  late User user;
  late ServiceManager services;

  Store({
    required this.client,
    required this.services,
    required this.user,
  });

  /// =========================
  /// LOGIN / LOGOUT
  ///
  /// when token is updated, call this to update services and dependencies
  ///
  Future<String> updateToken() async {
    String token = await Preferences().prefGetToken();
    user.token = token;
    services = ServiceManager(client: client);
    return token;
  }

  // log the current user out
  Future<void> logout(
    BuildContext context,
  ) async {
    if (user.loggedIn == true) {
      await Preferences().prefSaveToken("");
      updateToken();
      toastBase(context, message: "You have successfully logged out.");
    } else {
      toastBase(context, message: "You are not logged in.");
    }
  }
}
