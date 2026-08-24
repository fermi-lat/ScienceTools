// $Id: RandGaussT.h,v 1.5 2010/06/16 17:24:53 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                          --- RandGaussT ---
//                          class header file
// -----------------------------------------------------------------------

// Class defining methods RandGaussT, which is derived from RandGauss.
// The user interface is identical.  
// RandGaussT ---
//   Always uses exactly one flat random from the engine
//   Is stateless so that saveEngineStatus works even if invoked knowing
//   only that the distribution is a HepRandom.  (RandGauss is not stateless.)
//   Is accurate to more than 12 decimal places in all cases, and more so 
//   near the end points.
//   Runs about as fast as RandGauss.
// RandGaussT utilizes HepStat::flatToGaussian(r), so its effective footprint
// (for the tables used) is almost 30K bytes.

// =======================================================================
// M. Fischler		Created 2/2/00
// M Fischler      - put and get to/from streams 12/10/04
//
// =======================================================================

#ifndef RandGaussT_h
#define RandGaussT_h 1

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/RandGauss.h"
#include "CLHEP/Random/Stat.h"

namespace CLHEP {

/**
 * @author
 * @ingroup random
 */
class RandGaussT : public RandGauss {

public:

  inline RandGaussT ( HepRandomEngine& anEngine, double mean=0.0,
                                                double stdDev=1.0 );
  inline RandGaussT ( HepRandomEngine* anEngine, double mean=0.0,
                                                double stdDev=1.0 );
  // These constructors should be used to instantiate a RandGaussT
  // distribution object defining a local engine for it.
  // The static generator will be skipped using the non-static methods
  // defined below.
  // If the engine is passed by pointer the corresponding engine object
  // will be deleted by the RandGaussT destructor.
  // If the engine is passed by reference the corresponding engine object
  // will not be deleted by the RandGaussT destructor.

  // Destructor
  virtual ~RandGaussT();

  //
  // Methods to generate Gaussian-distributed random deviates:
  //
  //   If a fast good engine takes 1 usec, RandGauss::fire() adds 1 usec;
  //   RandGaussT::fire() similarly adds 1 usec.
  //

  // Static methods to shoot random values using the static generator

  static  inline double shoot();

  static  inline double shoot( double mean, double stdDev );

  static  void shootArray ( const int size, double* vect,
                            double mean=0.0, double stdDev=1.0 );

  //  Static methods to shoot random values using a given engine
  //  by-passing the static generator.

  static  inline double shoot( HepRandomEngine* anotherEngine );

  static  inline double shoot( HepRandomEngine* anotherEngine, 
                                  double mean, double stdDev );


  static  void shootArray ( HepRandomEngine* anotherEngine, 
			    const int size,
                            double* vect, double mean=0.0,
                            double stdDev=1.0 );

  //  Instance methods using the localEngine to instead of the static 
  //  generator, and the default mean and stdDev established at construction

  inline double fire();

  inline double fire ( double mean, double stdDev );
  
  void fireArray  ( const int size, double* vect);
  void fireArray  ( const int size, double* vect,
                    double mean, double stdDev );

  virtual double operator()();
  virtual double operator()( double mean, double stdDev );

  // Save and restore to/from streams
  
  std::ostream & put ( std::ostream & os ) const;
  std::istream & get ( std::istream & is );

  std::string name() const;
  HepRandomEngine & engine();

  static std::string distributionName() {return "RandGaussT";}  
  // Provides the name of this distribution class
  
private:

  // All the engine info, and the default mean and sigma, are in the RandGauss
  // base class.

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#include "CLHEP/Random/RandGaussT.icc"

#endif
