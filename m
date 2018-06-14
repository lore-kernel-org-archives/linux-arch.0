Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40862 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935869AbeFNAqo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 20:46:44 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 00/24] selftests, powerpc, x86 : Memory Protection Keys
Date: Wed, 13 Jun 2018 17:44:51 -0700
Message-ID: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180614004451.S1f9GCiGebapkXdZDJ8BR0nXOBEQULFs1kCNRenTpnA@z>

Memory protection keys enables an application to protect its address space from
inadvertent access by its own code.

This feature is now enabled on powerpc architecture and integrated in
4.16-rc1.  The patches move the selftests to arch neutral directory
and enhance their test coverage.

Test
----
Verified for correctness on powerpc. Need help verifying on x86.
Compiles on x86.

History:
-------

version 13:
	(1) Incorporated comments for Dave Hansen.
	(2)   Added one more test for correct pkey-0 behavior.

version 12:
        (1) fixed the offset of pkey field in the siginfo structure for
	    x86_64 and powerpc. And tries to use the actual field
	    if the headers have it defined.

version 11:
	(1) fixed a deadlock in the ptrace testcase.

version 10 and prior:
	(1) moved the testcase to arch neutral directory
	(2) split the changes into incremental patches.


Ram Pai (22):
  selftests/x86: Move protecton key selftest to arch neutral directory
  selftests/vm: rename all references to pkru to a generic name
  selftests/vm: move generic definitions to header file
  selftests/vm: typecast the pkey register
  selftests/vm: generic function to handle shadow key register
  selftests/vm: fix the wrong assert in pkey_disable_set()
  selftests/vm: fixed bugs in pkey_disable_clear()
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: fix alloc_random_pkey() to make it really random
  selftests/vm: introduce two arch independent abstraction
  selftests/vm: pkey register should match shadow pkey
  selftests/vm: generic cleanup
  selftests/vm: powerpc implementation for generic abstraction
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: powerpc implementation to check support for pkey
  selftests/vm: fix an assertion in test_pkey_alloc_exhaust()
  selftests/vm: associate key on a mapped page and detect access
    violation
  selftests/vm: associate key on a mapped page and detect write
    violation
  selftests/vm: detect write violation on a mapped access-denied-key
    page
  selftests/vm: testcases must restore pkey-permissions
  selftests/vm: sub-page allocator
  selftests/vm: test correct behavior of pkey-0

Thiago Jung Bauermann (2):
  selftests/vm: move arch-specific definitions to arch-specific header
  selftests/vm: Make gcc check arguments of sigsafe_printf()

 tools/testing/selftests/vm/.gitignore         |    1 +
 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/pkey-helpers.h     |  214 ++++
 tools/testing/selftests/vm/pkey-powerpc.h     |  126 ++
 tools/testing/selftests/vm/pkey-x86.h         |  184 +++
 tools/testing/selftests/vm/protection_keys.c  | 1598 +++++++++++++++++++++++++
 tools/testing/selftests/x86/.gitignore        |    1 -
 tools/testing/selftests/x86/pkey-helpers.h    |  219 ----
 tools/testing/selftests/x86/protection_keys.c | 1485 -----------------------
 9 files changed, 2124 insertions(+), 1705 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h
 create mode 100644 tools/testing/selftests/vm/protection_keys.c
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
 delete mode 100644 tools/testing/selftests/x86/protection_keys.c
