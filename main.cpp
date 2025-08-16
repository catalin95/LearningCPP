
// #include "work.hpp"

#include <array>
#include <optional>
#include <print>

#include <memory>

auto main() -> int32_t
{
    const auto ptr = std::make_unique<int32_t>(1);

    std::println("{}", *ptr);
}
