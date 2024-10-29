#pragma once

#include <array>
#include <bitset>

enum QueueFlags {
    Graphics,
    Compute,
    Transfer,
    Present,
};

namespace QueueFlagBit {
static constexpr unsigned int GraphicsBit = 1 << 0;
static constexpr unsigned int ComputeBit = 1 << 1;
static constexpr unsigned int TransferBit = 1 << 2;
static constexpr unsigned int PresentBit = 1 << 3;
}  // namespace QueueFlagBit

using QueueFlagBits = std::bitset<sizeof(QueueFlags)>;
using QueueFamilyIndices = std::array<int, sizeof(QueueFlags)>;
