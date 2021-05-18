#include <iostream>
#include <sstream>

#include <llvm/Support/CommandLine.h>
#include <llvm/Support/Error.h>

#include <clang/ASTMatchers/ASTMatchFinder.h>
#include <clang/ASTMatchers/ASTMatchers.h>
#include <clang/Basic/Diagnostic.h>
#include <clang/Frontend/CompilerInstance.h>
#include <clang/Frontend/FrontendActions.h>
#include <clang/Rewrite/Core/Rewriter.h>
#include <clang/Tooling/CommonOptionsParser.h>
#include <clang/Tooling/Tooling.h>

using namespace clang;
using namespace clang::ast_matchers;
using namespace clang::tooling;

class CastCallBack : public MatchFinder::MatchCallback {
  public:
    CastCallBack(Rewriter& rewriter) : rewriter_(rewriter) {
    }

    virtual void run(const MatchFinder::MatchResult& result) {
        const CStyleCastExpr* node = result.Nodes.getNodeAs<CStyleCastExpr>("cast");
        SourceManager& manager = *result.SourceManager;
        CharSourceRange range =
            CharSourceRange::getCharRange(node->getLParenLoc(), node->getSubExprAsWritten()->getBeginLoc());
        StringRef type_name =
            Lexer::getSourceText(CharSourceRange::getTokenRange(node->getLParenLoc().getLocWithOffset(1),
                                                                node->getRParenLoc().getLocWithOffset(-1)),
                                 manager, result.Context->getLangOpts());
        std::string cast_type = ("static_cast<" + type_name + ">").str();
        const Expr* expr = node->getSubExprAsWritten()->IgnoreImpCasts();
        if (!isa<ParenExpr>(expr)) {
            cast_type.push_back('(');
            rewriter_.InsertText(
                Lexer::getLocForEndOfToken(expr->getEndLoc(), 0, manager, result.Context->getLangOpts()), ")");
        }
        rewriter_.ReplaceText(range, cast_type);
    }

  private:
    Rewriter& rewriter_;
};

class MyASTConsumer : public ASTConsumer {
  public:
    MyASTConsumer(Rewriter& rewriter) : callback_(rewriter) {
        matcher_.addMatcher(cStyleCastExpr(unless(isExpansionInSystemHeader())).bind("cast"), &callback_);
    }

    void HandleTranslationUnit(ASTContext& Context) override {
        matcher_.matchAST(Context);
    }

  private:
    CastCallBack callback_;
    MatchFinder matcher_;
};

class CStyleCheckerFrontendAction : public ASTFrontendAction {
  public:
    CStyleCheckerFrontendAction() = default;

    void EndSourceFileAction() override {
        rewriter_.getEditBuffer(rewriter_.getSourceMgr().getMainFileID()).write(llvm::outs());
    }

    std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance& CI, StringRef /* file */) override {
        rewriter_.setSourceMgr(CI.getSourceManager(), CI.getLangOpts());
        return std::make_unique<MyASTConsumer>(rewriter_);
    }

  private:
    Rewriter rewriter_;
};

static llvm::cl::OptionCategory CastMatcherCategory("cast-matcher options");

int main(int argc, const char** argv) {
    CommonOptionsParser Parser(argc, argv, CastMatcherCategory);

    ClangTool Tool(Parser.getCompilations(), Parser.getSourcePathList());
    return Tool.run(newFrontendActionFactory<CStyleCheckerFrontendAction>().get());
}
