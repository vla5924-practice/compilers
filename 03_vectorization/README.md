# Лабораторная работа №3. Векторизация

**Задание.** Выполнить анализ заданного цикла в форме отчёта.


## Структура папки

* `cpp` содержит код анализируемого цикла и приложение для замера производительности
* `ir` содержит файлы промежуточных представлений LLVM
* `logs` содержит наборы команд для сборки и тестирования


## Настройка репозитория

* Обновите подмодуль `llvm-project` в корне репозитория и соберите LLVM, либо используйте готовую сборку.
* Выполните приведенные ниже команды, следуя инструкции, чтобы получить требуемый результат.

_Ниже приводится инструкция по выполнению работы от преподавателя._


---

## Порядок выполнения

> **Внимание!**
> Инструкция ниже предназначена для Windows платформ.
> Если вы используете систему Linux, то
> * llvm-extract следует вызвать со следущим параметром `-func=_ZN8testFunc3runEv`
>    * Это связано с различной схемой [декорирования имен (name mangling)](https://en.wikipedia.org/wiki/Name_mangling#:~:text=In%20compiler%20construction%2C%20name%20mangling,in%20many%20modern%20programming%20languages.) для Linux и Windows
> * Не имеет большого смысла использовать расширение `.exe` для компиляции

1. Определить конфигурацию тестовой платформы с помощью утилиты _CPU-Z_ (Windows) или `lscpu` (Linux). Занести в отчет в секцию "Конфигурация".
2. Создать секцию "Исследуемый цикл" и добавить туда исходный код цикла из вашего варианта.
3. Получить LLVM IR в различных конфигурациях:
```
# Без векторизации и раскрутки
clang -O3 -fno-vectorize -fno-unroll-loops -I./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" test.cpp -emit-llvm -c -o testN.bc
llvm-extract -func=?run@testFunc@@QEAAXXZ test5.bc -o run-fn.bc
llvm-dis run-fn.bc -o run-fn.ll

# Без векторизации, с раскруткой
clang -O3 -fno-vectorize -I./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" test.cpp -emit-llvm -c -o testN.bc
llvm-extract -func=?run@testFunc@@QEAAXXZ testN.bc -o run-fn.bc
llvm-dis run-fn.bc -o run-fn.ll

# С векторизацией, без раскрутки
clang -O3 -fno-unroll-loops -I./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" test.cpp -emit-llvm -c -o testN.bc
llvm-extract -func=?run@testFunc@@QEAAXXZ testN.bc -o run-fn.bc
llvm-dis run-fn.bc -o run-fn.ll

# С векторизацией и раскруткой
clang -O3 -I./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" test.cpp -emit-llvm -c -o testN.bc
llvm-extract -func=?run@testFunc@@QEAAXXZ testN.bc -o run-fn.bc
llvm-dis run-fn.bc -o run-fn.ll
```
4. Заполнить соответсвующие таблицы отчёта.
5. Сравнить полученные IR файлы, объяснить различия. Записать выводы в секцию "Анализ LLVM IR".
6. Провести измерения времени исполнения цикла в тех же самых конфигурациях:
```
# Без векторизации и раскрутки
clang -O3 -fno-vectorize -fno-unroll-loops -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" -o ./benchmark_app.exe
./benchmark_app/benchmark_app.exe

# Без векторизации, с раскруткой
clang -O3 -fno-vectorize -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" -o ./benchmark_app.exe
./benchmark_app/benchmark_app.exe

# С векторизацией, без раскрутки
clang -O3 -fno-unroll-loops -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" -o ./benchmark_app.exe
./benchmark_app/benchmark_app.exe

# С векторизацией и раскруткой
clang -O3 -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\"testN.hpp\" -o ./benchmark_app.exe
./benchmark_app/benchmark_app.exe
```
7. Занести результаты в таблицу.
8. Записать выводы в секцию "Анализ времени исполнения".
