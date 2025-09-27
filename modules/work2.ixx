export module work2;

#include <cstdint>

// Exported free function
export  auto add(int32_t a, int32_t b) -> int32_t
{
    return a + b;
}
