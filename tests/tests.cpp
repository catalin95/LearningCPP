#include <gtest/gtest.h>
#include <gmock/gmock.h>

#include "work.hpp"

using namespace testing;

TEST(FirstTest, Testing)
{
    const int32_t num = 1;
    const auto expectedNum = func(num);

    EXPECT_EQ(expectedNum, num);
}


