Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 15/23] selftests/vm/pkeys: Fix assertion in
 test_pkey_alloc_exhaust()
Date: Fri, 17 Jan 2020 18:19:54 +0530
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Message-ID: <8f8e01c2885b6b463c4add91b21a82ac25b62603.1579265066.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200117124954.FdBHpBV9n6pLdI3GGDU28i5bgUkkECXOzMJhK6tdMrA@z>

From: Ram Pai <linuxram@us.ibm.com>

Some pkeys which are valid on the hardware are reserved
and not available for application use. These keys cannot
be allocated.

test_pkey_alloc_exhaust() tries to account for these and
has an assertion which validates if all available pkeys
have been exahaustively allocated. However, the expression
that is currently used is only valid for x86. On powerpc,
a pkey is additionally reserved as compared to x86. Hence,
the assertion is made to use an arch-specific helper to
get the correct count of reserved pkeys.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 90bb3a8cd78b..a91d11c6a0ec 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1152,6 +1152,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	dprintf3("%s()::%d\n", __func__, __LINE__);

 	/*
+	 * On x86:
 	 * There are 16 pkeys supported in hardware.  Three are
 	 * allocated by the time we get here:
 	 *   1. The default key (0)
@@ -1159,8 +1160,16 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	 *   3. One allocated by the test code and passed in via
 	 *      'pkey' to this function.
 	 * Ensure that we can allocate at least another 13 (16-3).
+	 *
+	 * On powerpc:
+	 * There are either 5, 28, 29 or 32 pkeys supported in
+	 * hardware depending on the page size (4K or 64K) and
+	 * platform (powernv or powervm). Four are allocated by
+	 * the time we get here. These include pkey-0, pkey-1,
+	 * exec-only pkey and the one allocated by the test code.
+	 * Ensure that we can allocate the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-3);
+	pkey_assert(i >= (NR_PKEYS - get_arch_reserved_keys() - 1));

 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
2.17.1
