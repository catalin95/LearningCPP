#include "work.hpp"

#include <gtest/gtest.h>

#include <iostream>

#ifdef __clangd__
#include "modules/math.ixx"
#define import  // prevent Clangd from parsing the import keyword
#endif


import math;


#if 0
TEST(MyTest, shouldFindDuplicateNumber)
{
    constexpr auto arr = std::to_array({1, 2, 2, 3, 4, 5, 6, 7, 7, 7, 8, 9});
    constexpr int32_t num = 1;

    functions::findDuplicate(std::span<const int32_t>(arr), num);

    EXPECT_TRUE(true);
}
#endif

#if 0
TEST(MyTest, SecontTest)
{
    constexpr auto arr = std::to_array({1, 2, 2, 3, 4, 5, 6, 7, 7, 7, 8, 9});
    constexpr int32_t num = 0;

    functions::findDuplicate(std::span<const int32_t>(arr), num);

    EXPECT_TRUE(true);
}
#endif

// import math;

TEST(FirstTest, Test1)
{
    const auto expectedResult = 4;

    const auto actualResult = add(2, 2);

    EXPECT_EQ(actualResult, expectedResult);
}