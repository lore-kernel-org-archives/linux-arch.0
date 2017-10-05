From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Date: Thu, 5 Oct 2017 12:22:28 -0700
Message-ID: <20171005192228.GU3521@linux.vnet.ibm.com>
References: <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
 <20170928084535.GA19060@arm.com>
 <20170928154354.GK3521@linux.vnet.ibm.com>
 <20170928185909.kgwy36hkoqxqgyc3@tower>
 <20170929005830.GU3521@linux.vnet.ibm.com>
 <20170929090843.GB14791@arm.com>
 <20170929162939.GY3521@linux.vnet.ibm.com>
 <20170929163348.GD2376@arm.com>
 <20171003191109.GB3521@linux.vnet.ibm.com>
 <20171005163154.GH11088@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751766AbdJETWf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2017 15:22:35 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v95JJHLv081115
        for <linux-arch@vger.kernel.org>; Thu, 5 Oct 2017 15:22:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ddqv922d5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 05 Oct 2017 15:22:34 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 5 Oct 2017 15:22:33 -0400
Content-Disposition: inline
In-Reply-To: <20171005163154.GH11088@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Michael Cree <mcree@orcon.net.nz>, Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, linux-alpha@vger.kernel.org

On Thu, Oct 05, 2017 at 05:31:54PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Tue, Oct 03, 2017 at 12:11:10PM -0700, Paul E. McKenney wrote:
> > On Fri, Sep 29, 2017 at 05:33:49PM +0100, Will Deacon wrote:
> > > On Fri, Sep 29, 2017 at 09:29:39AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Sep 29, 2017 at 10:08:43AM +0100, Will Deacon wrote:
> > > > > Ok, but where does that leave us wrt my initial proposal of moving
> > > > > smp_read_barrier_depends() into READ_ONCE and getting rid of
> > > > > lockless_dereference?
> > > > > 
> > > > > Michael (or anybody else running mainline on SMP Alpha) -- would you be
> > > > > able to give the diff below a spin and see whether there's a measurable
> > > > > performance impact?
> > > > 
> > > > This will be a sensitive test.  The smp_read_barrier_depends() can be
> > > > removed from lockless_dereference().  Without this removal Alpha will
> > > > get two memory barriers from rcu_dereference() and friends.
> > > 
> > > Oh yes, good point. I was trying to keep the diff simple, but you're
> > > right that this is packing too many barriers. Fixed diff below.
> > 
> > Not seeing any objections thus far.  If there are none by (say) the
> > end of this week, I would be happy to queue a patch for the 4.16
> > merge window.  That should give ample opportunity for further review
> > and testing.
> 
> Ok, full patch below.

Very good, applied for testing and review.  I did have to adjust context
a bit for other -rcu commits, and the result is below.  (Removed a single
"*" in a comment.)

							Thanx, Paul

------------------------------------------------------------------------

commit 7e3675cc18bbf4d84f60bfc02ff563ae3764ad35
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Oct 5 17:31:54 2017 +0100

    locking/barriers: Kill lockless_dereference
    
    lockless_dereference is a nice idea, but it's gained little traction in
    kernel code since it's introduction three years ago. This is partly
    because it's a pain to type, but also because using READ_ONCE instead
    will work correctly on all architectures apart from Alpha, which is a
    fully supported but somewhat niche architecture these days.
    
    This patch moves smp_read_barrier_depends() (a NOP on all architectures
    other than Alpha) from lockless_dereference into READ_ONCE, converts
    the few actual users over to READ_ONCE and then finally removes
    lockless_dereference altogether.
    
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 519940ec767f..479ecec80593 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1880,18 +1880,6 @@ There are some more advanced barrier functions:
      See Documentation/atomic_{t,bitops}.txt for more information.
 
 
- (*) lockless_dereference();
-
-     This can be thought of as a pointer-fetch wrapper around the
-     smp_read_barrier_depends() data-dependency barrier.
-
-     This is also similar to rcu_dereference(), but in cases where
-     object lifetime is handled by some mechanism other than RCU, for
-     example, when the objects removed only when the system goes down.
-     In addition, lockless_dereference() is used in some data structures
-     that can be used both with and without RCU.
-
-
  (*) dma_wmb();
  (*) dma_rmb();
 
diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index a7a813258013..ec3b46e27b7a 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1858,18 +1858,6 @@ Mandatory 배리어들은 SMP 시스템에서도 UP 시스템에서도 SMP 효
      참고하세요.
 
 
- (*) lockless_dereference();
-
-     이 함수는 smp_read_barrier_depends() 데이터 의존성 배리어를 사용하는
-     포인터 읽어오기 래퍼(wrapper) 함수로 생각될 수 있습니다.
-
-     객체의 라이프타임이 RCU 외의 메커니즘으로 관리된다는 점을 제외하면
-     rcu_dereference() 와도 유사한데, 예를 들면 객체가 시스템이 꺼질 때에만
-     제거되는 경우 등입니다.  또한, lockless_dereference() 은 RCU 와 함께
-     사용될수도, RCU 없이 사용될 수도 있는 일부 데이터 구조에 사용되고
-     있습니다.
-
-
  (*) dma_wmb();
  (*) dma_rmb();
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 80534d3c2480..589af1eec7c1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2371,7 +2371,7 @@ static unsigned long get_segment_base(unsigned int segment)
 		struct ldt_struct *ldt;
 
 		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = lockless_dereference(current->active_mm->context.ldt);
+		ldt = READ_ONCE(current->active_mm->context.ldt);
 		if (!ldt || idx >= ldt->nr_entries)
 			return 0;
 
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index c120b5db178a..9037a4e546e8 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -72,8 +72,8 @@ static inline void load_mm_ldt(struct mm_struct *mm)
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct ldt_struct *ldt;
 
-	/* lockless_dereference synchronizes with smp_store_release */
-	ldt = lockless_dereference(mm->context.ldt);
+	/* READ_ONCE synchronizes with smp_store_release */
+	ldt = READ_ONCE(mm->context.ldt);
 
 	/*
 	 * Any change to mm->context.ldt is followed by an IPI to all
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index f0e64db18ac8..0a21390642c4 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -101,7 +101,7 @@ static void finalize_ldt_struct(struct ldt_struct *ldt)
 static void install_ldt(struct mm_struct *current_mm,
 			struct ldt_struct *ldt)
 {
-	/* Synchronizes with lockless_dereference in load_mm_ldt. */
+	/* Synchronizes with READ_ONCE in load_mm_ldt. */
 	smp_store_release(&current_mm->context.ldt, ldt);
 
 	/* Activate the LDT for all CPUs using current_mm. */
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 11f273d2f018..3f88c9d32f7e 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -366,7 +366,7 @@ static struct pgpath *choose_path_in_pg(struct multipath *m,
 
 	pgpath = path_to_pgpath(path);
 
-	if (unlikely(lockless_dereference(m->current_pg) != pg)) {
+	if (unlikely(READ_ONCE(m->current_pg) != pg)) {
 		/* Only update current_pgpath if pg changed */
 		spin_lock_irqsave(&m->lock, flags);
 		m->current_pgpath = pgpath;
@@ -390,7 +390,7 @@ static struct pgpath *choose_pgpath(struct multipath *m, size_t nr_bytes)
 	}
 
 	/* Were we instructed to switch PG? */
-	if (lockless_dereference(m->next_pg)) {
+	if (READ_ONCE(m->next_pg)) {
 		spin_lock_irqsave(&m->lock, flags);
 		pg = m->next_pg;
 		if (!pg) {
@@ -406,7 +406,7 @@ static struct pgpath *choose_pgpath(struct multipath *m, size_t nr_bytes)
 
 	/* Don't change PG until it has no remaining paths */
 check_current_pg:
-	pg = lockless_dereference(m->current_pg);
+	pg = READ_ONCE(m->current_pg);
 	if (pg) {
 		pgpath = choose_path_in_pg(m, pg, nr_bytes);
 		if (!IS_ERR_OR_NULL(pgpath))
@@ -473,7 +473,7 @@ static int multipath_clone_and_map(struct dm_target *ti, struct request *rq,
 	struct request *clone;
 
 	/* Do we need to select a new pgpath? */
-	pgpath = lockless_dereference(m->current_pgpath);
+	pgpath = READ_ONCE(m->current_pgpath);
 	if (!pgpath || !test_bit(MPATHF_QUEUE_IO, &m->flags))
 		pgpath = choose_pgpath(m, nr_bytes);
 
@@ -535,7 +535,7 @@ static int __multipath_map_bio(struct multipath *m, struct bio *bio, struct dm_m
 	bool queue_io;
 
 	/* Do we need to select a new pgpath? */
-	pgpath = lockless_dereference(m->current_pgpath);
+	pgpath = READ_ONCE(m->current_pgpath);
 	queue_io = test_bit(MPATHF_QUEUE_IO, &m->flags);
 	if (!pgpath || !queue_io)
 		pgpath = choose_pgpath(m, nr_bytes);
@@ -1804,7 +1804,7 @@ static int multipath_prepare_ioctl(struct dm_target *ti,
 	struct pgpath *current_pgpath;
 	int r;
 
-	current_pgpath = lockless_dereference(m->current_pgpath);
+	current_pgpath = READ_ONCE(m->current_pgpath);
 	if (!current_pgpath)
 		current_pgpath = choose_pgpath(m, 0);
 
@@ -1826,7 +1826,7 @@ static int multipath_prepare_ioctl(struct dm_target *ti,
 	}
 
 	if (r == -ENOTCONN) {
-		if (!lockless_dereference(m->current_pg)) {
+		if (!READ_ONCE(m->current_pg)) {
 			/* Path status changed, redo selection */
 			(void) choose_pgpath(m, 0);
 		}
@@ -1895,9 +1895,9 @@ static int multipath_busy(struct dm_target *ti)
 		return (m->queue_mode != DM_TYPE_MQ_REQUEST_BASED);
 
 	/* Guess which priority_group will be used at next mapping time */
-	pg = lockless_dereference(m->current_pg);
-	next_pg = lockless_dereference(m->next_pg);
-	if (unlikely(!lockless_dereference(m->current_pgpath) && next_pg))
+	pg = READ_ONCE(m->current_pg);
+	next_pg = READ_ONCE(m->next_pg);
+	if (unlikely(!READ_ONCE(m->current_pgpath) && next_pg))
 		pg = next_pg;
 
 	if (!pg) {
diff --git a/fs/dcache.c b/fs/dcache.c
index f90141387f01..34c852af215c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -231,7 +231,7 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 {
 	/*
 	 * Be careful about RCU walk racing with rename:
-	 * use 'lockless_dereference' to fetch the name pointer.
+	 * use 'READ_ONCE' to fetch the name pointer.
 	 *
 	 * NOTE! Even if a rename will mean that the length
 	 * was not loaded atomically, we don't care. The
@@ -245,7 +245,7 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 	 * early because the data cannot match (there can
 	 * be no NUL in the ct/tcount data)
 	 */
-	const unsigned char *cs = lockless_dereference(dentry->d_name.name);
+	const unsigned char *cs = READ_ONCE(dentry->d_name.name);
 
 	return dentry_string_cmp(cs, ct, tcount);
 }
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 878a750986dd..0f6809fa6628 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -74,5 +74,5 @@ static inline struct ovl_inode *OVL_I(struct inode *inode)
 
 static inline struct dentry *ovl_upperdentry_dereference(struct ovl_inode *oi)
 {
-	return lockless_dereference(oi->__upperdentry);
+	return READ_ONCE(oi->__upperdentry);
 }
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 62e9b22a2077..0b389d330613 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -754,7 +754,7 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (!od->is_upper && OVL_TYPE_UPPER(ovl_path_type(dentry))) {
 		struct inode *inode = file_inode(file);
 
-		realfile = lockless_dereference(od->upperfile);
+		realfile = READ_ONCE(od->upperfile);
 		if (!realfile) {
 			struct path upperpath;
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index e95a2631e545..f260ff39f90f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -340,6 +340,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 		__read_once_size(&(x), __u.__c, sizeof(x));		\
 	else								\
 		__read_once_size_nocheck(&(x), __u.__c, sizeof(x));	\
+	smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
 	__u.__val;							\
 })
 #define READ_ONCE(x) __READ_ONCE(x, 1)
@@ -604,24 +605,4 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	(volatile typeof(x) *)&(x); })
 #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
 
-/**
- * lockless_dereference() - safely load a pointer for later dereference
- * @p: The pointer to load
- *
- * Similar to rcu_dereference(), but for situations where the pointed-to
- * object's lifetime is managed by something other than RCU.  That
- * "something other" might be reference counting or simple immortality.
- *
- * The seemingly unused variable ___typecheck_p validates that @p is
- * indeed a pointer type by using a pointer to typeof(*p) as the type.
- * Taking a pointer to typeof(*p) again is needed in case p is void *.
- */
-#define lockless_dereference(p) \
-({ \
-	typeof(p) _________p1 = READ_ONCE(p); \
-	typeof(*(p)) *___typecheck_p __maybe_unused; \
-	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
-	(_________p1); \
-})
-
 #endif /* __LINUX_COMPILER_H */
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 2bea1d5e9930..5ed091c064b2 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -274,7 +274,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
  */
 #define list_entry_rcu(ptr, type, member) \
-	container_of(lockless_dereference(ptr), type, member)
+	container_of(READ_ONCE(ptr), type, member)
 
 /*
  * Where are list_empty_rcu() and list_first_entry_rcu()?
@@ -367,7 +367,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * example is when items are added to the list, but never deleted.
  */
 #define list_entry_lockless(ptr, type, member) \
-	container_of((typeof(ptr))lockless_dereference(ptr), type, member)
+	container_of((typeof(ptr))READ_ONCE(ptr), type, member)
 
 /**
  * list_for_each_entry_lockless - iterate over rcu list of given type
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1a9f70d44af9..a6ddc42f87a5 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -346,7 +346,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define __rcu_dereference_check(p, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(*p) *________p1 = (typeof(*p) *__force)lockless_dereference(p); \
+	typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
 	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
 	rcu_dereference_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(________p1)); \
@@ -360,7 +360,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_dereference_raw(p) \
 ({ \
 	/* Dependency order vs. p above. */ \
-	typeof(p) ________p1 = lockless_dereference(p); \
+	typeof(p) ________p1 = READ_ONCE(p); \
 	((typeof(*p) __force __kernel *)(________p1)); \
 })
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6bc21e202ae4..417812ce0099 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4231,7 +4231,7 @@ static void perf_remove_from_owner(struct perf_event *event)
 	 * indeed free this event, otherwise we need to serialize on
 	 * owner->perf_event_mutex.
 	 */
-	owner = lockless_dereference(event->owner);
+	owner = READ_ONCE(event->owner);
 	if (owner) {
 		/*
 		 * Since delayed_put_task_struct() also drops the last
@@ -4328,7 +4328,7 @@ int perf_event_release_kernel(struct perf_event *event)
 		 * Cannot change, child events are not migrated, see the
 		 * comment with perf_event_ctx_lock_nested().
 		 */
-		ctx = lockless_dereference(child->ctx);
+		ctx = READ_ONCE(child->ctx);
 		/*
 		 * Since child_mutex nests inside ctx::mutex, we must jump
 		 * through hoops. We start by grabbing a reference on the ctx.
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index bb3a38005b9c..1daa8b61a268 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -189,7 +189,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	u32 ret = SECCOMP_RET_ALLOW;
 	/* Make sure cross-thread synced filter points somewhere sane. */
 	struct seccomp_filter *f =
-			lockless_dereference(current->seccomp.filter);
+			READ_ONCE(current->seccomp.filter);
 
 	/* Ensure unexpected behavior doesn't result in failing open. */
 	if (unlikely(WARN_ON(f == NULL)))
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 836a72a66fba..9a9f262fc53d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -67,7 +67,7 @@ task_work_cancel(struct task_struct *task, task_work_func_t func)
 	 * we raced with task_work_run(), *pprev == NULL/exited.
 	 */
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
-	while ((work = lockless_dereference(*pprev))) {
+	while ((work = READ_ONCE(*pprev))) {
 		if (work->func != func)
 			pprev = &work->next;
 		else if (cmpxchg(pprev, work, work->next) == work)
diff --git a/mm/slab.h b/mm/slab.h
index 073362816acc..8894f811a89d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -258,7 +258,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int idx)
 	 * memcg_caches issues a write barrier to match this (see
 	 * memcg_create_kmem_cache()).
 	 */
-	cachep = lockless_dereference(arr->entries[idx]);
+	cachep = READ_ONCE(arr->entries[idx]);
 	rcu_read_unlock();
 
 	return cachep;
