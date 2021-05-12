; ModuleID = 'run-fn.bc'
source_filename = "test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.testFunc = type { %"class.std::vector", %"class.std::vector", %"class.std::vector" }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<float, std::allocator<float>>::_Vector_impl" }
%"struct.std::_Vector_base<float, std::allocator<float>>::_Vector_impl" = type { %"struct.std::_Vector_base<float, std::allocator<float>>::_Vector_impl_data" }
%"struct.std::_Vector_base<float, std::allocator<float>>::_Vector_impl_data" = type { float*, float*, float* }

$_ZN8testFunc3runEv = comdat any

; Function Attrs: noinline nounwind uwtable
define weak_odr dso_local void @_ZN8testFunc3runEv(%struct.testFunc* %this) local_unnamed_addr #0 comdat align 2 {
entry:
  %_M_start.i = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, i32 0, i32 0, i32 0, i32 0
  %0 = load float*, float** %_M_start.i, align 8, !tbaa !2
  %_M_start.i13 = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 1, i32 0, i32 0, i32 0, i32 0
  %1 = load float*, float** %_M_start.i13, align 8, !tbaa !2
  %_M_start.i11 = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 2, i32 0, i32 0, i32 0, i32 0
  %2 = load float*, float** %_M_start.i11, align 8, !tbaa !2
  %scevgep = getelementptr float, float* %2, i64 1048576
  %scevgep17 = getelementptr float, float* %0, i64 1048576
  %scevgep19 = getelementptr float, float* %1, i64 1048576
  %bound0 = icmp ult float* %2, %scevgep17
  %bound1 = icmp ult float* %0, %scevgep
  %found.conflict = and i1 %bound0, %bound1
  %bound021 = icmp ult float* %2, %scevgep19
  %bound122 = icmp ult float* %1, %scevgep
  %found.conflict23 = and i1 %bound021, %bound122
  %conflict.rdx = or i1 %found.conflict, %found.conflict23
  br i1 %conflict.rdx, label %for.body, label %vector.body

vector.body:                                      ; preds = %entry, %vector.body
  %index = phi i64 [ %index.next.1, %vector.body ], [ 0, %entry ]
  %3 = getelementptr inbounds float, float* %0, i64 %index
  %4 = bitcast float* %3 to <4 x float>*
  %wide.load = load <4 x float>, <4 x float>* %4, align 4, !tbaa !7, !alias.scope !9
  %5 = getelementptr inbounds float, float* %3, i64 4
  %6 = bitcast float* %5 to <4 x float>*
  %wide.load24 = load <4 x float>, <4 x float>* %6, align 4, !tbaa !7, !alias.scope !9
  %7 = getelementptr inbounds float, float* %1, i64 %index
  %8 = bitcast float* %7 to <4 x float>*
  %wide.load25 = load <4 x float>, <4 x float>* %8, align 4, !tbaa !7, !alias.scope !12
  %9 = getelementptr inbounds float, float* %7, i64 4
  %10 = bitcast float* %9 to <4 x float>*
  %wide.load26 = load <4 x float>, <4 x float>* %10, align 4, !tbaa !7, !alias.scope !12
  %11 = fadd <4 x float> %wide.load, %wide.load25
  %12 = fadd <4 x float> %wide.load24, %wide.load26
  %13 = getelementptr inbounds float, float* %2, i64 %index
  %14 = bitcast float* %13 to <4 x float>*
  store <4 x float> %11, <4 x float>* %14, align 4, !tbaa !7, !alias.scope !14, !noalias !16
  %15 = getelementptr inbounds float, float* %13, i64 4
  %16 = bitcast float* %15 to <4 x float>*
  store <4 x float> %12, <4 x float>* %16, align 4, !tbaa !7, !alias.scope !14, !noalias !16
  %index.next = or i64 %index, 8
  %17 = getelementptr inbounds float, float* %0, i64 %index.next
  %18 = bitcast float* %17 to <4 x float>*
  %wide.load.1 = load <4 x float>, <4 x float>* %18, align 4, !tbaa !7, !alias.scope !9
  %19 = getelementptr inbounds float, float* %17, i64 4
  %20 = bitcast float* %19 to <4 x float>*
  %wide.load24.1 = load <4 x float>, <4 x float>* %20, align 4, !tbaa !7, !alias.scope !9
  %21 = getelementptr inbounds float, float* %1, i64 %index.next
  %22 = bitcast float* %21 to <4 x float>*
  %wide.load25.1 = load <4 x float>, <4 x float>* %22, align 4, !tbaa !7, !alias.scope !12
  %23 = getelementptr inbounds float, float* %21, i64 4
  %24 = bitcast float* %23 to <4 x float>*
  %wide.load26.1 = load <4 x float>, <4 x float>* %24, align 4, !tbaa !7, !alias.scope !12
  %25 = fadd <4 x float> %wide.load.1, %wide.load25.1
  %26 = fadd <4 x float> %wide.load24.1, %wide.load26.1
  %27 = getelementptr inbounds float, float* %2, i64 %index.next
  %28 = bitcast float* %27 to <4 x float>*
  store <4 x float> %25, <4 x float>* %28, align 4, !tbaa !7, !alias.scope !14, !noalias !16
  %29 = getelementptr inbounds float, float* %27, i64 4
  %30 = bitcast float* %29 to <4 x float>*
  store <4 x float> %26, <4 x float>* %30, align 4, !tbaa !7, !alias.scope !14, !noalias !16
  %index.next.1 = add nuw nsw i64 %index, 16
  %31 = icmp eq i64 %index.next.1, 1048576
  br i1 %31, label %for.cond.cleanup, label %vector.body, !llvm.loop !17

for.cond.cleanup:                                 ; preds = %vector.body, %for.body
  ret void

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next.3, %for.body ], [ 0, %entry ]
  %add.ptr.i = getelementptr inbounds float, float* %0, i64 %indvars.iv
  %32 = load float, float* %add.ptr.i, align 4, !tbaa !7
  %add.ptr.i14 = getelementptr inbounds float, float* %1, i64 %indvars.iv
  %33 = load float, float* %add.ptr.i14, align 4, !tbaa !7
  %add = fadd float %32, %33
  %add.ptr.i12 = getelementptr inbounds float, float* %2, i64 %indvars.iv
  store float %add, float* %add.ptr.i12, align 4, !tbaa !7
  %indvars.iv.next = or i64 %indvars.iv, 1
  %add.ptr.i.1 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next
  %34 = load float, float* %add.ptr.i.1, align 4, !tbaa !7
  %add.ptr.i14.1 = getelementptr inbounds float, float* %1, i64 %indvars.iv.next
  %35 = load float, float* %add.ptr.i14.1, align 4, !tbaa !7
  %add.1 = fadd float %34, %35
  %add.ptr.i12.1 = getelementptr inbounds float, float* %2, i64 %indvars.iv.next
  store float %add.1, float* %add.ptr.i12.1, align 4, !tbaa !7
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %add.ptr.i.2 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.1
  %36 = load float, float* %add.ptr.i.2, align 4, !tbaa !7
  %add.ptr.i14.2 = getelementptr inbounds float, float* %1, i64 %indvars.iv.next.1
  %37 = load float, float* %add.ptr.i14.2, align 4, !tbaa !7
  %add.2 = fadd float %36, %37
  %add.ptr.i12.2 = getelementptr inbounds float, float* %2, i64 %indvars.iv.next.1
  store float %add.2, float* %add.ptr.i12.2, align 4, !tbaa !7
  %indvars.iv.next.2 = or i64 %indvars.iv, 3
  %add.ptr.i.3 = getelementptr inbounds float, float* %0, i64 %indvars.iv.next.2
  %38 = load float, float* %add.ptr.i.3, align 4, !tbaa !7
  %add.ptr.i14.3 = getelementptr inbounds float, float* %1, i64 %indvars.iv.next.2
  %39 = load float, float* %add.ptr.i14.3, align 4, !tbaa !7
  %add.3 = fadd float %38, %39
  %add.ptr.i12.3 = getelementptr inbounds float, float* %2, i64 %indvars.iv.next.2
  store float %add.3, float* %add.ptr.i12.3, align 4, !tbaa !7
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %exitcond.not.3 = icmp eq i64 %indvars.iv.next.3, 1048576
  br i1 %exitcond.not.3, label %for.cond.cleanup, label %for.body, !llvm.loop !19
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.1.0 (https://github.com/llvm/llvm-project 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)"}
!2 = !{!3, !4, i64 0}
!3 = !{!"_ZTSNSt12_Vector_baseIfSaIfEE17_Vector_impl_dataE", !4, i64 0, !4, i64 8, !4, i64 16}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{!8, !8, i64 0}
!8 = !{!"float", !5, i64 0}
!9 = !{!10}
!10 = distinct !{!10, !11}
!11 = distinct !{!11, !"LVerDomain"}
!12 = !{!13}
!13 = distinct !{!13, !11}
!14 = !{!15}
!15 = distinct !{!15, !11}
!16 = !{!10, !13}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.isvectorized", i32 1}
!19 = distinct !{!19, !18}
