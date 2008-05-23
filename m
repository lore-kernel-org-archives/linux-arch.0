From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: Fri, 23 May 2008 03:44:08 +0200
Message-ID: <20080523014408.GA30209@wotan.suse.de>
References: <20080521152855.GE8897@wotan.suse.de> <20080522095121.GA18012@wotan.suse.de> <483566E7.8010703@sgi.com> <200805220934.07871.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:42104 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbYEWBoM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 May 2008 21:44:12 -0400
Content-Disposition: inline
In-Reply-To: <200805220934.07871.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jes Sorensen <jes@sgi.com>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 22, 2008 at 09:34:07AM -0700, Jesse Barnes wrote:
> On Thursday, May 22, 2008 5:28 am Jes Sorensen wrote:
> > Nick Piggin wrote:
> > > Right, but probably the large majority of wmb() callers actually
> > > just want io_wmb(). This would relieve much of the performance
> > > problem, I'd say.
> > >
> > > Of those that really want a wmb() and cannot be converted to
> > > io_wmb(), I don't think it is a good option to actually just weaken
> > > wmb() because we deem that doing what the caller asked for is too
> > > expensive.
> >
> > Hi Nick,
> >
> > I believe there's a fair number of places where wmb() is used for
> > memory ordering not related to IO.
> >
> > > I guess with the ia64_mf(), Altix probably does not reorder PCI
> > > stores past earlier cacheable stores, so _some_ wmb()s actually
> > > do not require the full mmiowb case (if we only need to order
> > > an earlier RAM store with a later PCI store). However, again,
> > > weakening wmb() is not a good option because it really requires
> > > an audit of the entire tree to do that.
> >
> > Nope, unfortunately not, ia64_mf() isn't strong enough to prevent the
> > reordering, it's done in the PCI controller, so in order to guarantee
> > the the reording you have to go all the way out to the PCI controller,
> > which is very slow.
> 
> And more than that, the local PCI controller has to wait for any outstanding 
> writes to arrive at the target host bridge.  That's why the operation is so 
> expensive.

Right, but if the code *needs* a wmb(), then skipping the full ordering
steps basically means that sn2 doesn't implement the Linux memory
barrier specification properly. It may be expensive, but it is
perfectly legitimate for code to say

writel(iomem)
wmb();
written = 1;

And expect iomem to be seen at the device before an io store from
another CPU which has seen written == 1 (provided it issues the
correct barriers too).

 
> > > We _could_ introduce partial barriers like store/iostore iostore/store,
> > > but really, I think the io_wmb is a pretty good first step, and I
> > > haven't actually seen any numbers indicating it would be a performance
> > > problem.
> >
> > I must admit I am not 100% upto speed on the entire discussion, but I
> > think the io_wmb() and friends did go around in the past and got shot
> > down.
> 
> To be fair to the ia64 guys who pushed this (me), I think the powerpc guys 
> were supposed to introduce the other set of barriers they needed at around 
> the same time, so we'd have the complete set.  I guess they never got around 
> to it.

OK, I'm not trying to assign any blame ;) I just want to try improving
things.

 
> Given that core kernel code using wmb() usually doesn't care about I/O 
> ordering, making it into a heavyweight operation might be a bad idea, 
> especially if powerpc wants to weaken its wmb() operations eventually.

There are a lot of suspect barriers which should be smp_ variants, as
Paul says. Attached is a very quick pass of a few key directories...
needs review from respective maintainers, but it gives an idea.

powerpc does *not* want to weaken its wmb(), but what it can do is
take advantage of a cheaper io_wmb(), like sn2.
 

> Is there really a conflict of definitions except for between ia64 and powerpc 
> here?  IIRC they needed more types of barriers to speed things up, but never 
> introduced them, and so had to make some of the existing barriers much more 
> expensive than they would have liked...

There are a couple of other types of barriers I guess you could
introduce... partial barriers like load/store store/load iostore/store
etc.; or acquire/release for IO. I think the latter isn't such a bad
idea, but either way you're introducing new barrier concepts when we
already have trouble getting the existing ones right.

io_ barriers I guess should be easier to understand if one already
understands existing barriers, so I think they are the best first
step.

--


Index: linux-2.6/arch/x86/kernel/kvmclock.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/kvmclock.c
+++ linux-2.6/arch/x86/kernel/kvmclock.c
@@ -69,10 +69,10 @@ unsigned long kvm_get_wallclock(void)
 	native_write_msr(MSR_KVM_WALL_CLOCK, low, high);
 	do {
 		version = wall_clock.wc_version;
-		rmb();
+		smp_rmb();
 		wc_sec = wall_clock.wc_sec;
 		wc_nsec = wall_clock.wc_nsec;
-		rmb();
+		smp_rmb();
 	} while ((wall_clock.wc_version != version) || (version & 1));
 
 	delta = kvm_clock_read() - delta;
Index: linux-2.6/arch/x86/lguest/boot.c
===================================================================
--- linux-2.6.orig/arch/x86/lguest/boot.c
+++ linux-2.6/arch/x86/lguest/boot.c
@@ -113,7 +113,7 @@ static void async_hcall(unsigned long ca
 		lguest_data.hcalls[next_call].arg2 = arg2;
 		lguest_data.hcalls[next_call].arg3 = arg3;
 		/* Arguments must all be written before we mark it to go */
-		wmb();
+		smp_wmb();
 		lguest_data.hcall_status[next_call] = 0;
 		if (++next_call == LHCALL_RING_SIZE)
 			next_call = 0;
@@ -627,11 +627,11 @@ static cycle_t lguest_clock_read(void)
 		/* This read memory barrier tells the compiler and the CPU that
 		 * this can't be reordered: we have to complete the above
 		 * before going on. */
-		rmb();
+		smp_rmb();
 		/* Now we read the nanoseconds part. */
 		nsec = lguest_data.time.tv_nsec;
 		/* Make sure we've done that. */
-		rmb();
+		smp_rmb();
 		/* Now if the seconds part has changed, try again. */
 	} while (unlikely(lguest_data.time.tv_sec != sec));
 
Index: linux-2.6/arch/x86/xen/smp.c
===================================================================
--- linux-2.6.orig/arch/x86/xen/smp.c
+++ linux-2.6/arch/x86/xen/smp.c
@@ -302,7 +302,7 @@ int __cpuinit xen_cpu_up(unsigned int cp
 	smp_store_cpu_info(cpu);
 	set_cpu_sibling_map(cpu);
 	/* This must be done before setting cpu_online_map */
-	wmb();
+	smp_wmb();
 
 	cpu_set(cpu, cpu_online_map);
 
Index: linux-2.6/arch/x86/xen/time.c
===================================================================
--- linux-2.6.orig/arch/x86/xen/time.c
+++ linux-2.6/arch/x86/xen/time.c
@@ -247,12 +247,12 @@ static unsigned get_time_values_from_xen
 
 	do {
 		dst->version = src->version;
-		rmb();		/* fetch version before data */
+		smp_rmb();		/* fetch version before data */
 		dst->tsc_timestamp     = src->tsc_timestamp;
 		dst->system_timestamp  = src->system_time;
 		dst->tsc_to_nsec_mul   = src->tsc_to_system_mul;
 		dst->tsc_shift         = src->tsc_shift;
-		rmb();		/* test version after fetching data */
+		smp_rmb();		/* test version after fetching data */
 	} while ((src->version & 1) | (dst->version ^ src->version));
 
 	return dst->version;
@@ -332,10 +332,10 @@ static void xen_read_wallclock(struct ti
 	/* get wallclock at system boot */
 	do {
 		version = s->wc_version;
-		rmb();		/* fetch version before time */
+		smp_rmb();		/* fetch version before time */
 		now.tv_sec  = s->wc_sec;
 		now.tv_nsec = s->wc_nsec;
-		rmb();		/* fetch time before checking version */
+		smp_rmb();		/* fetch time before checking version */
 	} while ((s->wc_version & 1) | (version ^ s->wc_version));
 
 	delta = xen_clocksource_read();	/* time since system boot */
Index: linux-2.6/crypto/xor.c
===================================================================
--- linux-2.6.orig/crypto/xor.c
+++ linux-2.6/crypto/xor.c
@@ -78,11 +78,11 @@ do_xor_speed(struct xor_block_template *
 		now = jiffies;
 		count = 0;
 		while (jiffies == now) {
-			mb(); /* prevent loop optimzation */
+			barrier(); /* prevent loop optimzation */
 			tmpl->do_2(BENCH_SIZE, b1, b2);
-			mb();
+			barrier();
 			count++;
-			mb();
+			barrier();
 		}
 		if (count > max)
 			max = count;
Index: linux-2.6/drivers/block/xen-blkfront.c
===================================================================
--- linux-2.6.orig/drivers/block/xen-blkfront.c
+++ linux-2.6/drivers/block/xen-blkfront.c
@@ -481,7 +481,7 @@ static irqreturn_t blkif_interrupt(int i
 
  again:
 	rp = info->ring.sring->rsp_prod;
-	rmb(); /* Ensure we see queued responses up to 'rp'. */
+	smp_rmb(); /* Ensure we see queued responses up to 'rp'. */
 
 	for (i = info->ring.rsp_cons; i != rp; i++) {
 		unsigned long id;
Index: linux-2.6/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6/drivers/oprofile/buffer_sync.c
@@ -416,7 +416,7 @@ static void increment_tail(struct oprofi
 {
 	unsigned long new_tail = b->tail_pos + 1;
 
-	rmb();
+	smp_rmb();
 
 	if (new_tail < b->buffer_size)
 		b->tail_pos = new_tail;
Index: linux-2.6/drivers/oprofile/cpu_buffer.c
===================================================================
--- linux-2.6.orig/drivers/oprofile/cpu_buffer.c
+++ linux-2.6/drivers/oprofile/cpu_buffer.c
@@ -137,7 +137,7 @@ static void increment_head(struct oprofi
 
 	/* Ensure anything written to the slot before we
 	 * increment is visible */
-	wmb();
+	smp_wmb();
 
 	if (new_head < b->buffer_size)
 		b->head_pos = new_head;
Index: linux-2.6/drivers/xen/events.c
===================================================================
--- linux-2.6.orig/drivers/xen/events.c
+++ linux-2.6/drivers/xen/events.c
@@ -527,10 +527,8 @@ void xen_evtchn_do_upcall(struct pt_regs
 		if (__get_cpu_var(nesting_count)++)
 			goto out;
 
-#ifndef CONFIG_X86 /* No need for a barrier -- XCHG is a barrier on x86. */
 		/* Clear master flag /before/ clearing selector flag. */
-		rmb();
-#endif
+		smp_rmb();
 		pending_words = xchg(&vcpu_info->evtchn_pending_sel, 0);
 		while (pending_words != 0) {
 			unsigned long pending_bits;
Index: linux-2.6/drivers/xen/grant-table.c
===================================================================
--- linux-2.6.orig/drivers/xen/grant-table.c
+++ linux-2.6/drivers/xen/grant-table.c
@@ -150,7 +150,7 @@ static void update_grant_entry(grant_ref
 	 */
 	shared[ref].frame = frame;
 	shared[ref].domid = domid;
-	wmb();
+	smp_wmb();
 	shared[ref].flags = flags;
 }
 
@@ -264,7 +264,7 @@ unsigned long gnttab_end_foreign_transfe
 		cpu_relax();
 	}
 
-	rmb();	/* Read the frame number /after/ reading completion status. */
+	smp_rmb();/* Read the frame number /after/ reading completion status. */
 	frame = shared[ref].frame;
 	BUG_ON(frame == 0);
 
Index: linux-2.6/include/xen/interface/io/ring.h
===================================================================
--- linux-2.6.orig/include/xen/interface/io/ring.h
+++ linux-2.6/include/xen/interface/io/ring.h
@@ -182,12 +182,12 @@ struct __name##_back_ring {						\
     (((_cons) - (_r)->rsp_prod_pvt) >= RING_SIZE(_r))
 
 #define RING_PUSH_REQUESTS(_r) do {					\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
 } while (0)
 
 #define RING_PUSH_RESPONSES(_r) do {					\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
 } while (0)
 
@@ -224,9 +224,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->req_prod;				\
     RING_IDX __new = (_r)->req_prod_pvt;				\
-    wmb(); /* back sees requests /before/ updated producer index */	\
+    smp_wmb(); /* back sees requests /before/ updated producer index */	\
     (_r)->sring->req_prod = __new;					\
-    mb(); /* back sees new requests /before/ we check req_event */	\
+    smp_mb(); /* back sees new requests /before/ we check req_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -234,9 +234,9 @@ struct __name##_back_ring {						\
 #define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
     RING_IDX __old = (_r)->sring->rsp_prod;				\
     RING_IDX __new = (_r)->rsp_prod_pvt;				\
-    wmb(); /* front sees responses /before/ updated producer index */	\
+    smp_wmb(); /* front sees responses /before/ updated producer index */	\
     (_r)->sring->rsp_prod = __new;					\
-    mb(); /* front sees new responses /before/ we check rsp_event */	\
+    smp_mb(); /* front sees new responses /before/ we check rsp_event */	\
     (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
 		 (RING_IDX)(__new - __old));				\
 } while (0)
@@ -245,7 +245,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->req_event = (_r)->req_cons + 1;			\
-    mb();								\
+    smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
 } while (0)
 
@@ -253,7 +253,7 @@ struct __name##_back_ring {						\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
     if (_work_to_do) break;						\
     (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
-    mb();								\
+    smp_mb();								\
     (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
 } while (0)
 
Index: linux-2.6/kernel/power/process.c
===================================================================
--- linux-2.6.orig/kernel/power/process.c
+++ linux-2.6/kernel/power/process.c
@@ -38,7 +38,7 @@ static inline void frozen_process(void)
 {
 	if (!unlikely(current->flags & PF_NOFREEZE)) {
 		current->flags |= PF_FROZEN;
-		wmb();
+		smp_wmb();
 	}
 	clear_freeze_flag(current);
 }
@@ -122,7 +122,7 @@ static int freeze_task(struct task_struc
 				wake_up_state(p, TASK_INTERRUPTIBLE);
 		}
 	} else {
-		rmb();
+		smp_rmb();
 		if (frozen(p)) {
 			ret = 0;
 		} else {
Index: linux-2.6/kernel/sched_rt.c
===================================================================
--- linux-2.6.orig/kernel/sched_rt.c
+++ linux-2.6/kernel/sched_rt.c
@@ -20,7 +20,7 @@ static inline void rt_set_overload(struc
 	 * if we looked at the mask, but the mask was not
 	 * updated yet.
 	 */
-	wmb();
+	smp_wmb();
 	atomic_inc(&rq->rd->rto_count);
 }
 
Index: linux-2.6/net/sched/cls_rsvp.h
===================================================================
--- linux-2.6.orig/net/sched/cls_rsvp.h
+++ linux-2.6/net/sched/cls_rsvp.h
@@ -516,7 +516,7 @@ insert:
 				if (((*fp)->spi.mask&f->spi.mask) != f->spi.mask)
 					break;
 			f->next = *fp;
-			wmb();
+			smp_wmb();
 			*fp = f;
 
 			*arg = (unsigned long)f;
@@ -542,7 +542,7 @@ insert:
 			break;
 	}
 	s->next = *sp;
-	wmb();
+	smp_wmb();
 	*sp = s;
 
 	goto insert;
Index: linux-2.6/net/sched/cls_u32.c
===================================================================
--- linux-2.6.orig/net/sched/cls_u32.c
+++ linux-2.6/net/sched/cls_u32.c
@@ -649,7 +649,7 @@ static int u32_change(struct tcf_proto *
 				break;
 
 		n->next = *ins;
-		wmb();
+		smp_wmb();
 		*ins = n;
 
 		*arg = (unsigned long)n;
Index: linux-2.6/security/selinux/ss/sidtab.c
===================================================================
--- linux-2.6.orig/security/selinux/ss/sidtab.c
+++ linux-2.6/security/selinux/ss/sidtab.c
@@ -71,11 +71,11 @@ int sidtab_insert(struct sidtab *s, u32 
 
 	if (prev) {
 		newnode->next = prev->next;
-		wmb();
+		smp_wmb();
 		prev->next = newnode;
 	} else {
 		newnode->next = s->htable[hvalue];
-		wmb();
+		smp_wmb();
 		s->htable[hvalue] = newnode;
 	}
 
Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c
+++ linux-2.6/arch/ia64/kernel/process.c
@@ -314,7 +314,7 @@ cpu_idle (void)
 #ifdef CONFIG_SMP
 			min_xtp();
 #endif
-			rmb();
+			smp_rmb();
 			if (mark_idle)
 				(*mark_idle)(1);
 
Index: linux-2.6/arch/ia64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/smp.c
+++ linux-2.6/arch/ia64/kernel/smp.c
@@ -112,13 +112,13 @@ handle_call_data(void)
 	info = data->info;
 	wait = data->wait;
 
-	mb();
+	smp_mb();
 	atomic_inc(&data->started);
 	/* At this point the structure may be gone unless wait is true. */
 	(*func)(info);
 
 	/* Notify the sending CPU that the task is done. */
-	mb();
+	smp_mb();
 	if (wait)
 		atomic_inc(&data->finished);
 }
@@ -153,9 +153,9 @@ handle_IPI (int irq, void *dev_id)
 	unsigned long *pending_ipis = &__ia64_per_cpu_var(ipi_operation);
 	unsigned long ops;
 
-	mb();	/* Order interrupt and bit testing. */
+	smp_mb();	/* Order interrupt and bit testing. */
 	while ((ops = xchg(pending_ipis, 0)) != 0) {
-		mb();	/* Order bit clearing and data access. */
+		smp_mb();	/* Order bit clearing and data access. */
 		do {
 			unsigned long which;
 
@@ -181,7 +181,7 @@ handle_IPI (int irq, void *dev_id)
 				break;
 			}
 		} while (ops);
-		mb();	/* Order data access and bit testing. */
+		smp_mb();	/* Order data access and bit testing. */
 	}
 	put_cpu();
 	return IRQ_HANDLED;
@@ -313,7 +313,7 @@ smp_flush_tlb_cpumask(cpumask_t xcpumask
 	for_each_cpu_mask(cpu, cpumask)
 		counts[cpu] = local_tlb_flush_counts[cpu].count;
 
-	mb();
+	smp_mb();
 	for_each_cpu_mask(cpu, cpumask) {
 		if (cpu == mycpu)
 			flush_mycpu = 1;
@@ -398,7 +398,7 @@ smp_call_function_single (int cpuid, voi
 	spin_lock_bh(&call_lock);
 
 	call_data = &data;
-	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
+	smp_mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
   	send_IPI_single(cpuid, IPI_CALL_FUNC);
 
 	/* Wait for response */
@@ -462,7 +462,7 @@ int smp_call_function_mask(cpumask_t mas
 		atomic_set(&data.finished, 0);
 
 	call_data = &data;
-	mb(); /* ensure store to call_data precedes setting of IPI_CALL_FUNC*/
+	smp_mb(); /* ensure store to call_data precedes setting of IPI_CALL_FUNC*/
 
 	/* Send a message to other CPUs */
 	if (cpus_equal(mask, allbutself))
@@ -528,7 +528,7 @@ smp_call_function (void (*func) (void *i
 		atomic_set(&data.finished, 0);
 
 	call_data = &data;
-	mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
+	smp_mb();	/* ensure store to call_data precedes setting of IPI_CALL_FUNC */
 	send_IPI_allbutself(IPI_CALL_FUNC);
 
 	/* Wait for response */
Index: linux-2.6/arch/ia64/kernel/unaligned.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/unaligned.c
+++ linux-2.6/arch/ia64/kernel/unaligned.c
@@ -856,7 +856,7 @@ emulate_load_int (unsigned long ifa, loa
 	 * use ordering fence.
 	 */
 	if (ld.x6_op == 0x5 || ld.x6_op == 0xa)
-		mb();
+		smp_mb();
 
 	/*
 	 * invalidate ALAT entry in case of advanced load
@@ -937,7 +937,7 @@ emulate_store_int (unsigned long ifa, lo
 	 * stX.rel: use fence instead of release
 	 */
 	if (ld.x6_op == 0xd)
-		mb();
+		smp_mb();
 
 	return 0;
 }
Index: linux-2.6/arch/ia64/kvm/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kvm/process.c
+++ linux-2.6/arch/ia64/kvm/process.c
@@ -722,7 +722,7 @@ void leave_hypervisor_tail(void)
 		}
 	}
 
-	rmb();
+	smp_rmb();
 	if (v->arch.irq_new_pending) {
 		v->arch.irq_new_pending = 0;
 		VMX(v, irq_check) = 0;
Index: linux-2.6/arch/ia64/kvm/vcpu.c
===================================================================
--- linux-2.6.orig/arch/ia64/kvm/vcpu.c
+++ linux-2.6/arch/ia64/kvm/vcpu.c
@@ -934,7 +934,7 @@ void vcpu_unpend_interrupt(struct kvm_vc
 	local_irq_restore(spsr);
 	if (ret) {
 		vcpu->arch.irq_new_pending = 1;
-		wmb();
+		smp_wmb();
 	}
 }
 
