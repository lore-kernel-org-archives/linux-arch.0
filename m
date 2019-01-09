Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfAIWVz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 17:21:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09MJM2g019610
        for <linux-arch@vger.kernel.org>; Wed, 9 Jan 2019 17:21:54 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwrhytvdb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 17:21:54 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 22:21:53 -0000
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/2] include/asm-generic: Remove spin_is_locked() comment
Date: Wed,  9 Jan 2019 14:21:43 -0800
In-Reply-To: <20190109222120.GA13904@linux.ibm.com>
References: <20190109222120.GA13904@linux.ibm.com>
Message-ID: <20190109222144.14270-1-paulmck@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com, akpm@linux-foundation.org, mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20190109222143.GXWl1BBj2SvuYly6ybTV4d-lCetpHXaSR-WJOKYroBI@z>

The WARN_ON_SMP() comment header suggests using spin_is_locked() to
check for locks being held.  But these days we prefer lockdep_assert_held(),
so this commit removes that suggestion.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..0e9bd9c83870 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -211,9 +211,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 /*
  * WARN_ON_SMP() is for cases that the warning is either
  * meaningless for !SMP or may even cause failures.
- * This is usually used for cases that we have
- * WARN_ON(!spin_is_locked(&lock)) checks, as spin_is_locked()
- * returns 0 for uniprocessor settings.
  * It can also be used with values that are only defined
  * on SMP:
  *
-- 
2.17.1
