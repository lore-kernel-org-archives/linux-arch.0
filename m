Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbfECOxb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 10:53:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43EpxuE043230
        for <linux-arch@vger.kernel.org>; Fri, 3 May 2019 10:53:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8pu32uak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 03 May 2019 10:53:30 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 3 May 2019 15:53:29 +0100
Date: Fri, 3 May 2019 07:53:26 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: f68f031d ("Documentation: atomic_t.txt: Explain ordering provided by
 smp_mb__{before,after}_atomic()")
Reply-To: paulmck@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20190503145326.GA21541@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org
Message-ID: <20190503145326.AfNciDkTcxFQ_eeN8so-PTOjSC_VB4zWKJTISgdTApM@z>

Hello, Alan,

Just following up on the -rcu commit below.  I believe that it needs
some adjustment given Peter Zijlstra's addition of "memory" to the x86
non-value-returning atomics, but thought I should double-check.

							Thanx, Paul

------------------------------------------------------------------------

commit f68f031d47f42f9fe07d9dee1ced48b2b0b8ae5e
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Apr 19 13:21:45 2019 -0400

    Documentation: atomic_t.txt: Explain ordering provided by smp_mb__{before,after}_atomic()
    
    The description of smp_mb__before_atomic() and smp_mb__after_atomic()
    in Documentation/atomic_t.txt is slightly terse and misleading.  It
    does not clearly state that these barriers only affect the ordering of
    other instructions with respect to the atomic operation.
    
    This improves the text to make the actual ordering implications clear,
    and also to explain how these barriers differ from a RELEASE or
    ACQUIRE ordering.
    
    Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index dca3fb0554db..d6e42d8f66de 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -188,7 +188,10 @@ The barriers:
   smp_mb__{before,after}_atomic()
 
 only apply to the RMW ops and can be used to augment/upgrade the ordering
-inherent to the used atomic op. These barriers provide a full smp_mb().
+inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
+only the RMW op itself against the instructions preceding the
+smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
+not order instructions on the other side of the RMW op at all.
 
 These helper barriers exist because architectures have varying implicit
 ordering on their SMP atomic primitives. For example our TSO architectures
@@ -212,7 +215,8 @@ Further, while something like:
   atomic_dec(&X);
 
 is a 'typical' RELEASE pattern, the barrier is strictly stronger than
-a RELEASE. Similarly for something like:
+a RELEASE because it orders preceding instructions against both the read
+and write parts of the atomic_dec(). Similarly, something like:
 
   atomic_inc(&X);
   smp_mb__after_atomic();
@@ -244,7 +248,8 @@ strictly stronger than ACQUIRE. As illustrated:
 
 This should not happen; but a hypothetical atomic_inc_acquire() --
 (void)atomic_fetch_inc_acquire() for instance -- would allow the outcome,
-since then:
+because it would not order the W part of the RMW against the following
+WRITE_ONCE.  Thus:
 
   P1			P2
 
