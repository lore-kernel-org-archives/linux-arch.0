Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47074 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeAVSx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jan 2018 13:53:29 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 14/24] selftests/vm: clear the bits in shadow reg when a pkey is freed.
Date: Mon, 22 Jan 2018 10:52:07 -0800
Message-ID: <1516647137-11174-15-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
References: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com, arnd@arndb.de
Message-ID: <20180122185207.PgR1T8d2Kr25d7Z2x6ddpxm6E-J9fXjUT82aZ1tZiU0@z>

When a key is freed, the  key  is  no  more  effective.
Clear the bits corresponding to the pkey in the shadow
register. Otherwise  it  will carry some spurious bits
which can trigger false-positive asserts.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 55a25e1..d1cbdfe 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -586,7 +586,8 @@ int sys_pkey_free(unsigned long pkey)
 	int ret = syscall(SYS_pkey_free, pkey);
 
 	if (!ret)
-		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
+		shadow_pkey_reg &= reset_bits(pkey,
+				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
 	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
 	return ret;
 }
-- 
1.7.1
