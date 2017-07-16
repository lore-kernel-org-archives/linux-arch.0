Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35301 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdGPD6O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2017 23:58:14 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 05/62] powerpc: capture the PTE format changes in the dump pte report
Date: Sat, 15 Jul 2017 20:56:07 -0700
Message-ID: <1500177424-13695-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170716035607.FDSJdMSMDEDDBZw4ds1Sv-oA5VScb_7tPv3DN4HB1o8@z>

The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
capture these changes in the dump pte report.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/dump_linuxpagetables.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 44fe483..5627edd 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -213,7 +213,7 @@ struct flag_info {
 		.val	= H_PAGE_4K_PFN,
 		.set	= "4K_pfn",
 	}, {
-#endif
+#else /* CONFIG_PPC_64K_PAGES */
 		.mask	= H_PAGE_F_GIX,
 		.val	= H_PAGE_F_GIX,
 		.set	= "f_gix",
@@ -224,6 +224,7 @@ struct flag_info {
 		.val	= H_PAGE_F_SECOND,
 		.set	= "f_second",
 	}, {
+#endif /* CONFIG_PPC_64K_PAGES */
 #endif
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
-- 
1.7.1
