Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:49020 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbaLCWa2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 17:30:28 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 3 Dec 2014 22:30:27 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/9] mips/gup: Replace ACCESS_ONCE with READ_ONCE
Date: Wed,  3 Dec 2014 23:30:17 +0100
Message-ID: <1417645821-54731-6-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20141203223017.k_aVIeRRcpcAbbxcPa89gOOKacrhRbbl1_GFkD09SO4@z>

ACCESS_ONCE does not work reliably on non-scalar types. For
example gcc 4.6 and 4.7 might remove the volatile tag for such
accesses during the SRA (scalar replacement of aggregates) step
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)

Change the gup code to replace ACCESS_ONCE with READ_ONCE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/mips/mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 06ce17c..8aa50e3 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -30,7 +30,7 @@ retry:
 
 	return pte;
 #else
-	return ACCESS_ONCE(*ptep);
+	return READ_ONCE(*ptep);
 #endif
 }
 
-- 
1.9.3

