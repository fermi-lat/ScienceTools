# typed: strict
# frozen_string_literal: true

# Homebrew formula for the Fermi LAT Science Tools.
class Fermitools < Formula
  include Language::Python::Virtualenv

  desc "Fermi LAT Science Tools"
  homepage "https://github.com/fermi-lat/ScienceTools"
  url "https://github.com/fermi-lat/ScienceTools.git",
      tag:      "Fermitools-2.5.61",
      revision: "4ea1f5c6f26f55d0f6871c779876ba49a317beaf"
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
  depends_on "libyaml"
  depends_on "openblas"
  depends_on "python@3.12"
  depends_on "readline"
  depends_on "wcslib"
  depends_on "xerces-c"

  uses_from_macos "curl"
  on_linux do
    depends_on "patchelf" => :build
  end
  # Python runtime dependencies (keep in sync with `run:` in recipe/meta.yaml)
  resource "numpy" do
    url "https://files.pythonhosted.org/packages/95/b0/c7453d0b6e2073c3264468b106ee1563750cecc910965e67357e3698c83e/numpy-2.5.4.tar.gz"
    sha256 "9a94cf751c9ad8ebaa835bcd3d40dacf8534ad086b88c38029b65123c7999d2a"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  # Bundled C/C++ sources used through FetchContent
  resource "f2c_src" do
    url "https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/libf2c.zip"
    sha256 "ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0"
  end

  resource "healpix_cxx_src" do
    url "https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/Healpix_3.31_2016Aug26.tar.gz"
    sha256 "ddf437442b6d5ae7d75c9afaafc4ec43921f903c976e25db3c5ed5185a181542"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    python = libexec/"bin/python"

    # Build NumPy against Homebrew's OpenBLAS (Accelerate is auto-detected but not linked)
    resource("numpy").stage do
      system python, "-m", "pip", "install",
             *std_pip_args(prefix: false, build_isolation: true),
             "-Csetup-args=-Dblas=openblas",
             "-Csetup-args=-Dlapack=openblas",
             "."
    end
    venv.pip_install resource("pyyaml")

    resource("healpix_cxx_src").stage do
      system "patch", "-p0", "-i", buildpath/"externals/healpix_cxx/healpix_cxx.patch"
      healpix_source = Pathname.pwd

      resource("f2c_src").stage do
        system "patch", "-i", buildpath/"externals/f2c/f2c.patch"
        f2c_source = Pathname.pwd
        args = std_cmake_args + %W[
          -DCMAKE_BUILD_TYPE=Release
          -DCMAKE_C_COMPILER=#{formula_opt_bin("llvm")}/clang
          -DCMAKE_CXX_COMPILER=#{formula_opt_bin("llvm")}/clang++
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
        if OS.mac?
          args += %W[
            -DOpenMP_ROOT=#{formula_opt_prefix("libomp")}
            -DOpenMP_CXX_LIB_NAMES=omp
            -DOpenMP_C_LIB_NAMES=omp
            -DOpenMP_omp_LIBRARY=#{formula_opt_lib("libomp")}/libomp.dylib
          ]
        end
        cd buildpath do
          system "cmake", "-S", ".", "-B", "build", *args
          system "cmake", "--build", "build", "--parallel"
          system "cmake", "--install", "build"
        end
      end
    end

    # Let the private virtualenv find the fermitools Python modules in this keg
    site_packages = Language::Python.site_packages("python3.12")
    (libexec/site_packages/"fermitools-brew.pth").write "#{lib}/python3.12/site-packages\n"
  end

  def caveats
    <<~EOS
      To set up the Fermi environment, run:
        source #{HOMEBREW_PREFIX}/share/fermitools/fermitools-init.sh

      Use the bundled Python (it includes numpy and pyyaml):
        #{opt_libexec}/bin/python
    EOS
  end

  test do
    python = libexec/"bin/python"
    fermi = opt_share/"fermitools"
    caldb = fermi/"data/caldb"
    ENV["FERMI_INST_DIR"] = fermi.to_s
    ENV["FERMI_DIR"] = fermi.to_s
    ENV["CALDB"] = caldb.to_s
    ENV["CALDBCONFIG"] = (caldb/"software/tools/caldb.config").to_s
    ENV["CALDBALIAS"] = (caldb/"software/tools/alias_config.fits").to_s
    system python, "-c", "import yaml, numpy, pyLikelihood, UnbinnedAnalysis, BinnedAnalysis"
    assert_predicate bin/"gtburst", :executable?
  end
end
