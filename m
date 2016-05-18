From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 15/15] x86: Fix misc cmpxchg() and atomic_cmpxchg()
 calls to use try/return variants
Date: Wed, 18 May 2016 16:12:29 +0100
Message-ID: <146358434987.8596.7101741254112333503.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

Fix miscellaneous cmpxchg() and atomic_cmpxchg() uses in the x86 arch to
use the try_ or _return variants instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/events/amd/core.c       |    6 +++---
 arch/x86/events/amd/uncore.c     |    4 ++--
 arch/x86/kernel/acpi/boot.c      |   12 ++++--------
 arch/x86/kernel/apic/apic.c      |    3 +--
 arch/x86/kernel/cpu/mcheck/mce.c |    7 +++----
 arch/x86/kernel/kvm.c            |    5 ++---
 arch/x86/kernel/smp.c            |    2 +-
 arch/x86/kvm/mmu.c               |    2 +-
 arch/x86/kvm/paging_tmpl.h       |   11 +++--------
 arch/x86/kvm/vmx.c               |   21 ++++++++++++---------
 arch/x86/kvm/x86.c               |   19 ++++++-------------
 arch/x86/mm/pat.c                |    2 +-
 arch/x86/xen/p2m.c               |    3 +--
 arch/x86/xen/spinlock.c          |    6 ++----
 14 files changed, 42 insertions(+), 61 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bd3e8421b57c..0da8422b0269 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -247,7 +247,7 @@ static void __amd_put_nb_event_constraints(struct cpu_hw_events *cpuc,
 	 * when we come here
 	 */
 	for (i = 0; i < x86_pmu.num_counters; i++) {
-		if (cmpxchg(nb->owners + i, event, NULL) == event)
+		if (try_cmpxchg(nb->owners + i, event, NULL))
 			break;
 	}
 }
@@ -316,7 +316,7 @@ __amd_get_nb_event_constraints(struct cpu_hw_events *cpuc, struct perf_event *ev
 	for_each_set_bit(idx, c->idxmsk, x86_pmu.num_counters) {
 		if (new == -1 || hwc->idx == idx)
 			/* assign free slot, prefer hwc->idx */
-			old = cmpxchg(nb->owners + idx, NULL, event);
+			cmpxchg_return(nb->owners + idx, NULL, event, &old);
 		else if (nb->owners[idx] == event)
 			/* event already present */
 			old = event;
@@ -328,7 +328,7 @@ __amd_get_nb_event_constraints(struct cpu_hw_events *cpuc, struct perf_event *ev
 
 		/* reassign to this slot */
 		if (new != -1)
-			cmpxchg(nb->owners + new, event, NULL);
+			try_cmpxchg(nb->owners + new, event, NULL);
 		new = idx;
 
 		/* already present, reuse */
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 3db9569e658c..c67740884026 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -135,7 +135,7 @@ static int amd_uncore_add(struct perf_event *event, int flags)
 	/* if not, take the first available counter */
 	hwc->idx = -1;
 	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], NULL, event) == NULL) {
+		if (try_cmpxchg(&uncore->events[i], NULL, event)) {
 			hwc->idx = i;
 			break;
 		}
@@ -165,7 +165,7 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	amd_uncore_stop(event, PERF_EF_UPDATE);
 
 	for (i = 0; i < uncore->num_counters; i++) {
-		if (cmpxchg(&uncore->events[i], event, NULL) == event)
+		if (try_cmpxchg(&uncore->events[i], event, NULL))
 			break;
 	}
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 8c2f1ef6ca23..f7fe2d0bf9df 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1679,23 +1679,19 @@ early_param("acpi_sci", setup_acpi_sci);
 
 int __acpi_acquire_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int new, old = *lock;
 	do {
-		old = *lock;
 		new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (unlikely(!cmpxchg_return_acquire(lock, old, new, &old)));
 	return (new < 3) ? -1 : 0;
 }
 
 int __acpi_release_global_lock(unsigned int *lock)
 {
-	unsigned int old, new, val;
+	unsigned int new, old = *lock;
 	do {
-		old = *lock;
 		new = old & ~0x3;
-		val = cmpxchg(lock, old, new);
-	} while (unlikely (val != old));
+	} while (unlikely(!cmpxchg_return_release(lock, old, new, &old)));
 	return old & 0x1;
 }
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d356987a04e9..2b361f8f8142 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -407,8 +407,7 @@ static unsigned int reserve_eilvt_offset(int offset, unsigned int new)
 		if (vector && !eilvt_entry_is_changeable(vector, new))
 			/* may not change if vectors are different */
 			return rsvd;
-		rsvd = atomic_cmpxchg(&eilvt_offsets[offset], rsvd, new);
-	} while (rsvd != new);
+	} while (!atomic_cmpxchg_return(&eilvt_offsets[offset], rsvd, new, &rsvd));
 
 	rsvd &= ~APIC_EILVT_MASKED;
 	if (rsvd && rsvd != vector)
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index f0c921b03e42..edf28be75694 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -186,7 +186,7 @@ void mce_log(struct mce *mce)
 		}
 		smp_rmb();
 		next = entry + 1;
-		if (cmpxchg(&mcelog.next, entry, next) == entry)
+		if (try_cmpxchg(&mcelog.next, entry, next))
 			break;
 	}
 	memcpy(mcelog.entry + entry, mce, sizeof(struct mce));
@@ -1880,8 +1880,7 @@ timeout:
 		memset(mcelog.entry + prev, 0,
 		       (next - prev) * sizeof(struct mce));
 		prev = next;
-		next = cmpxchg(&mcelog.next, prev, 0);
-	} while (next != prev);
+	} while (!cmpxchg_return(&mcelog.next, prev, 0, &next));
 
 	synchronize_sched();
 
@@ -1940,7 +1939,7 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 
 		do {
 			flags = mcelog.flags;
-		} while (cmpxchg(&mcelog.flags, flags, 0) != flags);
+		} while (!try_cmpxchg(&mcelog.flags, flags, 0));
 
 		return put_user(flags, p);
 	}
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 807950860fb7..6b56b0623b09 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -645,9 +645,8 @@ static inline void check_zero(void)
 
 	old = READ_ONCE(zero_stats);
 	if (unlikely(old)) {
-		ret = cmpxchg(&zero_stats, old, 0);
-		/* This ensures only one fellow resets the stat */
-		if (ret == old)
+		if (try_cmpxchg(&zero_stats, old, 0))
+			/* This ensures only one fellow resets the stat */
 			memset(&spinlock_stats, 0, sizeof(spinlock_stats));
 	}
 }
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 658777cf3851..482d84e10c1b 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -200,7 +200,7 @@ static void native_stop_other_cpus(int wait)
 	 */
 	if (num_online_cpus() > 1) {
 		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
+		if (atomic_try_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()))
 			return;
 
 		/* sync above data before sending IRQ */
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index b6f50e8b0a39..fe25226ec429 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2911,7 +2911,7 @@ fast_pf_fix_direct_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	 *
 	 * Compare with set_spte where instead shadow_dirty_mask is set.
 	 */
-	if (cmpxchg64(sptep, spte, spte | PT_WRITABLE_MASK) == spte)
+	if (try_cmpxchg(sptep, spte, spte | PT_WRITABLE_MASK))
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 
 	return true;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index bc019f70e0b6..a6464caa9c1a 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -45,9 +45,7 @@ extern u64 __pure __using_nonexistent_pte_bit(void)
 	#define PT_GUEST_ACCESSED_SHIFT PT_ACCESSED_SHIFT
 	#ifdef CONFIG_X86_64
 	#define PT_MAX_FULL_LEVELS 4
-	#define CMPXCHG cmpxchg
 	#else
-	#define CMPXCHG cmpxchg64
 	#define PT_MAX_FULL_LEVELS 2
 	#endif
 #elif PTTYPE == 32
@@ -64,7 +62,6 @@ extern u64 __pure __using_nonexistent_pte_bit(void)
 	#define PT_GUEST_DIRTY_MASK PT_DIRTY_MASK
 	#define PT_GUEST_DIRTY_SHIFT PT_DIRTY_SHIFT
 	#define PT_GUEST_ACCESSED_SHIFT PT_ACCESSED_SHIFT
-	#define CMPXCHG cmpxchg
 #elif PTTYPE == PTTYPE_EPT
 	#define pt_element_t u64
 	#define guest_walker guest_walkerEPT
@@ -78,7 +75,6 @@ extern u64 __pure __using_nonexistent_pte_bit(void)
 	#define PT_GUEST_DIRTY_MASK 0
 	#define PT_GUEST_DIRTY_SHIFT __using_nonexistent_pte_bit()
 	#define PT_GUEST_ACCESSED_SHIFT __using_nonexistent_pte_bit()
-	#define CMPXCHG cmpxchg64
 	#define PT_MAX_FULL_LEVELS 4
 #else
 	#error Invalid PTTYPE value
@@ -142,7 +138,7 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			       pt_element_t orig_pte, pt_element_t new_pte)
 {
 	int npages;
-	pt_element_t ret;
+	bool ret;
 	pt_element_t *table;
 	struct page *page;
 
@@ -152,12 +148,12 @@ static int FNAME(cmpxchg_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		return -EFAULT;
 
 	table = kmap_atomic(page);
-	ret = CMPXCHG(&table[index], orig_pte, new_pte);
+	ret = try_cmpxchg(&table[index], orig_pte, new_pte);
 	kunmap_atomic(table);
 
 	kvm_release_page_dirty(page);
 
-	return (ret != orig_pte);
+	return ret;
 }
 
 static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
@@ -1014,7 +1010,6 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 #undef PT_MAX_FULL_LEVELS
 #undef gpte_to_gfn
 #undef gpte_to_gfn_lvl
-#undef CMPXCHG
 #undef PT_GUEST_ACCESSED_MASK
 #undef PT_GUEST_DIRTY_MASK
 #undef PT_GUEST_DIRTY_SHIFT
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 133679d520af..5dd5e3148a9d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2075,8 +2075,9 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		!irq_remapping_cap(IRQ_POSTING_CAP))
 		return;
 
+	old.control = pi_desc->control;
 	do {
-		old.control = new.control = pi_desc->control;
+		new.control = old.control;
 
 		/*
 		 * If 'nv' field is POSTED_INTR_WAKEUP_VECTOR, there
@@ -2108,8 +2109,8 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 		/* Allow posting non-urgent interrupts */
 		new.sn = 0;
-	} while (cmpxchg(&pi_desc->control, old.control,
-			new.control) != old.control);
+	} while (!cmpxchg_return(&pi_desc->control, old.control,
+				 new.control, &old.control));
 }
 
 /*
@@ -10714,8 +10715,9 @@ static int vmx_pre_block(struct kvm_vcpu *vcpu)
 	spin_unlock_irqrestore(&per_cpu(blocked_vcpu_on_cpu_lock,
 			       vcpu->pre_pcpu), flags);
 
+	old.control = pi_desc->control;
 	do {
-		old.control = new.control = pi_desc->control;
+		new.control = old.control;
 
 		/*
 		 * We should not block the vCPU if
@@ -10754,8 +10756,8 @@ static int vmx_pre_block(struct kvm_vcpu *vcpu)
 
 		/* set 'NV' to 'wakeup vector' */
 		new.nv = POSTED_INTR_WAKEUP_VECTOR;
-	} while (cmpxchg(&pi_desc->control, old.control,
-			new.control) != old.control);
+	} while (!cmpxchg_return(&pi_desc->control, old.control,
+				 new.control, &old.control));
 
 	return 0;
 }
@@ -10771,8 +10773,9 @@ static void vmx_post_block(struct kvm_vcpu *vcpu)
 		!irq_remapping_cap(IRQ_POSTING_CAP))
 		return;
 
+	old.control = pi_desc->control;
 	do {
-		old.control = new.control = pi_desc->control;
+		new.control = old.control;
 
 		dest = cpu_physical_id(vcpu->cpu);
 
@@ -10786,8 +10789,8 @@ static void vmx_post_block(struct kvm_vcpu *vcpu)
 
 		/* set 'NV' to 'notification vector' */
 		new.nv = POSTED_INTR_VECTOR;
-	} while (cmpxchg(&pi_desc->control, old.control,
-			new.control) != old.control);
+	} while (!cmpxchg_return(&pi_desc->control, old.control,
+				 new.control, &old.control));
 
 	if(vcpu->pre_pcpu != -1) {
 		spin_lock_irqsave(
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9b7798c7b210..6ef2f31361f2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4560,15 +4560,8 @@ static int emulator_write_emulated(struct x86_emulate_ctxt *ctxt,
 				   exception, &write_emultor);
 }
 
-#define CMPXCHG_TYPE(t, ptr, old, new) \
-	(cmpxchg((t *)(ptr), *(t *)(old), *(t *)(new)) == *(t *)(old))
-
-#ifdef CONFIG_X86_64
-#  define CMPXCHG64(ptr, old, new) CMPXCHG_TYPE(u64, ptr, old, new)
-#else
-#  define CMPXCHG64(ptr, old, new) \
-	(cmpxchg64((u64 *)(ptr), *(u64 *)(old), *(u64 *)(new)) == *(u64 *)(old))
-#endif
+#define TRY_CMPXCHG_TYPE(t, ptr, old, new)			\
+	(try_cmpxchg((t *)(ptr), *(t *)(old), *(t *)(new)))
 
 static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 				     unsigned long addr,
@@ -4604,16 +4597,16 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
 	kaddr += offset_in_page(gpa);
 	switch (bytes) {
 	case 1:
-		exchanged = CMPXCHG_TYPE(u8, kaddr, old, new);
+		exchanged = TRY_CMPXCHG_TYPE(u8, kaddr, old, new);
 		break;
 	case 2:
-		exchanged = CMPXCHG_TYPE(u16, kaddr, old, new);
+		exchanged = TRY_CMPXCHG_TYPE(u16, kaddr, old, new);
 		break;
 	case 4:
-		exchanged = CMPXCHG_TYPE(u32, kaddr, old, new);
+		exchanged = TRY_CMPXCHG_TYPE(u32, kaddr, old, new);
 		break;
 	case 8:
-		exchanged = CMPXCHG64(kaddr, old, new);
+		exchanged = TRY_CMPXCHG_TYPE(u64, kaddr, old, new);
 		break;
 	default:
 		BUG();
diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index faec01e7a17d..bfd2455f4333 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -130,7 +130,7 @@ static inline void set_page_memtype(struct page *pg,
 	do {
 		old_flags = pg->flags;
 		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
-	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
+	} while (!cmpxchg_return(&pg->flags, old_flags, new_flags, &old_flags));
 }
 #else
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index cab9f766bb06..b968da72e027 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -575,8 +575,7 @@ int xen_alloc_p2m_entry(unsigned long pfn)
 
 			missing_mfn = virt_to_mfn(p2m_mid_missing_mfn);
 			mid_mfn_mfn = virt_to_mfn(mid_mfn);
-			old_mfn = cmpxchg(top_mfn_p, missing_mfn, mid_mfn_mfn);
-			if (old_mfn != missing_mfn) {
+			if (!cmpxchg_return(top_mfn_p, missing_mfn, mid_mfn_mfn, &old_mfn) {
 				free_p2m_page(mid_mfn);
 				mid_mfn = mfn_to_virt(old_mfn);
 			} else {
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index f42e78de1e10..e76d96499057 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -96,12 +96,10 @@ static u8 zero_stats;
 
 static inline void check_zero(void)
 {
-	u8 ret;
 	u8 old = READ_ONCE(zero_stats);
 	if (unlikely(old)) {
-		ret = cmpxchg(&zero_stats, old, 0);
-		/* This ensures only one fellow resets the stat */
-		if (ret == old)
+		if (try_cmpxchg(&zero_stats, old, 0))
+			/* This ensures only one fellow resets the stat */
 			memset(&spinlock_stats, 0, sizeof(spinlock_stats));
 	}
 }
