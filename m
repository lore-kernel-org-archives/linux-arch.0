Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755564AbdJJAWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0LPcC143590
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd11ab3p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:53 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:52 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 01/15] doc: READ_ONCE() now implies smp_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:35 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20171010002235.fwzfrnJCuOMKkenvzjmbB6UQba_fOdsQGL3spjegQ1g@z>

This commit updates an example in memory-barriers.txt to account for
the fact that READ_ONCE() now implies smp_barrier_depends().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b759a60624fd..b592bb265e5c 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -227,17 +227,18 @@ There are some minimal guarantees that may be expected of a CPU:
  (*) On any given CPU, dependent memory accesses will be issued in order, with
      respect to itself.  This means that for:
 
-	Q = READ_ONCE(P); smp_read_barrier_depends(); D = READ_ONCE(*Q);
+	Q = READ_ONCE(P); D = READ_ONCE(*Q);
 
      the CPU will issue the following memory operations:
 
 	Q = LOAD P, D = LOAD *Q
 
      and always in that order.  On most systems, smp_read_barrier_depends()
-     does nothing, but it is required for DEC Alpha.  The READ_ONCE()
-     is required to prevent compiler mischief.  Please note that you
-     should normally use something like rcu_dereference() instead of
-     open-coding smp_read_barrier_depends().
+     does nothing, but it is required for DEC Alpha, and is supplied by
+     READ_ONCE().  The READ_ONCE() is also required to prevent compiler
+     mischief.  Please note that you should normally use something
+     like READ_ONCE() or rcu_dereference() instead of open-coding
+     smp_read_barrier_depends().
 
  (*) Overlapping loads and stores within a particular CPU will appear to be
      ordered within that CPU.  This means that for:
-- 
2.5.2
