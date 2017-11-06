Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:50985 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbdKFJAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2017 04:00:10 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v9 40/51] selftest/vm: fix alloc_random_pkey() to make it really random
Date: Mon,  6 Nov 2017 00:57:32 -0800
Message-ID: <1509958663-18737-41-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20171106085732.Ezi-rG9KvsdTuDlopYSjFa4bBChnkbTiqTBtyY1Nea4@z>

alloc_random_pkey() was allocating the same pkey every time.
Not all pkeys were geting tested. fixed it.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2823d4d..1a14027 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -24,6 +24,7 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <linux/futex.h>
+#include <time.h>
 #include <sys/time.h>
 #include <sys/syscall.h>
 #include <string.h>
@@ -602,13 +603,15 @@ int alloc_random_pkey(void)
 	int alloced_pkeys[NR_PKEYS];
 	int nr_alloced = 0;
 	int random_index;
+
 	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
+	srand((unsigned int)time(NULL));
 
 	/* allocate every possible key and make a note of which ones we got */
 	max_nr_pkey_allocs = NR_PKEYS;
-	max_nr_pkey_allocs = 1;
 	for (i = 0; i < max_nr_pkey_allocs; i++) {
 		int new_pkey = alloc_pkey();
+
 		if (new_pkey < 0)
 			break;
 		alloced_pkeys[nr_alloced++] = new_pkey;
@@ -624,13 +627,14 @@ int alloc_random_pkey(void)
 	/* go through the allocated ones that we did not want and free them */
 	for (i = 0; i < nr_alloced; i++) {
 		int free_ret;
+
 		if (!alloced_pkeys[i])
 			continue;
 		free_ret = sys_pkey_free(alloced_pkeys[i]);
 		pkey_assert(!free_ret);
 	}
-	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%016lx\n",
+		__func__, __LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
 	return ret;
 }
 
-- 
1.7.1
