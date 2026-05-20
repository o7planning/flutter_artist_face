
# flutter_artist_face

A high-performance, responsive, and completely standalone Admin/Dashboard shell layout architecture for Flutter applications. It provides a highly customizable scaffold matrix featuring adaptive expandable navigation sidebars, unified global topbars, and declarative layout boundaries that fit seamlessly on Web, Desktop, and Mobile viewports.


[LIVE DEMO](https://o7planning.github.io/demo/flutter/flutter_artist_face_demo/)

[Download Demo Source Code](https://github.com/o7planning/flutter_artist_face_demo)

![FlutterArtist Face Demo](https://o7planning.github.io/static/demo/flutter/flutter_artist_face_demo/images/demo.gif)
---

##  Key Architectural Principles

Unlike rigid dashboard templates, `flutter_artist_face` is engineered with absolute architectural decoupling in mind:
* **100% Standalone & Independent:** Zero hard-coded dependencies on external design tokens or proprietary state management packages. It operates out-of-the-box in any vanilla Flutter project.
* **Seed-Driven Style Engine:** Features a smart constructor pipeline capable of generating full, high-contrast, cohesive light or dark presentation themes from a single base Flutter `seedColor`.
* **Inversion of Control (IoC Layout):** Uses specialized presentation delegates (`FaceStyle`) and explicit runtime building hooks, allowing engineering teams to map the dashboard shell to their pre-existing design system configurations.

---

## ️ Style Configuration Models

The visual layer is driven by the `FaceStyle` composition token cluster. You can initialize it using two distinct strategies depending on your target runtime requirements:

### 1. The Explicit Strategy
Demand full control by passing precise parameters explicitly into the standard constructor:

```dart
const FaceStyle(
  scaffoldBackground: Colors.white,
  topbarStyle: TopbarStyle(
    backgroundColor: Colors.blue,
    iconColor: Colors.white,
    textColor: Colors.white,
  ),
  sidebarStyle: SidebarStyle(
    backgroundColor: Colors.grey,
    expandedWidth: 240,
    collapsedWidth: 60,
    // ... complete customized typography and alignment properties
  ),
);
```

### 2. The Adaptive Simple Strategy

Instantly derive a harmonized, material-compliant color scheme palette using a single core baseline color token:

```dart
// Automatically generates responsive contextual accents, surface mappings, and hover indicators
final adaptiveStyle = FaceStyle.simple(Colors.indigo, brightness: Brightness.light);
```

---

## 里 Implementational Setup Guide

To deploy the administrative view matrix, extend your screen workspace from the base `FaceScreen` structural component:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_artist_face/flutter_artist_face.dart';

class AdminDashboardPortal extends FaceScreen {
  const AdminDashboardPortal({super.key});

  @override
  void onNavigateTo(BuildContext context, String route) {
    // Integrate your central application navigator driver here (e.g., Navigator.pushNamed)
    Navigator.of(context).pushNamed(route);
  }

  @override
  FaceStyle buildStyle(BuildContext context) {
    // MANDATED HOOK: Build and return your tailored configuration
    // You can safely return FaceStyle.simple(Theme.of(context).primaryColor) here
    return FaceStyle.simple(Colors.teal);
  }

  @override
  List<SidebarMenuGroupModel> buildSidebarMenuGroupModels(BuildContext context) {
    return [
      SidebarMenuGroupModel(
        title: 'MANAGEMENT',
        subtitle: 'Core Operations',
        showHeader: true,
        menus: [
          SidebarMenuItemModel(menuTitle: 'Analytics', iconData: Icons.analytics, route: '/charts'),
          SidebarMenuItemModel(menuTitle: 'Inventory', iconData: Icons.storage, route: '/stock'),
        ],
      )
    ];
  }

  @override
  SidebarMenuItemModel? buildConfigurationMenuItemModel(BuildContext context) {
    return const SidebarMenuItemModel(menuTitle: 'System Settings', iconData: Icons.settings, route: '/settings');
  }

  @override
  Widget buildTopMenuLeading({required BuildContext context, required FaceStyle effectiveStyle}) => const Text("Corporate Portal");
  @override
  Widget buildTopMenuCenter({required BuildContext context, required FaceStyle effectiveStyle}) => const SizedBox.shrink();
  @override
  Widget buildTopMenuTrailing({required BuildContext context, required FaceStyle effectiveStyle}) => const CircleAvatar(child: Icon(Icons.person));
  
  @override
  Widget buildSidebarExpandedLogo({required BuildContext context, required FaceStyle effectiveStyle}) => const Text("WIDE LOGO");
  @override
  Widget buildSidebarCollapsedLogo({required BuildContext context, required FaceStyle effectiveStyle}) => const Icon(Icons.bolt);
  @override
  Widget buildSidebarExpandedProfile({required BuildContext context, required FaceStyle effectiveStyle}) => const Text("User Info Block");
  @override
  Widget buildSidebarCollapsedProfile({required BuildContext context, required FaceStyle effectiveStyle}) => const SizedBox.shrink();

  @override
  Widget buildBody({required BuildContext context, required FaceStyle effectiveStyle}) {
    return const Center(child: Text("Main Admin Panel Canvas Workspace"));
  }

  @override
  Widget? buildFooter({required BuildContext context, required FaceStyle effectiveStyle}) => const Text("v1.0.0 Stable Deployment");
  @override
  Widget? buildEndDrawer({required BuildContext context, required FaceStyle effectiveStyle}) => null;
}
```
 
---

##  Installation Manifest

Add this configuration segment directly into your target project's `pubspec.yaml` dependency tracking descriptor file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_artist_face: ^latest_version
``` 