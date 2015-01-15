Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:60937 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbAOI6W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jan 2015 03:58:22 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 15 Jan 2015 08:58:19 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 7/8] next: sh: Fix compile error
Date: Thu, 15 Jan 2015 09:58:33 +0100
Message-ID: <1421312314-72330-8-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org, Guenter Roeck <linux@roeck-us.net>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20150115085833.nNld-GFJI6uTioeyQ3mcRq0yJQtnqEsT-2opkN56Aes@z>

From: Guenter Roeck <linux@roeck-us.net>

Commit a91ed664749c ("kernel: tighten rules for ACCESS ONCE") results in a
compile failure for sh builds with CONFIG_X2TLB enabled.

arch/sh/mm/gup.c: In function 'gup_get_pte':
arch/sh/mm/gup.c:20:2: error: invalid initializer
make[1]: *** [arch/sh/mm/gup.o] Error 1

Replace ACCESS_ONCE with READ_ONCE to fix the problem.

Fixes: a91ed664749c ("kernel: tighten rules for ACCESS ONCE")
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/sh/mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index 37458f3..e113bb4 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -17,7 +17,7 @@
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #ifndef CONFIG_X2TLB
-	return ACCESS_ONCE(*ptep);
+	return READ_ONCE(*ptep);
 #else
 	/*
 	 * With get_user_pages_fast, we walk down the pagetables without
-- 
1.9.3

