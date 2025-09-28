#include "work.hpp"

// #include <print>

namespace functions
{
    namespace
    {
        auto func() -> void
        {
            auto num = 1;
            // std::println("Printing num: {}", num);
        }
    }

    int32_t add(int32_t a, int32_t b)
    {
           int32_t num2 = 2;
        int32_t sum = a + b;
        if (sum > 100) sum = sum;      // useless self-assignment
        return sum;
    }

}
