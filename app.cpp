
// #include "work.hpp"

#include <cstdint>
#include <print>

#define EXPERIMENTAL_IMPORTS 1

#if EXPERIMENTAL_IMPORTS
import work;
import work2;
#endif

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
