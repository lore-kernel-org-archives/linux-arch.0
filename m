Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754473AbeCGR1N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2018 12:27:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w27HPjNg066477
        for <linux-arch@vger.kernel.org>; Wed, 7 Mar 2018 12:27:13 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gjhk8gj3f-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 07 Mar 2018 12:27:12 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 7 Mar 2018 12:27:12 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 3/4] tools/memory-order: Add documentation of new litmus test
Date: Wed,  7 Mar 2018 09:27:39 -0800
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <1520443660-16858-3-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20180307172739.Ts9VWbITeeMsChm0WGCviq3iafFXG4abiand9yN1iV4@z>

The litmus-tests/README file lacks any mention of the new litmus test
ISA2+pooncelock+pooncelock+pombonce.litmus.  This commit therefore
adds a description of this test.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/litmus-tests/README | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index dca7d823ad57..04096fb8b8d9 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -32,6 +32,12 @@ IRIW+poonceonces+OnceOnce.litmus
 	order of a pair of writes, where each write is to a different
 	variable by a different process?
 
+ISA2+pooncelock+pooncelock+pombonce.litmus
+	Tests whether the ordering provided by a lock-protected S
+	litmus test is visible to an external process whose accesses are
+	separated by smp_mb().	This addition of an external process to
+	S is otherwise known as ISA2.
+
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
-- 
2.5.2
