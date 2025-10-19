#include "work.hpp"

#include <gtest/gtest.h>

#include <array>

TEST(FirstTest, shouldSuccesfullyFillBuffer) {
    int num = 1;
    int num2 = 2;
    const auto result = func(num, num2);
    const auto expected_result = 3;

    EXPECT_EQ(result, expected_result);
}
