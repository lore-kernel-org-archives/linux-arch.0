Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38368 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbeGQOXX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Jul 2018 10:23:23 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v14 16/22] selftests/vm: fix an assertion in test_pkey_alloc_exhaust()
Date: Tue, 17 Jul 2018 06:49:19 -0700
Message-ID: <1531835365-32387-17-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180717134919.mH4GVBPMffKmf_nEjuSCF5AvfuDsW56UsLEO3SeGtLM@z>

The maximum number of keys that can be allocated has to
take into consideration, that some keys are reserved by
the architecture for   specific   purpose. Hence cannot
be allocated.

Fix the assertion in test_pkey_alloc_exhaust()

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index d27fa5e..67d841e 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1171,15 +1171,11 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  Three are
-	 * allocated by the time we get here:
-	 *   1. The default key (0)
-	 *   2. One possibly consumed by an execute-only mapping.
-	 *   3. One allocated by the test code and passed in via
-	 *      'pkey' to this function.
-	 * Ensure that we can allocate at least another 13 (16-3).
+	 * There are NR_PKEYS pkeys supported in hardware. arch_reserved_keys()
+	 * are reserved. And one key is allocated by the test code and passed
+	 * in via 'pkey' to this function.
 	 */
-	pkey_assert(i >= NR_PKEYS-3);
+	pkey_assert(i >= (NR_PKEYS-arch_reserved_keys()-1));
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
1.7.1
