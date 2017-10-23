From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 09/19] net: average: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:19 -0700
Message-ID: <1508792849-3115-9-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751587AbdJWVHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL69Kf083337
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsksdbdqn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Johannes Berg <johannes.berg@intel.com>

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't pick up some uses, including those
in <linux/average.h>. As a preparatory step, this patch converts the
file to use {READ,WRITE}_ONCE() consistently.

At the same time, this patch addds missing includes necessary for
{READ,WRITE}_ONCE(), *BUG_ON*(), and ilog2().

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: David S. Miller <davem@davemloft.net>
---
 include/linux/average.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/average.h b/include/linux/average.h
index 7ddaf340d2ac..3f462292269c 100644
--- a/include/linux/average.h
+++ b/include/linux/average.h
@@ -1,6 +1,10 @@
 #ifndef _LINUX_AVERAGE_H
 #define _LINUX_AVERAGE_H
 
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/log2.h>
+
 /*
  * Exponentially weighted moving average (EWMA)
  *
@@ -48,7 +52,7 @@
 	static inline void ewma_##name##_add(struct ewma_##name *e,	\
 					     unsigned long val)		\
 	{								\
-		unsigned long internal = ACCESS_ONCE(e->internal);	\
+		unsigned long internal = READ_ONCE(e->internal);	\
 		unsigned long weight_rcp = ilog2(_weight_rcp);		\
 		unsigned long precision = _precision;			\
 									\
@@ -57,10 +61,10 @@
 		BUILD_BUG_ON((_precision) > 30);			\
 		BUILD_BUG_ON_NOT_POWER_OF_2(_weight_rcp);		\
 									\
-		ACCESS_ONCE(e->internal) = internal ?			\
+		WRITE_ONCE(e->internal, internal ?			\
 			(((internal << weight_rcp) - internal) +	\
 				(val << precision)) >> weight_rcp :	\
-			(val << precision);				\
+			(val << precision));				\
 	}
 
 #endif /* _LINUX_AVERAGE_H */
-- 
2.5.2
