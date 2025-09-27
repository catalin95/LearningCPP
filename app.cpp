
// #include "work.hpp"

#include <cstdint>
#include <print>

import work;

/**
 * @file main.cpp
 * @brief Main entry of the program.
 * \return 0
 */
auto main() -> int32_t
{
    std::println("{}", add(1, 2));

    const auto obj = Calculator{};

    std::println("{}", obj.mul(2, 2));
}
 