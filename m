From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 54/62] selftest/vm: fix an assertion in test_pkey_alloc_exhaust()
Date: Sat, 15 Jul 2017 20:56:56 -0700
Message-ID: <1500177424-13695-55-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

The maximum number of keys that can be allocated has to
take into consideration that some keys are reserved by
the architecture of specific purpose and cannot be allocated.

Fix the assertion in test_pkey_alloc_exhaust()

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 1a28c88..37645a5 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1159,12 +1159,12 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  One is taken
-	 * up for the default (0) and another can be taken up by
-	 * an execute-only mapping.  Ensure that we can allocate
-	 * at least 14 (16-2).
+	 * There are NR_PKEYS pkeys supported in hardware.  NR_RESERVED_KEYS
+	 * are reserved. One can be taken up by an execute-only mapping.
+	 * Ensure that we can allocate at least the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-2);
+	pkey_assert(i >= (NR_PKEYS-NR_RESERVED_PKEYS-1));
+
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
1.7.1

