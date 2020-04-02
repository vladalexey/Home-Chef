import 'package:homechef/models/instructions/instruction_model.dart';

class InstructionList {
  final List<Instruction> instructions;

  InstructionList({
    this.instructions
  });

  factory InstructionList.fromJson(List<dynamic> instructionResult) {

    List<Instruction> instructions = [];

    List<Map> components = new List<Map>.from(instructionResult);

    // Iterate each component
    for (Map<String, dynamic> component in components) {

      // In each component, access the 'steps' key
      List<Map> stepsComponent = new List<Map>.from(component['steps']);

      // In each step, access 'step' for instruction 
      for (Map<String, dynamic> step in stepsComponent) {

        instructions.add(
          new Instruction(instruction: step['step'])
        );
      }
    }

    return InstructionList(instructions: instructions);
  }
}