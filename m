Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:39942 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964900AbaLKOFm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2014 09:05:42 -0500
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Thu, 11 Dec 2014 14:05:40 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] x86/gup: Replace ACCESS_ONCE with READ_ONCE
Date: Thu, 11 Dec 2014 15:05:07 +0100
Message-ID: <1418306712-17245-5-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1418306712-17245-1-git-send-email-borntraeger@de.ibm.com>
References: <1418306712-17245-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, George Spelvin <linux@horizon.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20141211140507.Mck9hUhbucsO33C3EsPuUawfxHTKpn1fu-do_QBHZU8@z>

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Change the gup code to replace ACCESS_ONCE with READ_ONCE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/x86/mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/gup.c b/arch/x86/mm/gup.c
index 207d9aef..d754782 100644
--- a/arch/x86/mm/gup.c
+++ b/arch/x86/mm/gup.c
@@ -15,7 +15,7 @@
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #ifndef CONFIG_X86_PAE
-	return ACCESS_ONCE(*ptep);
+	return READ_ONCE(*ptep);
 #else
 	/*
 	 * With get_user_pages_fast, we walk down the pagetables without taking
-- 
1.9.3

