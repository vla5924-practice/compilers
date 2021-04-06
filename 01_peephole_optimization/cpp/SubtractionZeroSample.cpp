#include <chrono>
#include <cstdint>
#include <iostream>

int main() {
    std::uint64_t sum_0 = 0;
    std::uint64_t sum_1 = 1;
    std::uint64_t sum_2 = 2;
    std::uint64_t sum_3 = 3;
    std::uint64_t sum_4 = 4;
    std::uint64_t sum_5 = 5;
    std::uint64_t sum_6 = 6;
    std::uint64_t sum_7 = 7;
    std::uint64_t sum_8 = 8;
    std::uint64_t sum_9 = 9;
    auto time = std::chrono::duration<double>();
    for (std::uint64_t i = 0; i < 150'000'000; i++) {
        const auto start = std::chrono::high_resolution_clock::now();
        sum_0 -= 0;
        sum_1 -= 0;
        sum_2 -= 0;
        sum_3 -= 0;
        sum_4 -= 0;
        sum_5 -= 0;
        sum_6 -= 0;
        sum_7 -= 0;
        sum_8 -= 0;
        sum_9 -= 0;
        const auto finish = std::chrono::high_resolution_clock::now();
        time += std::chrono::duration_cast<std::chrono::duration<double>>(finish - start);
    }
    std::cout << sum_0 << ' ' << sum_1 << ' ' << sum_2 << ' ' << sum_3 << ' ' << sum_4 << ' ' << sum_5 << ' ' << sum_6
              << ' ' << sum_7 << ' ' << sum_8 << ' ' << sum_9 << std::endl;
    std::cout << time.count() << std::endl;
    return 0;
}
