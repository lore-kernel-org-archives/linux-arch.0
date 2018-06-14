Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35604 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936043AbeFNArR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 20:47:17 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 16/24] selftests/vm: clear the bits in shadow reg when a pkey is freed.
Date: Wed, 13 Jun 2018 17:45:07 -0700
Message-ID: <1528937115-10132-17-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180614004507.XpexEjxgl-Mo5X3zkjYjhJYt2hY_AQHEIw1I__4SiPk@z>

When a key is freed, the  key  is  no  more  effective.
Clear the bits corresponding to the pkey in the shadow
register. Otherwise  it  will carry some spurious bits
which can trigger false-positive asserts.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 88dfa40..ba184ca 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -577,7 +577,8 @@ int sys_pkey_free(unsigned long pkey)
 	int ret = syscall(SYS_pkey_free, pkey);
 
 	if (!ret)
-		shadow_pkey_reg &= clear_pkey_flags(pkey, PKEY_DISABLE_ACCESS);
+		shadow_pkey_reg &= clear_pkey_flags(pkey,
+				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
 	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
 	return ret;
 }
-- 
1.7.1
