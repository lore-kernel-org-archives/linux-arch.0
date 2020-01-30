Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 08/24] selftests/vm/pkeys: Fix pkey_disable_clear()
Date: Thu, 30 Jan 2020 12:06:50 +0530
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Message-ID: <38d20da74d5b2d166e60ab87160954da654029c8.1580365432.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200130063650.dtfLH1iiALV1RIYBdVMhkhLZstrdvQ6WF8BqHXxOfWg@z>

From: Ram Pai <linuxram@us.ibm.com>

Currently, pkey_disable_clear() sets the specified bits
instead clearing them. This has been dead code up to now
because its only callers i.e. pkey_access/write_allow()
are also unused.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index bed9d4de12b4..4b1ddb526228 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -418,7 +418,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);

-	pkey_rights |= flags;
+	pkey_rights &= ~flags;

 	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
@@ -431,7 +431,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() > orig_pkey_reg);
+		assert(read_pkey_reg() < orig_pkey_reg);
 }

 void pkey_write_allow(int pkey)
-- 
2.17.1
