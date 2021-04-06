add_llvm_library(
    PeepholeOptimization_AdditionZero
    MODULE AdditionZero.cpp
    PLUGIN_TOOL opt
)

add_llvm_library(
    PeepholeOptimization_SubtractionZero
    MODULE SubtractionZero.cpp
    PLUGIN_TOOL opt
)
