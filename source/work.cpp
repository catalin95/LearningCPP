#include "work.hpp"

#include <map>
#include <print>

namespace functions
{
    auto findDuplicate(const std::span<const int32_t> buffer, int32_t num) -> void
    {
        if (num > 0)
        {
            std::map<int32_t, int32_t> map = {std::make_pair(buffer[0], 1)};

            for (int32_t index = 1; index < buffer.size(); ++index)
            {
                map[buffer[index]]++;
            }

            std::println("Starting to print duplicates: ");

            for (const auto [key, value] : map)
            {
                if (value > 1) std::println("Found duplicate number: {} with occurence: {}", key, value);
            }
        }
        else
        {
            std::println("Something!!!!");
        }
    }
}
