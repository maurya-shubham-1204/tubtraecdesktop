import 'package:flutter_test/flutter_test.dart';
import 'package:tubtrace_desktop/services/formula_evaluator.dart';

void main() {
  test('calculates #id formula and rounds', () {
    expect(FormulaEvaluator.calculate('(#1)/(#2)*100', {1: '4.5', 2: '9'}), 50);
    expect(FormulaEvaluator.calculate('(#1)/(#2)', {1: '4.5'}), isNull);
  });

  test('group sum validates within 0.01', () {
    const rows = [
      (
        patientTestId: 1,
        sectionTitle: 'Diff',
        groupSumEquals: 100.0,
        parameterId: 1,
        valueType: 'float',
      ),
      (
        patientTestId: 1,
        sectionTitle: 'Diff',
        groupSumEquals: 100.0,
        parameterId: 2,
        valueType: 'float',
      ),
    ];
    expect(FormulaEvaluator.validateGroupSums(rows, {1: '40', 2: '60'}), isNull);
    expect(FormulaEvaluator.validateGroupSums(rows, {1: '40', 2: '50'}), isNotNull);
  });
}
