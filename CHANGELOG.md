## 0.9.7

 * Update Dependencies.

## 0.9.6

###  Added

* Integrated `pointer_interceptor` (v0.10.1+2) dependency into the adaptive core shell layout to block platform-view event bleeding.

###  Why This Solution Is Needed (Root Cause)

* **The Sidebar & EndDrawer Leak:** Similar to the dialog overlay issue, when users open the main left Sidebar or the right auxiliary EndDrawer over a background `HtmlElementView` (such as embedded YouTube videos or interactive maps), click and hover events bleed through the Flutter canvas.
* **The Symptom:** Tapping or interacting with forms, menus, or debug modules inside the drawers inadvertently triggers underlying HTML platform view actions (e.g., pausing/playing a video or dragging a map).
* **The Shield:** Injecting a `PointerInterceptor` wrapper right around the drawer boundaries forces the browser DOM to capture and terminate these rogue events, keeping the drawer interaction surface completely insulated.

### ️ Application in `flutter_artist_face`

* **EndDrawer Protection:** Embedded natively inside **`_EndDrawerWrapperState`**, wrapping the root `Drawer` widget.
* **Left Sidebar Protection:** Embedded directly into the **`FaceScreenState`** core scaffold structure, wrapping the primary navigation drawer element (`drawer`).
* **Result:** Both sliding wings are now fully bulletproofed against any platform-view event hijacking out-of-the-box.


## 0.9.5

- Fixed an issue where `ListTile` ink splashes and background colors could be invisible due to strict Material 3 rendering rules on the latest Flutter SDK.
- Wrapped the internal sidebar navigation tree with a transparent `Material` canvas to guarantee touch feedback fidelity.

## 0.9.4

* Fix Bug.

## 0.9.3

* Initial release.
