Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39004 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936032AbeFNArL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2018 20:47:11 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v13 13/24] selftests/vm: pkey register should match shadow pkey
Date: Wed, 13 Jun 2018 17:45:04 -0700
Message-ID: <1528937115-10132-14-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
Message-ID: <20180614004504.FCut1T-0omoRwBku7f9DQqbW08tpN8ncWPWvE1DPQLE@z>

expected_pkey_fault() is comparing the contents of pkey
register with 0. This may not be true all the time. There
could be bits set by default by the architecture
which can never be changed. Hence compare the value against
shadow pkey register, which is supposed to track the bits
accurately all throughout

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 9afe894..adcae4a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -916,10 +916,10 @@ void expected_pkey_fault(int pkey)
 		pkey_assert(last_si_pkey == pkey);
 
 	/*
-	 * The signal handler shold have cleared out PKEY register to let the
+	 * The signal handler should have cleared out pkey-register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__read_pkey_reg() != 0)
+	if (__read_pkey_reg() != shadow_pkey_reg)
 		pkey_assert(0);
 
 	__write_pkey_reg(shadow_pkey_reg);
-- 
1.7.1
