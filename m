Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:49033 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbaLCWaa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 17:30:30 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 3 Dec 2014 22:30:29 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 9/9] kernel: tighten rules for ACCESS ONCE
Date: Wed,  3 Dec 2014 23:30:21 +0100
Message-ID: <1417645821-54731-10-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20141203223021.XRxNTp0xiw1mR3pA76kw39mcjHn8SMc8dy8aUKWJ3Xg@z>

Now that all non-scalar users of ACCESS_ONCE have been converted
to READ_ONCE or ASSIGN once, lets tighten ACCESS_ONCE to only
work on scalar types.
This variant was proposed by Alexei Starovoitov.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/compiler.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 947710e..5ba91de 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -441,8 +441,16 @@ static __always_inline void __assign_once_size(volatile void *p, void *res, int
  * merging, or refetching absolutely anything at any time.  Its main intended
  * use is to mediate communication between process-level code and irq/NMI
  * handlers, all running on the same CPU.
+ *
+ * ACCESS_ONCE will only work on scalar types. For union types, ACCESS_ONCE
+ * on a union member will work as long as the size of the member matches the
+ * size of the union and the size is smaller than word size.
+ * If possible READ_ONCE/ASSIGN_ONCE should be used instead.
  */
-#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+#define __ACCESS_ONCE(x) ({ \
+	 __maybe_unused typeof(x) __var = 0; \
+	(volatile typeof(x) *)&(x); })
+#define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
 
 /* Ignore/forbid kprobes attach on very low level functions marked by this attribute: */
 #ifdef CONFIG_KPROBES
-- 
1.9.3

