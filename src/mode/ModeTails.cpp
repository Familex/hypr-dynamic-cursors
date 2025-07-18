#include "ModeTails.hpp"

EModeUpdate CModeTails::strategy() {
    return MOVE;
}

SModeResult CModeTails::update(Vector2D pos) {
    // Tails mode doesn't transform the cursor, it just enables tail rendering
    // Return a neutral result
    return SModeResult();
}

void CModeTails::reset() {
    // Nothing to reset for tails mode
}

void CModeTails::warp(Vector2D old, Vector2D pos) {
    // Nothing to do on warp for tails mode
} 