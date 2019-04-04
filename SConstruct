# -*- python -*-
# $Header$
# Authors: Navid Golpayegani <golpa@slac.stanford.edu>, Joanne Bogart <jrb@slac.stanford.edu>
# Version: ScienceTools-scons-01-00-00

import os,platform,SCons,glob,re,atexit,sys,traceback,commands,subprocess
#########################
#   Global Environment  #
#########################

print("\nThis build is running on: ", platform.node(), "\n")

print("Argument list (one per line):")
for arg in sys.argv:
    print("=> ",arg)
print("\n")

myVars = {'myPrefix' : 'STR'}
SConscript(os.path.join('..','SConsShared','SConstruct_common.scons'), exports='myVars')


