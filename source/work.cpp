#include "work.hpp"

#include <print>

namespace functions
{
    namespace
    {
        auto func() -> void
        {
            auto num = 1;
            std::println("Printing num: {}", num);
        }
    }

    auto func() -> int32_t
    {
        auto num = 1;
        return num;
    }
}

