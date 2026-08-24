// $Id: RandPoissonT.h,v 1.5 2010/06/16 17:24:53 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                         --- RandPoissonT ---
//                          class header file
// -----------------------------------------------------------------------

// Class defining methods for shooting numbers according to the Poisson
// distribution, given a mean.  RandPoissonT is derived from RandPoisson
// and shares the identical user interface.  RandPoissonT is always 
// perfectly accurate for any value of mu.

// For mu > 100 the algorithm used is taken from the base class RandPoisson
// (Algorithm from "W.H.Press et al., Numerical Recipes in C, Second Edition".)
//
// For mu < 100, algorithm used is a table lookup based on [mu/K] for some 
// smallish K, followed by an explicit series-drived poisson for the small 
// remaining part of mu.  This method is exact, and is substantially faster 
// than the method used by the base class.  The implementation of this method 
// is in the RandPoissonQ class.

// =======================================================================
// M. Fischler    - Created 26 Jan 2000
// M. Fischler    - put and get to/from streams 12/10/04
// =======================================================================

#ifndef RandPoissonT_h
#define RandPoissonT_h 1

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/RandPoisson.h"

namespace CLHEP {

/**
 * @author
 * @ingroup random
 */
class RandPoissonT : public RandPoisson {

public:

  RandPoissonT ( HepRandomEngine& anEngine, double mean=1.0 );
  RandPoissonT ( HepRandomEngine* anEngine, double mean=1.0 );
  // These constructors should be used to instantiate a RandPoissonT
  // distribution object defining a local engine for it.
  // The static generator will be skipped using the non-static methods
  // defined below.
  // If the engine is passed by pointer the corresponding engine object
  // will be deleted by the RandPoissonT destructor.
  // If the engine is passed by reference the corresponding engine object
  // will not be deleted by the RandPoissonT destructor.

  virtual ~RandPoissonT();
  // Destructor

  // Save and restore to/from streams
  
  std::ostream & put ( std::ostream & os ) const;
  std::istream & get ( std::istream & is );

  // Static methods to shoot random values using the static generator

  static  long shoot( double mean=1.0 );

  static  void shootArray ( const int size, long* vect, double mean=1.0 );

  //  Static methods to shoot random values using a given engine
  //  by-passing the static generator.

  static  long shoot( HepRandomEngine* anEngine, double mean=1.0 );

  static  void shootArray ( HepRandomEngine* anEngine,
                            const int size, long* vect, double mean=1.0 );

  //  Methods using the localEngine to shoot random values, by-passing
  //  the static generator.

  long  fire();
  long  fire( double m );

  void fireArray ( const int size, long* vect );
  void fireArray ( const int size, long* vect, double mean);

  double operator()();
  double operator()( double mean );

  std::string name() const;
  HepRandomEngine & engine();

  static std::string distributionName() {return "RandPoissonT";}  
  // Provides the name of this distribution class


private:

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#include "CLHEP/Random/RandPoissonT.icc"

#endif
