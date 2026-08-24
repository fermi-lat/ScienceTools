// $Id
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                      --- StaticRandomStates ---
//                          class header file
// -----------------------------------------------------------------------
//
// It's a holder for methods to save and restore the full states of all
// static random distribution generators, including engine and cached data.
//
// =======================================================================
// Mark Fischler  - Created: Dec. 21, 2004
// =======================================================================

#ifndef StaticRandomStates_h
#define StaticRandomStates_h 1

#include "CLHEP/Random/defs.h"
#include <iostream>

namespace CLHEP {

/**
 * @author <mf@fnal.gov>
 */
class StaticRandomStates {

public:

static std::ostream & save   (std::ostream & os);
static std::istream & restore(std::istream & is);

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#endif
