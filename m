Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:44966 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031030AbXDTU1Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Apr 2007 16:27:25 -0400
Date: Fri, 20 Apr 2007 13:27:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: Better local_t implementation needed
In-Reply-To: <200704202214.17774.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0704201319310.4039@schroedinger.engr.sgi.com>
References: <617E1C2C70743745A92448908E030B2A015F22E3@scsmsx411.amr.corp.intel.com>
 <200704202214.17774.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 20 Apr 2007, Andi Kleen wrote:

> > But be warned that aggregating the per-cpu counters can be very
> > expensive on high cpu count ia64 systems.  We've had issues with
> > /proc files that provide system counts that do this in a cache
> > hostile way.
> 
> Can you expand? What cache hostile way?

We have fixed these issues using the ZVCs AFAIK. The event counters still 
have the same scheme though. They are rarely ever aggregated.

Per cpu counters should not be in arrays indexed by cpu. Because that will
place counters used by multiple processors in a cache line causing false
aliasing. VM event counters are indexed by event item and placed in the
per cpu areas for each counter.

Here is a patch that makes the VM use local_t. Patch is good for x86_64 
(exploits atomicity of inc/dec effectively if Andy has fixed the atomicity 
issues) but bad for IA64 since we are going from regular integer 
operations to atomics. I would think that the patch is not acceptable as 
long as cpu_local causes a regression on IA64.

Index: linux-2.6.21-rc6/include/linux/vmstat.h
===================================================================
--- linux-2.6.21-rc6.orig/include/linux/vmstat.h	2007-04-20 13:09:54.000000000 -0700
+++ linux-2.6.21-rc6/include/linux/vmstat.h	2007-04-20 13:13:30.000000000 -0700
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <asm/atomic.h>
+#include <asm/local.h>
 
 #ifdef CONFIG_ZONE_DMA
 #define DMA_ZONE(xx) xx##_DMA,
@@ -51,32 +52,26 @@ enum vm_event_item { PGPGIN, PGPGOUT, PS
  * generated will simply be the increment of a global address.
  */
 
-struct vm_event_state {
-	unsigned long event[NR_VM_EVENT_ITEMS];
-};
-
-DECLARE_PER_CPU(struct vm_event_state, vm_event_states);
+DECLARE_PER_CPU(local_t, vm_event_states)[NR_VM_EVENT_ITEMS];
 
 static inline void __count_vm_event(enum vm_event_item item)
 {
-	__get_cpu_var(vm_event_states).event[item]++;
+	__cpu_local_inc(vm_event_states[item]);
 }
 
 static inline void count_vm_event(enum vm_event_item item)
 {
-	get_cpu_var(vm_event_states).event[item]++;
-	put_cpu();
+	cpu_local_inc(vm_event_states[item]);
 }
 
 static inline void __count_vm_events(enum vm_event_item item, long delta)
 {
-	__get_cpu_var(vm_event_states).event[item] += delta;
+	__cpu_local_add(delta, vm_event_states[item]);
 }
 
 static inline void count_vm_events(enum vm_event_item item, long delta)
 {
-	get_cpu_var(vm_event_states).event[item] += delta;
-	put_cpu();
+	cpu_local_add(delta, vm_event_states[item]);
 }
 
 extern void all_vm_events(unsigned long *);
Index: linux-2.6.21-rc6/mm/vmstat.c
===================================================================
--- linux-2.6.21-rc6.orig/mm/vmstat.c	2007-04-20 13:10:08.000000000 -0700
+++ linux-2.6.21-rc6/mm/vmstat.c	2007-04-20 13:18:53.000000000 -0700
@@ -14,7 +14,8 @@
 #include <linux/cpu.h>
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
-DEFINE_PER_CPU(struct vm_event_state, vm_event_states) = {{0}};
+DEFINE_PER_CPU(local_t, vm_event_states)[NR_VM_EVENT_ITEMS] =
+						{ LOCAL_INIT(0) };
 EXPORT_PER_CPU_SYMBOL(vm_event_states);
 
 static void sum_vm_events(unsigned long *ret, cpumask_t *cpumask)
@@ -26,7 +27,7 @@ static void sum_vm_events(unsigned long 
 
 	cpu = first_cpu(*cpumask);
 	while (cpu < NR_CPUS) {
-		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
+		local_t *this = per_cpu(vm_event_states, cpu);
 
 		cpu = next_cpu(cpu, *cpumask);
 
@@ -35,7 +36,7 @@ static void sum_vm_events(unsigned long 
 
 
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
-			ret[i] += this->event[i];
+			ret[i] += local_read(&this[i]);
 	}
 }
 
@@ -59,12 +60,12 @@ EXPORT_SYMBOL_GPL(all_vm_events);
  */
 void vm_events_fold_cpu(int cpu)
 {
-	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
+	local_t *fold_state = per_cpu(vm_event_states, cpu);
 	int i;
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-		count_vm_events(i, fold_state->event[i]);
-		fold_state->event[i] = 0;
+		count_vm_events(i, local_read(&fold_state[i]));
+		local_set(&fold_state[i], 0);
 	}
 }
 #endif /* CONFIG_HOTPLUG */
@@ -586,7 +587,8 @@ static void *vmstat_start(struct seq_fil
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	v = kmalloc(NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long)
-			+ sizeof(struct vm_event_state), GFP_KERNEL);
+			+ sizeof(local_t) * NR_VM_EVENT_ITEMS,
+			GFP_KERNEL);
 #else
 	v = kmalloc(NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long),
 			GFP_KERNEL);
