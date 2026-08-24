// $Id: RandEngine.h,v 1.6 2010/06/16 17:24:53 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                         --- RandEngine ---
//                          class header file
// -----------------------------------------------------------------------
// This file is part of Geant4 (simulation toolkit for HEP).
//
// Simple random engine using rand() and srand() functions from C standard
// library to implement the flat() basic distribution and for setting
// seeds.
// Copy constructor and operator= are private for objects of this class.
//
// WARNING: rand is not thread safe. If you need to use multiple
// engine objects on different threads concurrently, do not use RandEngine

// =======================================================================
// Gabriele Cosmo - Created: 5th September 1995
//                - Minor corrections: 31st October 1996
//                - Added methods for engine status: 19th November 1996
//                - setSeed(), setSeeds() now have default dummy argument
//                  set to zero: 11th July 1997
//                - Private copy constructor and operator=: 26th Feb 1998
// J.Marraffino   - Added stream operators and related constructor.
//                  Added automatic seed selection from seed table and
//                  engine counter: 15th Feb 1998
// Ken Smith      - Added conversion operators:  6th Aug 1998
//                  replace mx by mantissa_bit_32
// M Fischler     - Inserted warnings about the fact that the quality of rand()
//                  is quite poor.
// Mark Fischler    Methods for distrib. instance save/restore 12/8/04    
// Mark Fischler    methods for anonymous save/restore 12/27/04    
// =======================================================================

#ifndef RandEngine_h
#define RandEngine_h 1

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/RandomEngine.h"

namespace CLHEP {

/**
 * @author <Gabriele.Cosmo@cern.ch>
 * @ingroup random
 */
class RandEngine : public HepRandomEngine {

public:

  RandEngine(std::istream& is);
  RandEngine();
  RandEngine(long seed);
  RandEngine(int rowIndex, int colIndex);
  virtual ~RandEngine();
  // Constructors and destructor

  double flat();
  // It returns a pseudo random number between 0 and 1,
  // according to the standard stdlib random function rand()
  // but excluding the end points.
  //
  // WARNING:  rand() is quite a weak generator on most systems,                    <
  // will not pass several randomness tests, and does not give a           <
  // reproducible sequence of numbers.                                                                        <

  void flatArray (const int size, double* vect);
  // Fills the array "vect" of specified size with flat random values.

  void setSeed(long seed, int dum=0);
  // Sets the state of the algorithm according to seed.

  void setSeeds(const long * seeds, int dum=0);
  // Sets the state of the algorithm according to the zero terminated
  // array of seeds. Only the first seed is used.

  void saveStatus( const char filename[] = "Rand.conf" ) const;
  // Saves on file Rand.conf the current engine status.
  // WARNING:  This is non-functional, as rand() on various systems will            <
  // not give reproducible streams.                                                 <

  void restoreStatus( const char filename[] = "Rand.conf" );
  // Reads from file Rand.conf the last saved engine status
  // and restores it.
  // WARNING:  This is non-functional, as rand() on various systems will            <
  // not give reproducible streams.                                                 <

  void showStatus() const;
  // Dumps the engine status on the screen.
 
  operator double();       // Returns same as flat()
  operator float();        // flat value, without worrying about filling bits
  operator unsigned int(); // 32-bit flat value, quickest of all.

  virtual std::ostream & put (std::ostream & os) const;
  virtual std::istream & get (std::istream & is);
  static  std::string beginTag ( );
  virtual std::istream & getState ( std::istream & is );

  std::string name() const;
  static std::string engineName() {return "RandEngine";}

  std::vector<unsigned long> put () const;
  bool get (const std::vector<unsigned long> & v);
  bool getState (const std::vector<unsigned long> & v);
  
  static const unsigned int VECTOR_STATE_SIZE = 3;
  
private:

  RandEngine(const RandEngine &p);
  RandEngine & operator = (const RandEngine &p);
  // Private copy constructor and assignment operator.

private:

  long seq;
  static int numEngines;
  static const int maxIndex;

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#endif
