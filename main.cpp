#include "work.hpp"

#include <cstdint>

// auto func(const int32_t num) -> int32_t
// {
//     if (num > 0)
//         return num;
//     else
//         return 0;
// }

auto main() -> int32_t
{
    const int32_t num = 1;
    [[maybe_unused]] const auto result = func(num);
}
