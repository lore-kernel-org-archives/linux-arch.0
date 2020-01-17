Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 10/23] selftests/vm/pkeys: Fix alloc_random_pkey() to make
 it really random
Date: Fri, 17 Jan 2020 18:19:49 +0530
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Message-ID: <c99bd624151d9f93093c4f07011502bc64dedaa1.1579265066.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200117124949.QzXyAt-nVwyhcUmrZLvHArQf3mR4BHK3iy5TXkFdn_A@z>

From: Ram Pai <linuxram@us.ibm.com>

alloc_random_pkey() was allocating the same pkey every
time. Not all pkeys were geting tested. This fixes it.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index e666b5d2aeeb..8a69866e92fe 100644
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
@@ -545,10 +546,10 @@ int alloc_random_pkey(void)
 	int nr_alloced = 0;
 	int random_index;
 	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
+	srand((unsigned int)time(NULL));

 	/* allocate every possible key and make a note of which ones we got */
 	max_nr_pkey_allocs = NR_PKEYS;
-	max_nr_pkey_allocs = 1;
 	for (i = 0; i < max_nr_pkey_allocs; i++) {
 		int new_pkey = alloc_pkey();
 		if (new_pkey < 0)
-- 
2.17.1
