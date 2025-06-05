#!/usr/bin/env python3
"""
Report which source files include which CLHEP modules.

Example output
--------------
src/physics/Foo.cpp        : Random  Vector
include/astro/Bar.hpp      : Units   Utility

Author: you
"""

import pathlib
import re
import sys
from collections import defaultdict

# -------- configuration -------------------------------------------------
SUFFIXES = (".h", ".hpp", ".hh", ".c", ".cc", ".cpp", ".cxx")
INC_RE   = re.compile(r'#\s*include\s*[<"]\s*CLHEP/([^/]+)/')
# ------------------------------------------------------------------------

def scan(root: pathlib.Path) -> dict[str, set[str]]:
    """Return { file : {modules…} }."""
    mapping: dict[str, set[str]] = defaultdict(set)

    for path in root.rglob("*"):
        if not path.suffix.lower() in SUFFIXES:
            continue
        try:
            text = path.read_text(encoding="utf-8", errors="ignore")
        except Exception:
            continue  # unreadable, binary, etc.

        for match in INC_RE.finditer(text):
            module = match.group(1)
            mapping[str(path)].add(module)

    return mapping


if __name__ == "__main__":
    root = pathlib.Path(sys.argv[1]) if len(sys.argv) > 1 else pathlib.Path("./src")
    mapping = scan(root)

    # prettified, column-aligned output
    if not mapping:
        print("No CLHEP headers found.")

    w = max(len(p) for p in mapping) + 2
    for file, mods in sorted(mapping.items()):
        print(f"{file:<{w}}: {'  '.join(sorted(mods))}")

# $ python ../scripts/clhep_usage.py                                                                                                          587ms
# Likelihood/Likelihood/FitScanner.h                             : Matrix
# Likelihood/src/FitScanner.cxx                                  : Matrix
# Likelihood/src/FitUtils.cxx                                    : Matrix
# Likelihood/src/test/test.cxx                                   : Random
# SolarSystemTools/src/ExposureCubeSun.cxx                       : Vector
# astro/astro/EarthCoordinate.h                                  : Vector
# astro/astro/EarthOrbit.h                                       : Vector
# astro/astro/GPS.h                                              : Vector
# astro/astro/PointingTransform.h                                : Vector
# astro/astro/Quaternion.h                                       : Vector
# astro/astro/SkyDir.h                                           : Vector
# astro/src/EarthCoordinate.cxx                                  : Vector
# astro/src/test/test.cxx                                        : Vector
# celestialSources/EarthPhenom/src/EarthPhenomInner.cxx          : Random
# celestialSources/EarthPhenom/src/EarthPhenomLimb.cxx           : Random
# celestialSources/GRB/src/GRB/GRBmanager.cxx                    : Vector
# celestialSources/GRB/src/GRBmaker/GRBmaker.cxx                 : Random
# celestialSources/GRB/src/GRBmaker/GRBobsSpectrum.cxx           : Random
# celestialSources/GRB/src/GRBmaker/GRBobsUtilities.cxx          : Random
# celestialSources/GRB/src/GRBmaker/GRBpulse.cxx                 : Random
# celestialSources/GRB/src/GRBmaker/GRBurst.cxx                  : Random
# celestialSources/GRB/src/GRBmaker/GrbGlobalData.cxx            : Random
# celestialSources/GRB/src/GRBmaker/LatGrb.cxx                   : Random
# celestialSources/GRBobs/src/GRBobsmanager.cxx                  : Vector
# celestialSources/GRBtemplate/src/GRBtemplateManager.cxx        : Vector
# celestialSources/Pulsar/Pulsar/PulsarSpectrum.h                : Vector
# celestialSources/SpectObj/src/SpectObj.cxx                     : Random
# celestialSources/genericSources/src/FileSpectrum.cxx           : Random
# celestialSources/genericSources/src/FitsTransient.cxx          : Random
# celestialSources/genericSources/src/GaussianSource.cxx         : Random
# celestialSources/genericSources/src/GaussianSpectrum.cxx       : Random
# celestialSources/genericSources/src/Isotropic.cxx              : Random  Vector
# celestialSources/genericSources/src/IsotropicFileSpectrum.cxx  : Random  Vector
# celestialSources/genericSources/src/MapCube.cxx                : Random
# celestialSources/genericSources/src/MapSource.cxx              : Random
# celestialSources/genericSources/src/PeriodicSource.cxx         : Random
# celestialSources/genericSources/src/Pulsar.cxx                 : Random
# celestialSources/genericSources/src/RadialSource.cxx           : Random
# celestialSources/genericSources/src/SimpleTransient.cxx        : Random
# celestialSources/genericSources/src/SourcePopulation.cxx       : Random
# celestialSources/genericSources/src/SpectralTransient.cxx      : Random
# celestialSources/genericSources/src/TransientTemplate.cxx      : Random
# celestialSources/genericSources/src/Util.cxx                   : Random
# celestialSources/microQuasar/microQuasar/microQuasar.h         : Random
# celestialSources/microQuasar/src/microQuasar.cxx               : Random
# celestialSources/src/TRandom4.cxx                              : Random
# dataSubselector/src/gtalign/gtalign.cxx                        : Vector
# evtbin/src/BayesianBinner.cxx                                  : Random
# flux/flux/AGNSpectrum.h                                        : Random
# flux/flux/EventSource.h                                        : Vector
# flux/flux/Flux.h                                               : Vector
# flux/flux/IFlux.h                                              : Vector
# flux/flux/LaunchDirection.h                                    : Random  Vector
# flux/flux/MapSpectrum.h                                        : Random
# flux/src/Earth.cxx                                             : Random
# flux/src/FluxSource.cxx                                        : Random
# flux/src/Spectrum.cxx                                          : Random
# flux/src/SurfaceMuons.cxx                                      : Random
# flux/src/VdgGamma.cxx                                          : Random
# flux/src/rootplot/rootplot.cxx                                 : Geometry
# irfs/dc1Response/src/EdispDC1.cxx                              : Random
# irfs/dc1Response/src/PsfDC1.cxx                                : Geometry  Random
# irfs/dc1aResponse/src/Edisp.cxx                                : Random
# irfs/dc1aResponse/src/Psf.cxx                                  : Geometry  Random
# irfs/dc2Response/src/Edisp.cxx                                 : Random
# irfs/dc2Response/src/Psf.cxx                                   : Geometry  Random
# irfs/g25Response/src/EdispGlast25.cxx                          : Random
# irfs/g25Response/src/PsfGlast25.cxx                            : Geometry  Random
# irfs/handoff_response/src/gen/IrfAnalysis.cxx                  : Geometry
# irfs/irfInterface/src/IEdisp.cxx                               : Random
# irfs/irfInterface/src/IPsf.cxx                                 : Geometry  Random
# irfs/testResponse/src/Edisp.cxx                                : Random
# irfs/testResponse/src/Psf.cxx                                  : Geometry  Random
# observationSim/observationSim/Simulator.h                      : Geometry
# observationSim/src/EventContainer.cxx                          : Geometry  Random
# observationSim/src/obsSim/obsSim.cxx                           : Random
# optimizers/src/Mcmc.cxx                                        : Random
# rspgen/src/IResponse.cxx                                       : Vector
# rspgen/src/SpaceCraftCalculator.cxx                            : Vector
# rspgen/src/test/test_rspgen.cxx                                : Vector
# skymaps/skymaps/PsfFunction.h                                  : Vector
# skymaps/src/Background.cxx                                     : Vector
# skymaps/src/DiffuseFunction.cxx                                : Vector
# skymaps/src/HealpixDiffuseFunc.cxx                             : Vector
# skymaps/src/PhotonMap.cxx                                      : Vector
# skymaps/src/PythonUtilities.cxx                                : Vector
