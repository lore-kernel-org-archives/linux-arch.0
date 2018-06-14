Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42991 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936014AbeFNArD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 20:47:03 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 09/24] selftests/vm: fixed bugs in pkey_disable_clear()
Date: Wed, 13 Jun 2018 17:45:00 -0700
Message-ID: <1528937115-10132-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180614004500.AiLx89-pLuWLRQ_6v5nWZ1BzXrjlnwp7NNik2NGU-ns@z>

instead of clearing the bits, pkey_disable_clear() was setting
the bits. Fixed it.

Also fixed a wrong assertion in that function. When bits are
cleared, the resulting bit value will be less than the original.

This hasn't been a problem so far because this code isn't currently
used.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 5fcccdb..da4f5d5 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -433,7 +433,7 @@ void pkey_disable_clear(int pkey, int flags)
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
-	pkey_rights |= flags;
+	pkey_rights &= ~flags;
 
 	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	shadow_pkey_reg &= clear_pkey_flags(pkey, flags);
@@ -446,7 +446,7 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) pkey_reg: 0x"PKEY_REG_FMT"\n", __func__,
 			pkey, read_pkey_reg());
 	if (flags)
-		assert(read_pkey_reg() > orig_pkey_reg);
+		assert(read_pkey_reg() < orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
-- 
1.7.1
