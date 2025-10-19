module;

#include <cstdint>

export module error;

namespace errors {
export enum struct ERRORS : std::uint8_t { RESOURCE_NOT_AVAILABLE = 0 };
}
