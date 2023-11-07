import 'step.dart';

class StepMachine {
  int _currentIndex = 0;
  final List<Step> _steps = [
    Step(
      text:
          'Paciente com glicemia capilar > 250mg/dL. \n\nHá sinais/sintomas de cetoacidose diabética ou estado hiperosmolar?',
      choice1: 'Sim',
      choice2: 'Não',
    ),
    Step(
      text: 'Há suspeita de doença intercorrente (excluindo emergências)?',
      choice1: 'Sim',
      choice2: 'Não',
    ),
    Step(
      text: 'Cetonúria disponível (Se indisponível, considerar negativa)?',
      choice1: 'Positiva',
      choice2: 'Negativa',
    ),
    Step(
      text:
          'Aplicar insulina regular e reavaliar glicemia capilar em 2 horas.\n\nGlicemia abaixo de 250mg/dL?',
      choice1: 'Sim',
      choice2: 'Não',
    ),
    Step(
      text:
          'Provável descompensação crônica. Ajustar tratamento (considerar insulina). Solicitar controle de glicemia capilar. Orientar sinais de alarme e reavaliação breve',
      choice1: 'Reiniciar',
    ),
    Step(
      text:
          'Encaminhar para emergência imediatamente. Monitorar sinais vitais. Realizar hidratação EV com SF 0,9% enquanto aguarda o transporte',
      choice1: 'Reiniciar',
    ),
    Step(
      text:
          'Tratar complicações agudas. Aumentar transitoriamente dose total de insulina até resolução do quadro.',
      choice1: 'Reiniciar',
    ),
  ];

  Step get currentStep {
    return _steps[_currentIndex];
  }

  String get currentStepText {
    return currentStep.text;
  }

  String get choice1Text {
    return currentStep.choice1;
  }

  String? get choice2Text {
    return currentStep.choice2;
  }

  void makeChoice(int choiceIndex) {
    if (_currentIndex <= _steps.length) {
      switch (choiceIndex) {
        case 1:
          if (currentStep.choice1 != 'Reiniciar') {
            switch (_currentIndex) {
              case 0:
                _currentIndex += 5;
                break;
              case 2:
                _currentIndex += 3;
                break;
              case 3:
                _currentIndex += 3;
                break;
              default:
                _currentIndex++;
                break;
            }
          } else {
            reset();
          }
          break;
        case 2:
          if (currentStep.choice2 != null) {
            switch (_currentIndex) {
              case 1:
                _currentIndex += 3;
                break;
              case 3:
                _currentIndex += 2;
                break;
              default:
                _currentIndex++;
                break;
            }
          } else {
            reset();
          }
          break;
        default:
          reset();
          break;
      }
    }
  }

  void reset() {
    _currentIndex = 0;
  }
}
