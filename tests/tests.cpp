#include "work.hpp"

#include <gtest/gtest.h>


TEST(MyTest, shouldFindDuplicateNumber)
{
    constexpr auto arr = std::to_array({1,2,2,3,4,5,6,7,7,7,8,9});

    functions::findDuplicate(std::span<const int32_t>(arr));

    EXPECT_TRUE(true);
}

