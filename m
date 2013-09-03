From: Christoph Lameter <cl@linux.com>
Subject: [gcv v4 04/38] Use raw_cpu ops so that my kvm session runs fine
Date: Tue, 3 Sep 2013 19:12:19 +0000
Message-ID: <00000140e53d5ee0-f686d7ad-5dcf-425a-bafb-c617adf23272-000000@email.amazonses.com>
References: <20130903190014.794420260@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from b232-131.smtp-out.amazonses.com ([199.127.232.131]:51935 "EHLO
	b232-131.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754095Ab3ICTV6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Sep 2013 15:21:58 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

These location triggered during testing with KVM. The list here
is by no means extensive.

These are fetches without preemption off where we judged that
to be more performance efficient or where other means of
providing synchronization (BH handling) are avalt ilable.

Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/include/linux/topology.h
===================================================================
--- linux.orig/include/linux/topology.h	2013-09-03 13:41:00.701563523 -0500
+++ linux/include/linux/topology.h	2013-09-03 13:41:00.693563604 -0500
@@ -182,7 +182,7 @@ DECLARE_PER_CPU(int, numa_node);
 /* Returns the number of the current Node. */
 static inline int numa_node_id(void)
 {
-	return __this_cpu_read(numa_node);
+	return raw_cpu_read(numa_node);
 }
 #endif
 
Index: linux/include/net/snmp.h
===================================================================
--- linux.orig/include/net/snmp.h	2013-09-03 13:41:00.701563523 -0500
+++ linux/include/net/snmp.h	2013-09-03 13:49:05.840592016 -0500
@@ -126,7 +126,7 @@ struct linux_xfrm_mib {
 	extern __typeof__(type) __percpu *name[SNMP_ARRAY_SZ]
 
 #define SNMP_INC_STATS_BH(mib, field)	\
-			__this_cpu_inc(mib[0]->mibs[field])
+			raw_cpu_inc(mib[0]->mibs[field])
 
 #define SNMP_INC_STATS_USER(mib, field)	\
 			this_cpu_inc(mib[0]->mibs[field])
@@ -141,7 +141,7 @@ struct linux_xfrm_mib {
 			this_cpu_dec(mib[0]->mibs[field])
 
 #define SNMP_ADD_STATS_BH(mib, field, addend)	\
-			__this_cpu_add(mib[0]->mibs[field], addend)
+			raw_cpu_add(mib[0]->mibs[field], addend)
 
 #define SNMP_ADD_STATS_USER(mib, field, addend)	\
 			this_cpu_add(mib[0]->mibs[field], addend)
Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c	2013-09-03 13:41:00.701563523 -0500
+++ linux/kernel/hrtimer.c	2013-09-03 13:41:00.693563604 -0500
@@ -538,7 +538,7 @@ static inline int hrtimer_is_hres_enable
  */
 static inline int hrtimer_hres_active(void)
 {
-	return __this_cpu_read(hrtimer_bases.hres_active);
+	return raw_cpu_read(hrtimer_bases.hres_active);
 }
 
 /*
