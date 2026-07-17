# Fix Blank Page due to Widget Recursion

The "blank page" issue is caused by an infinite recursion in `MainHomePage`. Its `build` method returns a `MainLayout` that contains `MainHomePage` as its child, leading to a stack overflow or a hang in the rendering process.

## Proposed Changes

### [Home Feature]

#### [MODIFY] [main_home_screen.dart](file:///C:/Users/my/OneDrive/Desktop/flutter- projects/my_portfulio/lib/feature/home/main_home_screen.dart)
- Remove the recursive `child: MainHomePage()` call.
- Implement a `LayoutBuilder` to switch between `DesktopHome` and `MobileHero` based on the screen width.
- Import `DesktopHome` and `MobileHero`.

## Verification Plan

### Manual Verification
- Run the app and verify that the home page renders correctly.
- Resize the window (if on web/desktop) or use different device emulators to verify that it switches between desktop and mobile layouts correctly.
