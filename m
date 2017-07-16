From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 51/62] selftest/vm: pkey register should match shadow pkey
Date: Sat, 15 Jul 2017 20:56:53 -0700
Message-ID: <1500177424-13695-52-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35648 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdGPEAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jul 2017 00:00:09 -0400
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org

expected_pkey_fault() is comparing the contents of pkey
register with 0. This may not be true all the time. There
could be bits set by default by the architecture
which can never be changed. Hence compare the value against
shadow pkey register, which is supposed to track the bits
accurately all throughout

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 20bab6d..f21e177 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -926,10 +926,10 @@ void expected_pkey_fault(int pkey)
 	pkey_assert(last_pkey_faults + 1 == pkey_faults);
 	pkey_assert(last_si_pkey == pkey);
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler shold have cleared out pkey-register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__rdpkey_reg() != 0)
+	if (__rdpkey_reg() != shadow_pkey_reg)
 		pkey_assert(0);
 
 	__wrpkey_reg(shadow_pkey_reg);
-- 
1.7.1
