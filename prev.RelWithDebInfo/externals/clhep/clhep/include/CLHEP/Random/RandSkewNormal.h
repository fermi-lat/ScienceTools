// $Id: RandSkewNormal.h,v 1.1 2011/05/27 20:36:28 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                          --- RandSkewNormal ---
//                          class header file
// -----------------------------------------------------------------------

// RandSkewNormal ---
//    returns a skew-normal distribution with shape parameter k
//    To get a distribution with scale parameter b and location m:
//    r = m + b * RandSkewNormal.fire(k);
// http://azzalini.stat.unipd.it/SN/
// algorithm from K. McFarlane, June 2010.

// =======================================================================
// M Fischler and L Garren - Created: 26 May 2011
// =======================================================================

#ifndef RandSkewNormal_h
#define RandSkewNormal_h 1

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/Random.h"
#include "CLHEP/Utility/memory.h"

namespace CLHEP {

/**
 * @author <mf@fnal.gov>
 * @ingroup random
 */
class RandSkewNormal : public HepRandom {

public:

  inline RandSkewNormal ( HepRandomEngine& anEngine, double shape=0. );
  inline RandSkewNormal ( HepRandomEngine* anEngine, double shape=0. );
  // These constructors should be used to instantiate a RandSkewNormal
  // distribution object defining a local engine for it.
  // The static generator will be skipped using the non-static methods
  // defined below.
  // If the engine is passed by pointer the corresponding engine object
  // will be deleted by the RandSkewNormal destructor.
  // If the engine is passed by reference the corresponding engine object
  // will not be deleted by the RandSkewNormal destructor.

  virtual ~RandSkewNormal();
  // Destructor

  // Static methods to shoot random values using the static generator

  static  double shoot();

  static  double shoot( double shape );

  static  void shootArray ( const int size, double* vect,
                            double shape=0. );

  //  Static methods to shoot random values using a given engine
  //  by-passing the static generator.

  static  double shoot( HepRandomEngine* anEngine );

  static  double shoot( HepRandomEngine* anEngine, double shape );

  static  void shootArray ( HepRandomEngine* anEngine, const int size,
                            double* vect, double shape=0. );

  //  Methods using the localEngine to shoot random values, by-passing
  //  the static generator.

  double fire();

  double fire( double shape );

  void fireArray ( const int size, double* vect );
  void fireArray ( const int size, double* vect, double shape );
  
  double operator()();
  double operator()( double shape );

  // Save and restore to/from streams
  
  std::ostream & put ( std::ostream & os ) const;
  std::istream & get ( std::istream & is );

  std::string name() const;
  HepRandomEngine & engine();

  static std::string distributionName() {return "RandSkewNormal";}  
  // Provides the name of this distribution class
  
protected:

  static double gaussianSkewNormal ( HepRandomEngine *e, double k);
  double getShapeParameter() { return shapeParameter; }

  inline HepRandomEngine* getLocalEngine();

private:

  shared_ptr<HepRandomEngine> localEngine;
  double shapeParameter;

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#include "CLHEP/Random/RandSkewNormal.icc"

#endif
