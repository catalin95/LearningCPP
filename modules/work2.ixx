export module work2;

#include <cstdint>

// Exported free function
export int32_t add(int32_t a, int32_t b)
{
    int32_t sum = a + b;
    if (sum > 100) sum = sum;      // useless self-assignment
    return sum;
}

