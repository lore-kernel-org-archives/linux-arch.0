Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
Date: Mon, 20 Jan 2020 14:05:28 +0530
Message-ID: <cover.1579507768.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200120083528.rl3itu31CetKNAcUYF-EuYApWlzNpHcCu9fAEz5kRc8@z>

Memory protection keys enables an application to protect its address
space from inadvertent access by its own code.

This feature is now enabled on powerpc and has been available since
4.16-rc1. The patches move the selftests to arch neutral directory
and enhance their test coverage.

Tested on powerpc64 and x86_64 (Skylake-SP).

Link to development branch:
https://github.com/sandip4n/linux/tree/pkey-selftests

Changelog
---------
Link to previous version (v16):
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=153824

v17:
	(1) Fixed issues with i386 builds when running on x86_64
	    based on feedback from Dave.
	(2) Replaced patch 6 from previous version with patch 7.
	    This addresses u64 format specifier related concerns
	    that Michael had raised in v15.

v16:
	(1) Rebased on top of latest master.
	(2) Switched to u64 instead of using an arch-dependent
	    pkey_reg_t type for references to the pkey register
	    based on suggestions from Dave, Michal and Michael.
	(3) Removed build time determination of page size based
	    on suggestion from Michael.
	(4) Fixed comment before the definition of __page_o_noops()
	    from patch 13 ("selftests/vm/pkeys: Introduce powerpc
	    support").

v15:
	(1) Rebased on top of latest master.
	(2) Addressed review comments from Dave Hansen.
	(3) Moved code for getting or setting pkey bits to new
	    helpers. These changes replace patch 7 of v14.
	(4) Added a fix which ensures that the correct count of
	    reserved keys is used across different platforms.
	(5) Added a fix which ensures that the correct page size
	    is used as powerpc supports both 4K and 64K pages.

v14:
	(1) Incorporated another round of comments from Dave Hansen.

v13:
	(1) Incorporated comments for Dave Hansen.
	(2) Added one more test for correct pkey-0 behavior.

v12:
	(1) Fixed the offset of pkey field in the siginfo structure for
	    x86_64 and powerpc. And tries to use the actual field
	    if the headers have it defined.

v11:
	(1) Fixed a deadlock in the ptrace testcase.

v10 and prior:
	(1) Moved the testcase to arch neutral directory.
	(2) Split the changes into incremental patches.

Desnes A. Nunes do Rosario (1):
  selftests/vm/pkeys: Fix number of reserved powerpc pkeys

Ram Pai (16):
  selftests/x86/pkeys: Move selftests to arch-neutral directory
  selftests/vm/pkeys: Rename all references to pkru to a generic name
  selftests/vm/pkeys: Move generic definitions to header file
  selftests/vm/pkeys: Fix pkey_disable_clear()
  selftests/vm/pkeys: Fix assertion in pkey_disable_set/clear()
  selftests/vm/pkeys: Fix alloc_random_pkey() to make it really random
  selftests/vm/pkeys: Introduce generic pkey abstractions
  selftests/vm/pkeys: Introduce powerpc support
  selftests/vm/pkeys: Fix assertion in test_pkey_alloc_exhaust()
  selftests/vm/pkeys: Improve checks to determine pkey support
  selftests/vm/pkeys: Associate key on a mapped page and detect access
    violation
  selftests/vm/pkeys: Associate key on a mapped page and detect write
    violation
  selftests/vm/pkeys: Detect write violation on a mapped
    access-denied-key page
  selftests/vm/pkeys: Introduce a sub-page allocator
  selftests/vm/pkeys: Test correct behaviour of pkey-0
  selftests/vm/pkeys: Override access right definitions on powerpc

Sandipan Das (5):
  selftests: vm: pkeys: Fix multilib builds for x86
  selftests: vm: pkeys: Use sane types for pkey register
  selftests: vm: pkeys: Add helpers for pkey bits
  selftests: vm: pkeys: Use the correct huge page size
  selftests: vm: pkeys: Use the correct page size on powerpc

Thiago Jung Bauermann (2):
  selftests/vm/pkeys: Move some definitions to arch-specific header
  selftests/vm/pkeys: Make gcc check arguments of sigsafe_printf()

 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |  50 ++
 tools/testing/selftests/vm/pkey-helpers.h     | 225 ++++++
 tools/testing/selftests/vm/pkey-powerpc.h     | 136 ++++
 tools/testing/selftests/vm/pkey-x86.h         | 181 +++++
 .../selftests/{x86 => vm}/protection_keys.c   | 696 ++++++++++--------
 tools/testing/selftests/x86/.gitignore        |   1 -
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/pkey-helpers.h    | 219 ------
 9 files changed, 979 insertions(+), 532 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h
 rename tools/testing/selftests/{x86 => vm}/protection_keys.c (74%)
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h

-- 
2.17.1
