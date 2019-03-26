Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732912AbfCZXlm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Mar 2019 19:41:42 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QNXdPF004233
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:41 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rfvt9t8dq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2019 19:41:41 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:41:40 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/21] tools/memory-model: Add support for synchronize_srcu_expedited()
Date: Tue, 26 Mar 2019 16:41:20 -0700
In-Reply-To: <20190326234114.GA23843@linux.ibm.com>
References: <20190326234114.GA23843@linux.ibm.com>
Message-ID: <20190326234133.24962-8-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <20190326234120.jgXS4Xn-h7U-0blyalei9Eg6pXYlgclUtqi28OKnlVU@z>

Given that synchronize_rcu_expedited() is supported, this commit adds
support for synchronize_srcu_expedited().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/linux-kernel.def | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 0c3f0ef486f4..551eeaa389d4 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -51,6 +51,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
 srcu_read_lock(X)  __srcu{srcu-lock}(X)
 srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
 synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
+synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-- 
2.17.1
