export module math;

#include <cstdint>

export auto add(const int32_t num1, const int32_t num2) -> int32_t
{
    return num1 + num2;
}

export class Calculator
{
public:
    auto mul(int32_t num1, int32_t num2) const -> int32_t
    {
        return num1 * num2;
    }
};