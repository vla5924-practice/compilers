#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {

struct AdditionZero : public FunctionPass {
    static char ID;

    AdditionZero() : FunctionPass(ID) {
    }

    bool runOnFunction(Function& function) override {
        errs() << ">>> PEEPHOLE OPTIMIZATION :: ADDITION ZERO\n";
        errs() << ">>> Function: " << function.getName() << "\n";

        bool changed = false;
        for (auto it = inst_begin(function), end = inst_end(function); it != end;) {
            auto instruction = &*it;
            ++it;

            if (!isTrivialAdd(instruction)) {
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
    bool isTrivialAdd(Instruction const* instruction) const {
        return isBinaryAdd(instruction) && isTrivial(instruction);
    };

    bool isBinaryAdd(Instruction const* instruction) const {
        return instruction->getOpcode() == Instruction::Add && instruction->getNumOperands() == 2;
    }

    bool isTrivial(Instruction const* instruction) const {
        auto const& operands = instruction->operands();
        return std::any_of(operands.begin(), operands.end(), [this](auto const& operand) { return isZero(operand); });
    }

    bool isZero(Instruction const* instruction) const {
        auto const constant = dyn_cast<ConstantInt>(operand);
        return constant && constant->isZero();
    }

    void replaceWithArgument(Instruction* instruction) const {
        auto const& lhs = instruction->getOperand(0);
        auto const& rhs = instruction->getOperand(1);
        instruction->replaceAllUsesWith(isZero(lhs) ? rhs : lhs);
    }
};

} // namespace

char Practice::ID = 0;
static RegisterPass<AdditionZero>
    RegisterPassAdditionZero("PeepholeOptimization_AdditionZero",
                             "[01_peephole_optimization] Peephole Optimization :: Addition Zero Pass", false, false);
static RegisterStandardPasses X(PassManagerBuilder::EP_EarlyAsPossible,
                                [](const PassManagerBuilder& builder, legacy::PassManagerBase& manager) { manager.add(new AdditionZero();
                                })