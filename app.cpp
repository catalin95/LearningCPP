
#include "work.hpp"

#include <array>
#include <cstdint>
#include <print>
#include <span>
#include <vector>

using std::println;

/**
 * @file main.cpp
 * @brief Main entry of the program.
 * \return 0
 */
auto main() -> int32_t {
    int num = 1;
    int num2 = 2;
    const auto result = func(num, num2);

    println("Printing result: {}", result);
}
