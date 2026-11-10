# typed: strict
# frozen_string_literal: true

# Homebrew formula for the Fermi LAT Science Tools.
class Fermitools < Formula
  desc "Fermi LAT Science Tools"
  homepage "https://github.com/fermi-lat/ScienceTools"
  url "https://github.com/fermi-lat/ScienceTools.git", tag: "Fermitools-2.5.60"
  version "2.5.60"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "llvm" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "swig" => :build

  depends_on "cfitsio"
  depends_on "cppunit"
  depends_on "fermi-lat/fermitools/fermitools-data"
  depends_on "fftw"
  depends_on "gsl"
  depends_on "libomp"
  depends_on "numpy"
  depends_on "python@3.12"
  depends_on "readline"
  depends_on "wcslib"
  depends_on "xerces-c"

  resource "f2c_src" do
    url "https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/libf2c.zip"
    sha256 "ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0"
  end

  resource "healpix_cxx_src" do
    url "https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/Healpix_3.31_2016Aug26.tar.gz"
    sha256 "ddf437442b6d5ae7d75c9afaafc4ec43921f903c976e25db3c5ed5185a181542"
  end

  def install
    resource("healpix_cxx_src").stage do
      system "patch", "-p0", "-i", buildpath/"externals/healpix_cxx/healpix_cxx.patch"
      healpix_source = Pathname.pwd

      resource("f2c_src").stage do
        system "patch", "-i", buildpath/"externals/f2c/f2c.patch"
        f2c_source = Pathname.pwd
        python = Formula["python@3.12"].opt_bin/"python3.12"
        args = std_cmake_args + %W[
          -DCMAKE_BUILD_TYPE=Release
          -DCMAKE_C_COMPILER=#{Formula["llvm"].opt_bin}/clang
          -DCMAKE_CXX_COMPILER=#{Formula["llvm"].opt_bin}/clang++
          -DPython3_EXECUTABLE=#{python}
          -DFERMI_PACKAGING=brew
          -DFERMI_INSTALL_PY_SCRIPTS=ON
          -DUSE_SYSTEM_CFITSIO=ON
          -DUSE_SYSTEM_CPPUNIT=ON
          -DUSE_SYSTEM_FFTW=ON
          -DUSE_SYSTEM_GSL=ON
          -DUSE_SYSTEM_WCSLIB=ON
          -DFETCHCONTENT_SOURCE_DIR_F2C_SRC=#{f2c_source}
          -DFETCHCONTENT_SOURCE_DIR_HEALPIX_CXX_SRC=#{healpix_source}
          -DFETCHCONTENT_FULLY_DISCONNECTED=ON
        ]
        cd buildpath do
          system "cmake", "-S", ".", "-B", "build", *args
          system "cmake", "--build", "build", "--parallel"
          system "cmake", "--install", "build"
        end
      end
    end
  end

  def caveats
    "Run: source #{opt_share}/fermitools/fermitools-init.sh"
  end

  test do
    python = Formula["python@3.12"].opt_bin/"python3.12"
    site_packages = lib/"python3.12/site-packages"
    caldb_dir = pkgshare/"data/caldb"
    ENV["CALDB"] = caldb_dir.to_s
    ENV["CALDBCONFIG"] = (caldb_dir/"software/tools/caldb.config").to_s
    ENV["CALDBALIAS"] = (caldb_dir/"software/tools/alias_config.fits").to_s
    ENV["CALDBROOT"] = caldb_dir.to_s
    # system python, "-c", "import os, site; os.environ['CALDB'] = '#{caldb_dir}'; site.addsitedir('#{site_packages}'); import pyLikelihood, UnbinnedAnalysis"
    # assert_predicate bin/"gtburst", :executable?
  end
end
