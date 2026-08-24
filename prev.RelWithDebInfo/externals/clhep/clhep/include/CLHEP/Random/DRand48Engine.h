// $Id: DRand48Engine.h,v 1.5 2010/06/16 17:24:53 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                             HEP Random
//                        --- DRand48Engine ---
//                          class header file
// -----------------------------------------------------------------------
// This file is part of Geant4 (simulation toolkit for HEP).
//
// Random engine using drand48() and srand48() functions from C standard
// library to implement the flat() basic distribution and for setting
// seeds.
// For Windows/NT platforms (WIN32), the code for drand48 has been
// extracted from the GNU C Library 2.0.1 and adapted for the native
// types.
// Copy constructor and operator= are private for objects of this class.
//
// WARNING: drand48 is not thread safe. If you need to use multiple
// engine objects on different threads concurrently, do not use DRand48Engine

// =======================================================================
// G.Cosmo        - Created: 5th September 1995
//                - Minor corrections: 31st October 1996
//                - Added methods for engine status: 19th November 1996
//                - Added srand48(), seed48(), drand48() implementations
//                  for Windows/NT: 6th March 1997
//                - setSeed(), setSeeds() now have default dummy argument
//                  set to zero: 11th July 1997
// E.Tcherniaev   - Porting on KCC compiler: 2nd Feb 1998
// G.Cosmo        - Private copy constructor and operator=: 26th Feb 1998
// J.Marraffino   - Added stream operators and related constructor.
//                  Added automatic seed selection from seed table and
//                  engine counter: 16th Feb 1998
// E.Tcherniaev   - Removed #ifdef for prototypes for drand48(), srand48()
//                  and seed48();
//                - More accurate code for drand48() on NT base on
//                  a code extracted from GNU C Library 2.1.3: 8th Nov 2000
// E.Tcherniaev   - prototypes for drand48(), srand48() and seed48() have
//                  been moved to DRand48Engine.cc: 21 Feb 2002
// Mark Fischler  - methods for distrib. instance save/restore 12/8/04    
// Mark Fischler  - methods for anonymous save/restore 12/27/04 
// Mark Fischler  - methods for vector save/restore 3/7/05    
// =======================================================================

#ifndef DRand48Engine_h
#define DRand48Engine_h 1

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/RandomEngine.h"
#include "CLHEP/Utility/noncopyable.h"

namespace CLHEP {

/**
 * @author <Gabriele.Cosmo@cern.ch>
 * @ingroup random
 */
class DRand48Engine : public HepRandomEngine, public noncopyable {

public:

  DRand48Engine(std::istream& is);
  DRand48Engine();
  DRand48Engine(long seed);
  DRand48Engine(int rowIndex, int colIndex);
  virtual ~DRand48Engine();
  // Constructors and destructor

  double flat();
  // It returns a pseudo random number between 0 and 1,
  // according to the standard stdlib random function drand48()
  // but excluding the end points.

  void flatArray (const int size, double* vect);
  // Fills the array "vect" of specified size with flat random values.

  void setSeed(long seed, int dum=0);
  // Sets the state of the algorithm according to seed.

  void setSeeds(const long * seeds, int dum=0);
  // Sets the state of the algorithm according to the zero terminated
  // array of seeds. Only the first seed is used.

  void saveStatus( const char filename[] = "DRand48.conf" ) const;
  // Saves on file DRand48.conf the current engine status.

  void restoreStatus( const char filename[] = "DRand48.conf" );
  // Reads from file DRand48.conf the last saved engine status
  // and restores it.

  void showStatus() const;
  // Dumps the engine status on the screen.

  virtual std::ostream & put (std::ostream & os) const;
  virtual std::istream & get (std::istream & is);
  static  std::string beginTag ( );
  virtual std::istream & getState ( std::istream & is );

  std::string name() const;
  static std::string engineName() {return "DRand48Engine";}

  std::vector<unsigned long> put () const;
  bool get (const std::vector<unsigned long> & v);
  bool getState (const std::vector<unsigned long> & v);

  static const unsigned int VECTOR_STATE_SIZE = 4;
  
private:

  static int  numEngines;
  static const int  maxIndex;

};

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#endif
