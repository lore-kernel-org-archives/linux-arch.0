Return-Path: <owner-linux-mm@kvack.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH v18 09/24] selftests/vm/pkeys: Fix assertion in
 pkey_disable_set/clear()
Date: Thu, 30 Jan 2020 12:06:51 +0530
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
Message-ID: <90e6851e1c71696f03cfa2c71377f0542d8dbd8d.1580365432.git.sandipan@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: shuah@kernel.org, skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com, dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200130063651.Oh1VdAPpYXrbZB8ohciSzuzXrMun0I4wWd54ausW6hk@z>

From: Ram Pai <linuxram@us.ibm.com>

In some cases, a pkey's bits need not necessarily change
in a way that the value of the pkey register increases
when performing a pkey_disable_set() or decreases when
performing a pkey_disable_clear().

For example, on powerpc, if a pkey's current state is
PKEY_DISABLE_ACCESS and we perform a pkey_write_disable()
on it, the bits still remain the same. We will observe
something similar when the pkey's current state is 0 and
a pkey_access_enable() is performed on it.

Either case would cause some assertions to fail. This
fixes the problem.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 4b1ddb526228..7fd52d5c4bfd 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -400,7 +400,7 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n",
 		__func__, pkey, read_pkey_reg());
 	if (flags)
-		pkey_assert(read_pkey_reg() > orig_pkey_reg);
+		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
@@ -431,7 +431,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016llx\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() < orig_pkey_reg);
+		assert(read_pkey_reg() <= orig_pkey_reg);
 }

 void pkey_write_allow(int pkey)
-- 
2.17.1
