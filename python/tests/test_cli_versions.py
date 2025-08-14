# test_cli_programs.py
import pytest
import subprocess
import os 

## Right now hard coded, but should use environment variables
TOOL="Fermitools"
VERSION="2.4.1"

# Test method to confirm a cli prints a tool/group/version in it's original output. 
def run_and_prints_version(command, expected_output):
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            # Not worried about it throwing an exception 
            # check=True
        )
        assert expected_output.strip() in result.stdout.strip()

    except subprocess.CalledProcessError as e:
        pytest.fail(f"Command '{' '.join(command)}' FAILED with error:\nStderr: {e.stderr}")
    except AssertionError:
        pytest.fail(f"Command '{' '.join(command)}' FAILED: Output mismatch\nExpected: '{expected_output.strip()}'\nActual: '{result.stdout.strip()}'")

# Test method to confirm a cli DOESN'T print the tool/group/version in it's original output.
def run_and_no_version(command, expected_output):
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            # Not worried about it throwing an exception
            # check=True
        )
        assert expected_output.strip() not in result.stdout.strip()

    except subprocess.CalledProcessError as e:
        pytest.fail(f"Command '{' '.join(command)}' FAILED with error:\nStderr: {e.stderr}")
    except AssertionError:
        pytest.fail(f"Command '{' '.join(command)}' FAILED: Output mismatch\nExpected: '{expected_output.strip()}'\nActual: '{result.stdout.strip()}'")


# CLI's that should print out the tool/version
@pytest.mark.parametrize("command, expected_output", [
    (["gtalphabkg"], f"This is gtalphabkg {TOOL} {VERSION}"),
    (["gtbary"], f"This is gtbary {TOOL} {VERSION}"),
    (["gtbin"], f"This is gtbin {TOOL} {VERSION}"),
    (["gtbindef"], f"This is gtbindef {TOOL} {VERSION}"),
    (["gtbkg"], f"This is gtbkg {TOOL} {VERSION}"),
    (["gtburstfit"], f"This is gtburstfit {TOOL} {VERSION}"),
    (["gtdiffrsp"], f"This is gtdiffrsp {TOOL} {VERSION}"),
    (["gtdispcube"], f"This is gtdispcube {TOOL} {VERSION}"),
    (["gtdrm"], f"This is gtdrm {TOOL} {VERSION}"),
    (["gtebl"], f"This is gtebl {TOOL} {VERSION}"),
    (["gteffbkg"], f"This is gteffbkg {TOOL} {VERSION}"),
    (["gtephem"], f"This is gtephem {TOOL} {VERSION}"),
    (["gtexpcube2"], f"This is gtexpcube2 {TOOL} {VERSION}"),
    (["gtexpcubesun"], f"This is gtexpcubesun {TOOL} {VERSION}"),
    (["gtexphpsun"], f"This is gtexphpsun {TOOL} {VERSION}"),
    (["gtexpmap"], f"This is gtexpmap {TOOL} {VERSION}"),
    (["gtexposure"], f"This is gtexposure {TOOL} {VERSION}"),
    (["gtfindsrc"], f"This is gtfindsrc {TOOL} {VERSION}"),
    (["gthealcube"], f"This is gthealcube {TOOL} {VERSION}"),
    (["gtirfs"], f"This is gtirfs {TOOL} {VERSION}"),
    (["gtlike"], f"This is gtlike {TOOL} {VERSION}"),
    (["gtltcube"], f"This is gtltcube {TOOL} {VERSION}"),
    (["gtltcubesun"], f"This is gtltcubesun {TOOL} {VERSION}"),
    (["gtltsum"], f"This is gtltsum {TOOL} {VERSION}"),
    (["gtltsumsun"], f"This is gtltsumsun {TOOL} {VERSION}"),
    (["gtmktime"], f"This is gtmktime {TOOL} {VERSION}"),
    (["gtmodel"], f"This is gtmodel {TOOL} {VERSION}"),
    (["gtobssim"], f"This is gtobssim {TOOL} {VERSION}"),
    (["gtophase"], f"This is gtophase {TOOL} {VERSION}"),
    (["gtorbsim"], f"This is gtorbsim {TOOL} {VERSION}"),
    (["gtpphase"], f"This is gtpphase {TOOL} {VERSION}"),
    (["gtpsf"], f"This is gtpsf {TOOL} {VERSION}"),
    (["gtpulsardb"], f"This is gtpulsardb {TOOL} {VERSION}"),
    (["gtrspgen"], f"This is gtrspgen {TOOL} {VERSION}"),
    (["gtselect"], f"This is gtselect {TOOL} {VERSION}"),
    (["gtsrcid"], f"This is gtsrcid {TOOL} {VERSION}"),
    (["gtsrcmaps"], f"This is gtsrcmaps {TOOL} {VERSION}"),
    (["gtsrcprob"], f"This is gtsrcprob {TOOL} {VERSION}"),
    (["gtsuntemp"], f"This is gtsuntemp {TOOL} {VERSION}"),
    (["gttscube"], f"This is gttscube {TOOL} {VERSION}"),
    (["gttsmap"], f"This is gttsmap {TOOL} {VERSION}"),
    (["gtvcut"], f"This is gtvcut {TOOL} {VERSION}"),
    (["gtwtsmap"], f"This is gtwtsmap {TOOL} {VERSION}"),
])

def test_cli_version(command, expected_output):
    run_and_prints_version(command, expected_output)

# List of clis that shouldn't output the tool/version when started.
@pytest.mark.parametrize("command, expected_output", [
    (["gtbuildxmlmodel"], f"This is gtbuildxmlmodel {TOOL} {VERSION}"),
    # Starts a xgui (["gtburst"], f"This is gtburst {TOOL} {VERSION}"),
    (["gtburstInstTest"], f"This is gtburstInstTest {TOOL} {VERSION}"),
    (["gtconvertxmlmodel"], f"This is gtconvertxmlmodel {TOOL} {VERSION}"),
    (["gtdocountsmap"], f"This is gtdocountsmap {TOOL} {VERSION}"),
    (["gtdolike"], f"This is gtdolike {TOOL} {VERSION}"),
    (["gtdosed"], f"This is gtdosed {TOOL} {VERSION}"),
    (["gtdosimulation"], f"This is gtdosimulation {TOOL} {VERSION}"),
    (["gtdotsmap"], f"This is gtdotsmap {TOOL} {VERSION}"),
    (["gtdownloadGBMdata"], f"This is gtdownloadGBMdata {TOOL} {VERSION}"),
    (["gtdownloadLATdata"], f"This is gtdownloadLATdata {TOOL} {VERSION}"),
    (["gtdownloadLLEdata"], f"This is gtdownloadLLEdata {TOOL} {VERSION}"),
    (["gteditxmlmodel.py"], f"This is gteditxmlmodel.py {TOOL} {VERSION}"),
    (["gteditxmlmodelsim"], f"This is gteditxmlmodelsim {TOOL} {VERSION}"),
    (["gtinteractiveRaDec"], f"This is gtinteractiveRaDec {TOOL} {VERSION}"),
    (["gtllebin"], f"This is gtllebin {TOOL} {VERSION}"),
    (["gtllebindef"], f"This is gtllebindef {TOOL} {VERSION}"),
    (["gtllebkg"], f"This is gtllebkg {TOOL} {VERSION}"),
    (["gtllebkgGUI"], f"This is gtllebkgGUI {TOOL} {VERSION}"),
    (["gtllebkgbindef"], f"This is gtllebkgbindef {TOOL} {VERSION}"),
    (["gtllesrc"], f"This is gtllesrc {TOOL} {VERSION}"),
    (["gtllesrcbindef"], f"This is gtllesrcbindef {TOOL} {VERSION}"),
])

def test_cli_no_version(command, expected_output):
    run_and_no_version(command, expected_output)
