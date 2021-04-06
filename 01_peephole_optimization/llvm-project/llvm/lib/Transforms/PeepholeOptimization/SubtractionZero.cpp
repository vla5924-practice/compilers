#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {

struct SubtractionZero : public FunctionPass {
    static char ID;

    SubtractionZero() : FunctionPass(ID) {
    }

    bool runOnFunction(Function& function) override {
        errs() << ">>> PEEPHOLE OPTIMIZATION :: SUBTRACTION ZERO\n";
        errs() << ">>> Function: " << function.getName() << "\n";

        bool changed = false;
        for (auto it = inst_begin(function), end = inst_end(function); it != end;) {
            auto instruction = &*it;
            ++it;

            if (!isTrivialSub(instruction)) {
                continue;
            }

            if (!instruction->use_empty()) {
                replaceWithArgument(instruction);
            }

            instruction->eraseFromParent();
            changed = true;
        }

        return changed;
    }

  protected:
    bool isTrivialSub(const Instruction* instruction) const {
        return isBinarySub(instruction) && isRightZero(instruction);
    };

    bool isBinarySub(const Instruction* instruction) const {
        return instruction->getOpcode() == Instruction::Sub && instruction->getNumOperands() == 2;
    }

    bool isRightZero(const Instruction* instruction) const {
        return isZero(instruction->getOperand(1));
    }

    bool isZero(const Value* operand) const {
        auto const constant = dyn_cast<ConstantInt>(operand);
        return constant && constant->isZero();
    }

    void replaceWithArgument(Instruction* instruction) const {
        const auto& lhs = instruction->getOperand(0);
        instruction->replaceAllUsesWith(lhs);
    }
};

} // namespace

char SubtractionZero::ID = 0;
static RegisterPass<SubtractionZero> pass("PeepholeOptimization_SubtractionZero",
                                          "Peephole Optimization :: Subtraction Zero Pass", false, false);
static RegisterStandardPasses std_pass(PassManagerBuilder::EP_EarlyAsPossible,
                                       [](const PassManagerBuilder& builder, legacy::PassManagerBase& manager) {
                                           manager.add(new SubtractionZero());
                                       });
