From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 09/15] uprobes: Remove now-redundant smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:43 -0700
Message-ID: <1507594969-8347-9-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755725AbdJJAWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 20:22:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9A0JPnW109685
        for <linux-arch@vger.kernel.org>; Mon, 9 Oct 2017 20:22:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dggmafayd-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 20:22:54 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Oct 2017 20:22:53 -0400
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>

Now that READ_ONCE() implies smp_read_barrier_depends(), the
get_xol_area() and get_trampoline_vaddr() no longer need their
smp_read_barrier_depends() calls, which this commit removes.
While we are here, convert the corresponding smp_wmb() to an
smp_store_release().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/uprobes.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 267f6ef91d97..ce6848e46e94 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1167,8 +1167,8 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 	}
 
 	ret = 0;
-	smp_wmb();	/* pairs with get_xol_area() */
-	mm->uprobes_state.xol_area = area;
+	/* pairs with get_xol_area() */
+	smp_store_release(&mm->uprobes_state.xol_area, area); /* ^^^ */
  fail:
 	up_write(&mm->mmap_sem);
 
@@ -1230,8 +1230,8 @@ static struct xol_area *get_xol_area(void)
 	if (!mm->uprobes_state.xol_area)
 		__create_xol_area(0);
 
-	area = mm->uprobes_state.xol_area;
-	smp_read_barrier_depends();	/* pairs with wmb in xol_add_vma() */
+	/* Pairs with xol_add_vma() smp_store_release() */
+	area = READ_ONCE(mm->uprobes_state.xol_area); /* ^^^ */
 	return area;
 }
 
@@ -1528,8 +1528,8 @@ static unsigned long get_trampoline_vaddr(void)
 	struct xol_area *area;
 	unsigned long trampoline_vaddr = -1;
 
-	area = current->mm->uprobes_state.xol_area;
-	smp_read_barrier_depends();
+	/* Pairs with xol_add_vma() smp_store_release() */
+	area = READ_ONCE(current->mm->uprobes_state.xol_area); /* ^^^ */
 	if (area)
 		trampoline_vaddr = area->vaddr;
 
-- 
2.5.2
