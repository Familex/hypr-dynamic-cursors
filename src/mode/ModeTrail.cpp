#include "ModeTrail.hpp"

EModeUpdate CModeTrail::strategy() {
    return MOVE;
}

SModeResult CModeTrail::update(Vector2D pos) {
    // Trail mode doesn't transform the cursor, it just enables tail rendering
    // Return a neutral result
    return SModeResult();
}

void CModeTrail::reset() {
    // Nothing to reset for trail mode
}

void CModeTrail::warp(Vector2D old, Vector2D pos) {
    // Nothing to do on warp for trail mode
} 
