export module work;

#include <cstdint>

// // Exported free function
// export  auto add(int32_t a, int32_t b) -> int32_t
// {
//     return a + b;
// }

// Exported class
export class Calculator
{
public:
     auto mul(int32_t a, int32_t b) const -> int32_t
    {
        return a * b;
    }
};