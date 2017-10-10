Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755816AbdJJAW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JOYR109576
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:55 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dggmafb01-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:55 -0400
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:54 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 08/15] seqlock: Remove now-redundant smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:42 -0700
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Message-ID: <1507594969-8347-8-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20171010002242.hcH6JHjkzV_nasC2TkJiuTMzXapra1IyCXs6QfjTuEA@z>

READ_ONCE() now implies smp_read_barrier_depends(), so this patch
removes the now-redundant smp_read_barrier_depends() from
raw_read_seqcount_latch().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/seqlock.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ead97654c4e9..27364347ff68 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -277,9 +277,8 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
-	int seq = READ_ONCE(s->sequence);
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
-	smp_read_barrier_depends();
+	int seq = READ_ONCE(s->sequence); /* ^^^ */
 	return seq;
 }
 
-- 
2.5.2
