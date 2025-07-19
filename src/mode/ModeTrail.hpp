#pragma once

#include "Mode.hpp"

class CModeTrail : public IMode {
  public:
    EModeUpdate strategy() override;
    SModeResult update(Vector2D pos) override;
    void reset() override;
    void warp(Vector2D old, Vector2D pos) override;
}; 
