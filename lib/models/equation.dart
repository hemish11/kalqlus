class Equation {
  static String equation = '';
  static String diffEquation = '';
  static String intEquation = '';

  static String toLatex(String equation) {
    return equation.replaceAll(')/(', '}{').replaceAll('(', '\\frac{').replaceAll(')', '}');
  }
}
