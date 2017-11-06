From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v9 38/51] selftest/vm: fixed bugs in pkey_disable_clear()
Date: Mon,  6 Nov 2017 00:57:30 -0800
Message-ID: <1509958663-18737-39-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
List-Id: linux-arch.vger.kernel.org

instead of clearing the bits, pkey_disable_clear() was setting
the bits. Fixed it.

Also fixed a wrong assertion in that function. When bits are
cleared, the resulting bit value will be less than the original.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 5aba137..384cc9a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
-	pkey_rights |= flags;
+	pkey_rights &= ~flags;
 
 	ret = pkey_set(pkey, pkey_rights, 0);
 	/* pkey_reg and flags have the same format */
@@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
 			pkey, rdpkey_reg());
 	if (flags)
-		assert(rdpkey_reg() > orig_pkey_reg);
+		assert(rdpkey_reg() < orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
1.7.1
