From: Christoph Lameter <clameter@sgi.com>
Subject: [patch 31/41] VM statistics: Use CPU ops
Date: Thu, 29 May 2008 20:56:51 -0700
Message-ID: <20080530040021.460464557@sgi.com>
References: <20080530035620.587204923@sgi.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:45461 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753056AbYE3EAX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 00:00:23 -0400
Content-Disposition: inline; filename=cpu_alloc_ops_vmstat
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

The use of CPU ops here avoids the offset calculations that we used to have
to do with per cpu operations. The result of this patch is that event counters
are coded with a single instruction the following way:

	incq   %gs:offset(%rip)

Without these patches this was:

	mov    %gs:0x8,%rdx
	mov    %eax,0x38(%rsp)
	mov    xxx(%rip),%eax
	mov    %eax,0x48(%rsp)
	mov    varoffset,%rax
	incq   0x110(%rax,%rdx,1)

Signed-off-by: Christoph Lameter <clameter@sgi.com

---
 include/linux/vmstat.h |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h	2008-05-20 19:43:43.000000000 -0700
+++ linux-2.6/include/linux/vmstat.h	2008-05-20 21:40:32.000000000 -0700
@@ -63,24 +63,22 @@
 
 static inline void __count_vm_event(enum vm_event_item item)
 {
-	__get_cpu_var(vm_event_states).event[item]++;
+	__CPU_INC(per_cpu_var(vm_event_states).event[item]);
 }
 
 static inline void count_vm_event(enum vm_event_item item)
 {
-	get_cpu_var(vm_event_states).event[item]++;
-	put_cpu();
+	_CPU_INC(per_cpu_var(vm_event_states).event[item]);
 }
 
 static inline void __count_vm_events(enum vm_event_item item, long delta)
 {
-	__get_cpu_var(vm_event_states).event[item] += delta;
+	__CPU_ADD(per_cpu_var(vm_event_states).event[item], delta);
 }
 
 static inline void count_vm_events(enum vm_event_item item, long delta)
 {
-	get_cpu_var(vm_event_states).event[item] += delta;
-	put_cpu();
+	_CPU_ADD(per_cpu_var(vm_event_states).event[item], delta);
 }
 
 extern void all_vm_events(unsigned long *);

-- 
