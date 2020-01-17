Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v16 08/23] selftests/vm: Fix pkey_disable_clear()
Date: Fri, 17 Jan 2020 18:19:47 +0530
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
Message-ID: <2c5a7d6888e87bbe11a533e0b5c34c99829f8e5f.1579265066.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200117124947.fvEY77CNXfPa-1LJv4RMDnq2z8UTDdupuwXu-aWsfvg@z>

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
index 3ce5a87804ab..7440f6fa7be3 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -417,7 +417,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);

-	pkey_rights |= flags;
+	pkey_rights &= ~flags;

 	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
@@ -430,7 +430,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() > orig_pkey_reg);
+		assert(read_pkey_reg() < orig_pkey_reg);
 }

 void pkey_write_allow(int pkey)
-- 
2.17.1
