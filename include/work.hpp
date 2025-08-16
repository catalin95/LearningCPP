#pragma once

#include <cstdint>
#include <span>

namespace functions
{
    auto findDuplicate(const std::span<const int32_t> buffer, int32_t num) -> void;
}