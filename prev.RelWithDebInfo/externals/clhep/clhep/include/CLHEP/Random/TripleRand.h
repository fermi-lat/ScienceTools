// $Id: TripleRand.h,v 1.5 2010/06/16 17:24:53 garren Exp $
// -*- C++ -*-
//
// -----------------------------------------------------------------------
//                           Hep Random
//                       --- TripleRand ---
//                        class header file
// -----------------------------------------------------------------------
// A canopy pseudo-random number generator. Using the Tausworthe 
// exclusive-or shift register, a simple Integer Coungruence generator, and
// the Hurd 288 total bit shift register, all XOR'd with each other, we
// provide an engine that should be a fairly good "mother" generator.
//
// This is similar to DualRand, with the addition of the Hurd288Engine.
// From DualRand, we have the following:
//   Exclusive or of a feedback shift register and integer congruence
//   random number generator.  The feedback shift register uses offsets
//   127 and 97.  The integer congruence generator uses a different
//   multiplier for each stream.  The multipliers are chosen to give
//   full period and maximum "potency" for modulo 2^32.  The period of
//   the combined random number generator is 2^159 - 2^32, and the
//   sequences are different for each stream (not just started in a
//   different place).
// The above is then amended to also add in the exclusive or of the 
// 288-total bit Hurd engine which in this case is a series of 32 
// interconnected 9-bit shift registers, with the newest bit of each register
// formed by the XOR of the previous bit and some bit b-d from a previous
// register where d is chosen to create a primitive polynomial to maximize
// the period.
// =======================================================================
// Ken Smith      - Initial draft started: 23rd Jul 1998
//                - Added conversion operators:  6th Aug 1998
// M Fischler	  - Big merge with CLHEP 13 May 1999
//		  - Elimination of unused Taus() and Cong() accessors
// Mark Fischler    Methods put, get for instance save/restore 12/8/04    
// Mark Fischler    methods for anonymous save/restore 12/27/04    
// =======================================================================

#ifndef TripleRand_h
#define TripleRand_h

#include "CLHEP/Random/defs.h"
#include "CLHEP/Random/RandomEngine.h"
#include "CLHEP/Random/Hurd288Engine.h"

namespace CLHEP {

/**
 * @author
 * @ingroup random
 */
class TripleRand: public HepRandomEngine {

public:

  TripleRand();
  TripleRand( long seed );
  TripleRand( std::istream & is );
  TripleRand( int rowIndex, int colIndex );
  virtual ~TripleRand();
  // Constructors and destructor

  double flat();
  // Returns a pseudo random number between 0 and 1 
  // (excluding the end points)

  void flatArray( const int size, double * vect );
  // Fills an array "vect" of specified size with flat random values.

  void setSeed( long seed, int );
  // Sets the state of the algorithm according to seed.

  void setSeeds( const long * seeds, int );
  // Sets the state of the algorithm according to the zero-terminated 
  // array of seeds.

  void saveStatus( const char filename[] = "TripleRand.conf" ) const;
  // Saves on named file the current engine status.

  void restoreStatus( const char filename[] = "TripleRand.conf" );
  // Reads from named file the last saved engine status and restores it.

  void showStatus() const;
  // Dumps the current engine status on the screen.

  operator double();       // Returns same as flat()
  operator float();        // flat value, without worrying about filling bits
  operator unsigned int(); // 32-bit flat value, quickest of all

  virtual std::ostream & put (std::ostream & os) const;
  virtual std::istream & get (std::istream & is);
  static  std::string beginTag ( );
  virtual std::istream & getState ( std::istream & is );

  std::string name() const;
  static std::string engineName() {return "TripleRand";}

  std::vector<unsigned long> put () const;
  bool get (const std::vector<unsigned long> & v);
  bool getState (const std::vector<unsigned long> & v);
  
  static const unsigned int VECTOR_STATE_SIZE = 20;
  
private:

/**
 * @author
 * @ingroup random
 */
class Tausworthe {
public:

  Tausworthe();
  Tausworthe(unsigned int seed);
  
  operator unsigned int();

  void put( std::ostream & os ) const;
  void put(std::vector<unsigned long> & v) const;
  void get( std::istream & is );
  bool get(std::vector<unsigned long>::const_iterator & iv);

private:
 
  int wordIndex;
  unsigned int words[4];
}; // Tausworthe

/**
 * @author
 * @ingroup random
 */
class IntegerCong {
public:

  IntegerCong();
  IntegerCong(unsigned int seed, int streamNumber);
  
  operator unsigned int();

  void put( std::ostream & os ) const;
  void put(std::vector<unsigned long> & v) const;
  void get( std::istream & is );
  bool get(std::vector<unsigned long>::const_iterator & iv);
 
private:
  
  unsigned int state, multiplier, addend;
}; // IntegerCong

  Hurd288Engine & Hurd();  // retrieve the constituent engine for input

  const Tausworthe    & ConstTaus() const;  // Same as above
  const IntegerCong   & ConstCong() const;  // necessary for 
  const Hurd288Engine & ConstHurd() const;  // output

  int numEngines;
  Tausworthe    tausworthe;  // Instances of each of the 
  IntegerCong   integerCong; // three engines that combine to make
  Hurd288Engine hurd;        // one TripleRand instance 

}; // TripleRand

}  // namespace CLHEP

#ifdef ENABLE_BACKWARDS_COMPATIBILITY
//  backwards compatibility will be enabled ONLY in CLHEP 1.9
using namespace CLHEP;
#endif

#endif // TripleRand_h
