From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 15/19] mm: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:25 -0700
Message-ID: <1508792849-3115-15-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751546AbdJWVHl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Oct 2017 17:07:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NL7HmX030830
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:41 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsjcg7ebj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 17:07:40 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 17:07:40 -0400
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the mm code and comments to use
{READ,WRITE}_ONCE() consistently.

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

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 mm/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a728bed16c20..cae514e7dcfc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3891,9 +3891,9 @@ static int handle_pte_fault(struct vm_fault *vmf)
 		/*
 		 * some architectures can have larger ptes than wordsize,
 		 * e.g.ppc44x-defconfig has CONFIG_PTE_64BIT=y and
-		 * CONFIG_32BIT=y, so READ_ONCE or ACCESS_ONCE cannot guarantee
-		 * atomic accesses.  The code below just needs a consistent
-		 * view for the ifs and we later double check anyway with the
+		 * CONFIG_32BIT=y, so READ_ONCE cannot guarantee atomic
+		 * accesses.  The code below just needs a consistent view
+		 * for the ifs and we later double check anyway with the
 		 * ptl lock held. So here a barrier will do.
 		 */
 		barrier();
-- 
2.5.2
