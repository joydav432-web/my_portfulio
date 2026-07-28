import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfulio/feature/project/project_main_screen.dart';
import 'package:my_portfulio/main.dart';

void main() {
  testWidgets('tapping view work opens the projects page', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('VIEW WORK'));
    await tester.pump();

    expect(find.byType(ProjectsPage), findsOneWidget);
  });
}
