// -*- C++ -*-
// CLASSDOC OFF
// $Id: Sqr.h,v 1.1 2003/07/22 21:29:12 garren Exp $
// ---------------------------------------------------------------------------
// CLASSDOC ON
//
// This file is a part of the CLHEP - a Class Library for High Energy Physics.
//
// This file contains a template definition of sqr() 
// sqr() is used only by Vector/test/testLorentzVector.cc
//
#ifndef HEP_SQR_H
#define HEP_SQR_H
 
#ifndef CLHEP_SQR_DEFINED
#define CLHEP_SQR_DEFINED
#ifdef sqr
#undef sqr
#endif
template <class T>
inline T sqr(const T& x) {
  return x*x;
}
#endif
 
#endif /* HEP_SQR_H */
