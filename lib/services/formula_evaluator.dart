/// Safe formula evaluation matching web `App\Support\FormulaEvaluator`.
///
/// Expressions use `#paramId` references, e.g. `(#23)/(#24)*100`.
/// After substitution only `0-9 + - * / ( ) .` are allowed.
class FormulaEvaluator {
  static final _refRe = RegExp(r'#(\d+)');
  static final _safeExprRe = RegExp(r'^[0-9+\-*/().]+$');

  static List<int> referencedIds(String formula) {
    if (formula.trim().isEmpty) return const [];
    return _refRe.allMatches(formula).map((m) => int.parse(m.group(1)!)).toList();
  }

  static bool isNumericReading(dynamic value) {
    if (value == null) return false;
    final s = '$value'.trim();
    if (s.isEmpty || s.toLowerCase() == 'nan') return false;
    final n = double.tryParse(s);
    return n != null && n.isFinite;
  }

  static bool hasAllInputs(String formula, Map<int, String> valuesByParamId) {
    final ids = referencedIds(formula);
    if (ids.isEmpty) return false;
    for (final id in ids) {
      if (!valuesByParamId.containsKey(id) || !isNumericReading(valuesByParamId[id])) {
        return false;
      }
    }
    return true;
  }

  /// Returns rounded result (2dp) or null if incomplete / invalid.
  static double? calculate(String formula, Map<int, String> valuesByParamId) {
    if (!hasAllInputs(formula, valuesByParamId)) return null;

    var expr = formula;
    for (final id in referencedIds(formula)) {
      expr = expr.replaceAll('#$id', valuesByParamId[id]!.trim());
    }
    expr = expr.replaceAll(RegExp(r'\s+'), '');
    if (expr.isEmpty || !_safeExprRe.hasMatch(expr)) return null;

    try {
      final result = _eval(expr);
      if (result == null || !result.isFinite) return null;
      return _round2(result);
    } catch (_) {
      return null;
    }
  }

  static bool shouldShowFormula(String formula, Map<int, String> valuesByParamId) {
    return calculate(formula, valuesByParamId) != null;
  }

  static String? calculateDisplay(String formula, Map<int, String> valuesByParamId) {
    final v = calculate(formula, valuesByParamId);
    if (v == null) return null;
    return _format2(v);
  }

  /// Apply formulas into [values] (mutates map). Returns true if any value changed.
  static bool applyFormulas(
    Iterable<({int id, String valueType, String formula})> params,
    Map<int, String> values,
  ) {
    var changed = false;
    // Multi-pass so formula-on-formula chains resolve when deps are numeric.
    for (var pass = 0; pass < 8; pass++) {
      var passChanged = false;
      for (final p in params) {
        if (p.valueType.toLowerCase() != 'formula') continue;
        final result = calculateDisplay(p.formula, values);
        if (result == null) continue;
        if (values[p.id] != result) {
          values[p.id] = result;
          passChanged = true;
          changed = true;
        }
      }
      if (!passChanged) break;
    }
    return changed;
  }

  /// Group-sum check: section params with both sectionTitle + groupSumEquals.
  /// Returns first failing message or null if OK.
  static String? validateGroupSums(
    Iterable<
            ({
              int patientTestId,
              String? sectionTitle,
              double? groupSumEquals,
              int parameterId,
              String valueType,
            })> rows,
    Map<int, String> values,
  ) {
    final targets = <String, double>{};
    final idsByKey = <String, List<int>>{};
    for (final row in rows) {
      final section = row.sectionTitle?.trim();
      final target = row.groupSumEquals;
      if (section == null || section.isEmpty || target == null) continue;
      if (row.valueType.toLowerCase() == 'formula') continue;
      final key = '${row.patientTestId}|$section';
      targets.putIfAbsent(key, () => target);
      idsByKey.putIfAbsent(key, () => <int>[]).add(row.parameterId);
    }

    for (final entry in idsByKey.entries) {
      final ids = entry.value;
      if (ids.isEmpty) continue;
      var complete = true;
      var sum = 0.0;
      for (final id in ids) {
        final raw = values[id]?.trim() ?? '';
        if (!isNumericReading(raw)) {
          complete = false;
          break;
        }
        sum += double.parse(raw);
      }
      if (!complete) continue;
      final target = targets[entry.key]!;
      if ((sum - target).abs() > 0.01) {
        final section = entry.key.split('|').skip(1).join('|');
        return 'Group sum for "$section" is ${_format2(sum)} but must equal ${_format2(target)}';
      }
    }
    return null;
  }

  static double _round2(double v) => (v * 100).roundToDouble() / 100;

  static String _format2(double v) {
    final r = _round2(v);
    if (r == r.roundToDouble()) return r.toInt().toString();
    return r.toStringAsFixed(2);
  }

  /// Recursive-descent parser for + - * / ( ).
  static double? _eval(String expr) {
    final p = _Parser(expr);
    final v = p.parseExpression();
    if (!p.done) return null;
    return v;
  }
}

class _Parser {
  _Parser(this.src);
  final String src;
  int i = 0;

  bool get done => i >= src.length;

  double? parseExpression() {
    var left = parseTerm();
    if (left == null) return null;
    while (!done && (src[i] == '+' || src[i] == '-')) {
      final op = src[i++];
      final right = parseTerm();
      if (right == null) return null;
      left = op == '+' ? left! + right : left! - right;
    }
    return left;
  }

  double? parseTerm() {
    var left = parseFactor();
    if (left == null) return null;
    while (!done && (src[i] == '*' || src[i] == '/')) {
      final op = src[i++];
      final right = parseFactor();
      if (right == null) return null;
      if (op == '*') {
        left = left! * right;
      } else {
        if (right == 0) return null;
        left = left! / right;
      }
    }
    return left;
  }

  double? parseFactor() {
    if (done) return null;
    if (src[i] == '+') {
      i++;
      return parseFactor();
    }
    if (src[i] == '-') {
      i++;
      final v = parseFactor();
      return v == null ? null : -v;
    }
    if (src[i] == '(') {
      i++;
      final v = parseExpression();
      if (v == null || done || src[i] != ')') return null;
      i++;
      return v;
    }
    return parseNumber();
  }

  double? parseNumber() {
    final start = i;
    while (!done && (src[i].codeUnitAt(0) >= 48 && src[i].codeUnitAt(0) <= 57 || src[i] == '.')) {
      i++;
    }
    if (i == start) return null;
    return double.tryParse(src.substring(start, i));
  }
}
