Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:38468 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960AbXKTQCW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Nov 2007 11:02:22 -0500
Date: Tue, 20 Nov 2007 17:02:20 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071120160220.GA22196@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

Hi,

The mmiowb() barrier isn't very well documented, and it is somewhat difficult
to understand exactly how it is supposed to work (both for users and
implementers).

I guess it came about because sn2 has MMIO which is highly out of order with
respect to regular cacheable operations, and apparently found it too expensive
to implement the full barriers (eg. wmb()) completely, so they quietly relaxed
them, and introduce mmiowb().

The argument that this semantic for wmb is OK, is that the entity reordering
the IOs is actually another agent than the CPU issuing the barriers, so it is
exempt from having to be ordered. I don't really like this argument -- the
point of having the barriers is not because a driver writer wants some specific
bit of silicon to perform some specific ordering, but for the high level
load/store operations to be ordered.

A powerpc sync instruction on some pSeries apparently has to travel around the
interconnect ring before it can complete, so I don't see why the sn2 case is
more special (sn2 has to effectively flush a reorder buffer in its chipset,
not exactly a big surprise if one requires ordering of those IOs...).

sn2 _somewhat_ is able to get away with its breakage of wmb() -- it doesn't
order cacheable vs mmio even on a single CPU -- because it is not so common to
be used for that (usually it is just used for io vs io). However that isn't
a good reason to change semantics of a lot of existing code in a subtle way,
while also introducing a new type of barrier. It's plainly already hard enough
to comprehend and implement memory ordering.

IMO, a better way to fix this is to recognise that many wmb()s don't need the
full semantics. So introduce a new variant of the existing, understood, memory
barrier set -- the io_*mb(). This just orders io vs io. These barriers can be
taken advantage of my more code and more architectures. wmb() semantics don't
need to be changed. No new memory ordering concepts for driver writers to
learn.

The other thing I've tried to do is add a primitive for IO critical sections as
well. Don't know what people think about this, but I think it is better than
asking driver writers to explicitly think about the memory ordering required to
order their IO operations with those involved in the SMP lock and unlock
operations.

This is an RFC. I've written some documentation, converted some architectures,
and converted a couple of drivers (many seem to be a bit confused about mmiowb)

Index: linux-2.6/Documentation/memory-barriers.txt
===================================================================
--- linux-2.6.orig/Documentation/memory-barriers.txt
+++ linux-2.6/Documentation/memory-barriers.txt
@@ -986,30 +986,55 @@ CPU MEMORY BARRIERS
 
 The Linux kernel has eight basic CPU memory barriers:
 
-	TYPE		MANDATORY		SMP CONDITIONAL
-	===============	=======================	===========================
-	GENERAL		mb()			smp_mb()
-	WRITE		wmb()			smp_wmb()
-	READ		rmb()			smp_rmb()
-	DATA DEPENDENCY	read_barrier_depends()	smp_read_barrier_depends()
+ TYPE	    FULL		    CACHEABLE (SMP CONDITIONAL) IO
+ =========  ======================= =========================== ============
+ GENERAL    mb()		    smp_mb()			io_mb()
+ WRITE	    wmb()		    smp_wmb()			io_wmb()
+ READ	    rmb()		    smp_rmb()			io_rmb()
+ DATA DEP.  read_barrier_depends()  smp_read_barrier_depends()
+ LOCK	    io_lock()
+ UNLOCK	    io_unlock()
 
 
 All CPU memory barriers unconditionally imply compiler barriers.
 
-SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
-systems because it is assumed that a CPU will appear to be self-consistent,
-and will order overlapping accesses correctly with respect to itself.
-
-[!] Note that SMP memory barriers _must_ be used to control the ordering of
-references to shared memory on SMP systems, though the use of locking instead
-is sufficient.
-
-Mandatory barriers should not be used to control SMP effects, since mandatory
-barriers unnecessarily impose overhead on UP systems. They may, however, be
-used to control MMIO effects on accesses through relaxed memory I/O windows.
-These are required even on non-SMP systems as they affect the order in which
-memory operations appear to a device by prohibiting both the compiler and the
-CPU from reordering them.
+CACHEABLE memory barriers control order of access to regular (cacheable) RAM
+by the CPU.  They are reduced to compiler barriers on uniprocessor compiled
+systems because cacheable memory is operated upon by CPUs, and a a CPU is
+self-consistent.
+
+[!] Note that CACHEABLE or FULL memory barriers must be used to control the
+ordering of references to shared memory on SMP systems, though the use of
+locking instead is sufficient.
+
+IO memory barriers should be used to control the order of memory operations
+from the CPU to IO memory (memory mapped devices; uncacheable, write combining,
+etc). Some of the architectures that Linux supports can reorder these accesses
+can be reordered even on UP systems, so they can not be eliminated on UP
+machines.  They may also involve different instructions than CACHEABLE memory
+barriers.
+
+FULL barriers order all memory operations to both CACHEABLE and IO memory.
+These should be used specifically when ordering is required between loads
+and/or stores to CACHEABLE, and loads/stores to IO memory.  FULL barriers
+should not be used to control only the ordering of operations to CACHEABLE
+memory, nor only operations to IO memory, since they unnecessarily impose
+overhead on UP systems.
+
+One of the most important special case of FULL barrier are the lock and unlock
+barriers.  These barriers must be combined with smp locking primitives (eg.
+spin_lock/unlock, mutex_lock/unlock), and act to contain IO memory operations
+within the critical section (normally, locking primitives only contain
+CACHEABLE accesses within the critical section). io_lock must be called
+after taking the SMP lock, and io_unlock before releasing it. It is strongly
+encouraged to make these calls *directly* after/before the SMP locks. Do not
+get smart. These are classified as FULL barriers, because they serve to order
+IO accesses with the CACHEABLE accesses involved in taking and releasing SMP
+locks. However they are prefixed with io_, which is more intuitive.
+
+All barriers are required even on non-SMP systems as they affect the order in
+which memory operations appear to a device by prohibiting both the compiler and
+(in the case of IO and FULL barriers) the CPU from reordering them.
 
 
 There are some more advanced barrier functions:
@@ -1065,21 +1090,6 @@ There are some more advanced barrier fun
      operations" subsection for information on where to use these.
 
 
-MMIO WRITE BARRIER
-------------------
-
-The Linux kernel also has a special barrier for use with memory-mapped I/O
-writes:
-
-	mmiowb();
-
-This is a variation on the mandatory write barrier that causes writes to weakly
-ordered I/O regions to be partially ordered.  Its effects may go beyond the
-CPU->Hardware interface and actually affect the hardware at some level.
-
-See the subsection "Locks vs I/O accesses" for more information.
-
-
 ===============================
 IMPLICIT KERNEL MEMORY BARRIERS
 ===============================
@@ -1285,22 +1295,23 @@ But assuming CPU 1 gets the lock first, 
 LOCKS VS I/O ACCESSES
 ---------------------
 
-Under certain circumstances (especially involving NUMA), I/O accesses within
-two spinlocked sections on two different CPUs may be seen as interleaved by the
-PCI bridge, because the PCI bridge does not necessarily participate in the
-cache-coherence protocol, and is therefore incapable of issuing the required
-read memory barriers.
+SMP locking primitives are implemented with operations to CACHEABLE memory,
+and they are guaranteed only to provide LOCK and UNLOCK ordering for other
+CACHEABLE memory accesses inside the critical section. IO memory accesses,
+even if performed inside the lock section, can "leak out".
 
 For example:
 
 	CPU 1				CPU 2
 	===============================	===============================
 	spin_lock(Q)
-	writel(0, ADDR)
+	writel(0, ADDR);
+	io_wmb();
 	writel(1, DATA);
 	spin_unlock(Q);
 					spin_lock(Q);
 					writel(4, ADDR);
+					io_wmb();
 					writel(5, DATA);
 					spin_unlock(Q);
 
@@ -1308,29 +1319,39 @@ may be seen by the PCI bridge as follows
 
 	STORE *ADDR = 0, STORE *ADDR = 4, STORE *DATA = 1, STORE *DATA = 5
 
-which would probably cause the hardware to malfunction.
-
-
-What is necessary here is to intervene with an mmiowb() before dropping the
-spinlock, for example:
+which would probably cause the hardware to malfunction. The reason is that
+the stores to IO memory from CPU 1 is not ordered with respect to the
+spin_unlock, so it may not be visible to the PCI bridge before the spin_unlock
+is visible to CPU 2. CPU2 then acquires the lock and executes an IO store,
+which happens to pass the IO store from CPU 1.
+
+What is necessary here is to use some type of FULL memory barrier to prevent
+the reordering of CACHEABLE and IO operations. The best way to do this is with
+io_lock and io_unlock barriers, which directs the critical section to order
+IO access as well. For example:
 
 	CPU 1				CPU 2
 	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
+	spin_lock(Q);
+	io_lock();
+	writel(0, ADDR);
+	io_wmb();
 	writel(1, DATA);
-	mmiowb();
+	io_unlock();
 	spin_unlock(Q);
 					spin_lock(Q);
+					io_lock();
 					writel(4, ADDR);
+					io_wmb();
 					writel(5, DATA);
-					mmiowb();
+					io_unlock();
 					spin_unlock(Q);
 
-this will ensure that the two stores issued on CPU 1 appear at the PCI bridge
-before either of the stores issued on CPU 2.
+this will ensure that the two IO stores issued on CPU 1 appear at the PCI
+bridge before either of the IO stores issued on CPU 2.
 
 
+XXX: get rid of this, and just prefer io_lock()/io_unlock() ?
 Furthermore, following a store by a load from the same device obviates the need
 for the mmiowb(), because the load forces the store to complete before the load
 is performed:
@@ -1346,6 +1367,13 @@ is performed:
 					b = readl(DATA);
 					spin_unlock(Q);
 
+XXX: However, in this case, it may still be possible for the IO stores to pass
+the CACHEABLE operations involved in _taking_ the lock (the IO load only
+prevents the writel leaking out)... however: does this really work for all
+IO memory types? Does it prevent the spin_unlock store from being executed
+before the readl?
+
+
 
 See Documentation/DocBook/deviceiobook.tmpl for more information.
 
@@ -1578,8 +1606,8 @@ use of memory barriers unnecessary, ther
 might be needed:
 
  (1) On some systems, I/O stores are not strongly ordered across all CPUs, and
-     so for _all_ general drivers locks should be used and mmiowb() must be
-     issued prior to unlocking the critical section.
+     so for _all_ general drivers locks should be used and io_lock/io_unlock
+     must be issued inside the critical section.
 
  (2) If the accessor functions are used to refer to an I/O memory window with
      relaxed memory access properties, then _mandatory_ memory barriers are
@@ -1628,8 +1656,9 @@ explicit barriers are used.
 
 Normally this won't be a problem because the I/O accesses done inside such
 sections will include synchronous load operations on strictly ordered I/O
-registers that form implicit I/O barriers. If this isn't sufficient then an
-mmiowb() may need to be used explicitly.
+registers that form implicit I/O barriers. If this isn't sufficient then
+interrupt-safe locks should be used, along with io_lock and io_unlock
+barriers.
 
 
 A similar situation may occur between an interrupt routine and two routines
@@ -1686,9 +1715,6 @@ functions:
      	 cause a malfunction - consider the 16550 Rx/Tx serial registers for
      	 example.
 
-     Used with prefetchable I/O memory, an mmiowb() barrier may be required to
-     force stores to be ordered.
-
      Please refer to the PCI specification for more information on interactions
      between PCI transactions.
 
Index: linux-2.6/arch/ia64/sn/kernel/iomv.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/iomv.c
+++ linux-2.6/arch/ia64/sn/kernel/iomv.c
@@ -69,6 +69,7 @@ EXPORT_SYMBOL(sn_io_addr);
  * On SN2, we wait for the PIO_WRITE_STATUS SHub register to clear.
  * See PV 871084 for details about the WAR about zero value.
  *
+ * XXX: do we also need an mf.a, or does the *adr load order for us?
  */
 void __sn_mmiowb(void)
 {
Index: linux-2.6/include/asm-ia64/system.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/system.h
+++ linux-2.6/include/asm-ia64/system.h
@@ -87,6 +87,9 @@ extern struct ia64_boot_param {
 #define wmb()	mb()
 #define read_barrier_depends()	do { } while(0)
 
+#define io_lock()	do { } while (0)
+#define io_unlock()	mmiowb()
+
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
 # define smp_rmb()	rmb()
@@ -99,6 +102,10 @@ extern struct ia64_boot_param {
 # define smp_read_barrier_depends()	do { } while(0)
 #endif
 
+#define io_mb()		mb()
+#define io_rmb()	rmb()
+#define io_wmb()	wmb()
+
 /*
  * XXX check on this ---I suspect what Linus really wants here is
  * acquire vs release semantics but we can't discuss this stuff with
Index: linux-2.6/include/asm-powerpc/system.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/system.h
+++ linux-2.6/include/asm-powerpc/system.h
@@ -33,8 +33,15 @@
  * SMP since it is only used to order updates to system memory.
  */
 #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ (__stringify(LWSYNC) : : : "memory")
+#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
+
+#define io_lock()  do { } while (0)
+#define io_unlock()			\
+do {					\
+	get_paca()->io_sync = 0;	\
+	mb();				\
+}
 #define read_barrier_depends()  do { } while(0)
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
@@ -43,7 +50,7 @@
 #define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
-#define smp_rmb()	rmb()
+#define smp_rmb()	__asm__ __volatile__ (__stringify(LWSYNC) : : :"memory")
 #define smp_wmb()	eieio()
 #define smp_read_barrier_depends()	read_barrier_depends()
 #else
@@ -53,6 +60,10 @@
 #define smp_read_barrier_depends()	do { } while(0)
 #endif /* CONFIG_SMP */
 
+#define io_mb()		mb()
+#define io_rmb()	mb()
+#define io_wmb()	eieio()
+
 /*
  * This is a barrier which prevents following instructions from being
  * started until the value of the argument x is known.  For example, if
Index: linux-2.6/include/asm-x86/system_32.h
===================================================================
--- linux-2.6.orig/include/asm-x86/system_32.h
+++ linux-2.6/include/asm-x86/system_32.h
@@ -223,6 +223,9 @@ static inline unsigned long get_limit(un
 #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
 #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 
+#define io_lock()	do { } while (0)
+#define io_unlock()	mb()
+
 /**
  * read_barrier_depends - Flush all pending reads that subsequents reads
  * depend on.
@@ -299,6 +302,10 @@ static inline unsigned long get_limit(un
 #define set_mb(var, value) do { var = value; barrier(); } while (0)
 #endif
 
+#define io_mb()		mb()
+#define io_rmb()	rmb()
+#define io_wmb()	wmb()
+
 #include <linux/irqflags.h>
 
 /*
Index: linux-2.6/include/asm-x86/system_64.h
===================================================================
--- linux-2.6.orig/include/asm-x86/system_64.h
+++ linux-2.6/include/asm-x86/system_64.h
@@ -153,6 +153,9 @@ static inline void clflush(volatile void
 #define smp_read_barrier_depends()	do {} while(0)
 #endif
 
+#define io_mb()		mb()
+#define io_rmb()	rmb()
+#define io_wmb()	wmb()
     
 /*
  * Force strict CPU ordering.
@@ -163,6 +166,10 @@ static inline void clflush(volatile void
 #define rmb()	asm volatile("lfence":::"memory")
 #define wmb()	asm volatile("sfence" ::: "memory")
 
+#define io_lock()	do { } while (0)
+#define io_unlock()	mb()
+
+
 #define read_barrier_depends()	do {} while(0)
 #define set_mb(var, value) do { (void) xchg(&var, value); } while (0)
 
Index: linux-2.6/drivers/net/wireless/b43/main.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/main.c
+++ linux-2.6/drivers/net/wireless/b43/main.c
@@ -265,7 +265,7 @@ static void b43_ram_write(struct b43_wld
 		val = swab32(val);
 
 	b43_write32(dev, B43_MMIO_RAM_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43_write32(dev, B43_MMIO_RAM_DATA, val);
 }
 
@@ -334,19 +334,19 @@ void b43_shm_write32(struct b43_wldev *d
 		if (offset & 0x0003) {
 			/* Unaligned access */
 			b43_shm_control_word(dev, routing, offset >> 2);
-			mmiowb();
+			io_wmb();
 			b43_write16(dev, B43_MMIO_SHM_DATA_UNALIGNED,
 				    (value >> 16) & 0xffff);
-			mmiowb();
+			io_wmb();
 			b43_shm_control_word(dev, routing, (offset >> 2) + 1);
-			mmiowb();
+			io_wmb();
 			b43_write16(dev, B43_MMIO_SHM_DATA, value & 0xffff);
 			return;
 		}
 		offset >>= 2;
 	}
 	b43_shm_control_word(dev, routing, offset);
-	mmiowb();
+	io_wmb();
 	b43_write32(dev, B43_MMIO_SHM_DATA, value);
 }
 
@@ -357,14 +357,14 @@ void b43_shm_write16(struct b43_wldev *d
 		if (offset & 0x0003) {
 			/* Unaligned access */
 			b43_shm_control_word(dev, routing, offset >> 2);
-			mmiowb();
+			io_wmb();
 			b43_write16(dev, B43_MMIO_SHM_DATA_UNALIGNED, value);
 			return;
 		}
 		offset >>= 2;
 	}
 	b43_shm_control_word(dev, routing, offset);
-	mmiowb();
+	io_wmb();
 	b43_write16(dev, B43_MMIO_SHM_DATA, value);
 }
 
@@ -470,9 +470,9 @@ static void b43_tsf_write_locked(struct 
 		u32 hi = (tsf & 0xFFFFFFFF00000000ULL) >> 32;
 
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_LOW, 0);
-		mmiowb();
+		io_wmb();
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_HIGH, hi);
-		mmiowb();
+		io_wmb();
 		b43_write32(dev, B43_MMIO_REV3PLUS_TSF_LOW, lo);
 	} else {
 		u16 v0 = (tsf & 0x000000000000FFFFULL);
@@ -481,13 +481,13 @@ static void b43_tsf_write_locked(struct 
 		u16 v3 = (tsf & 0xFFFF000000000000ULL) >> 48;
 
 		b43_write16(dev, B43_MMIO_TSF_0, 0);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_3, v3);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_2, v2);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_1, v1);
-		mmiowb();
+		io_wmb();
 		b43_write16(dev, B43_MMIO_TSF_0, v0);
 	}
 }
@@ -1390,6 +1390,7 @@ static void b43_interrupt_tasklet(struct
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->wl->irq_lock, flags);
+	io_lock();
 
 	B43_WARN_ON(b43_status(dev) != B43_STAT_STARTED);
 
@@ -1415,7 +1416,7 @@ static void b43_interrupt_tasklet(struct
 			       dma_reason[2], dma_reason[3],
 			       dma_reason[4], dma_reason[5]);
 			b43_controller_restart(dev, "DMA error");
-			mmiowb();
+			io_unlock();
 			spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 			return;
 		}
@@ -1466,7 +1467,7 @@ static void b43_interrupt_tasklet(struct
 		handle_irq_transmit_status(dev);
 
 	b43_interrupt_enable(dev, dev->irq_savedstate);
-	mmiowb();
+	io_unlock();
 	spin_unlock_irqrestore(&dev->wl->irq_lock, flags);
 }
 
@@ -1514,6 +1515,7 @@ static irqreturn_t b43_interrupt_handler
 		return IRQ_NONE;
 
 	spin_lock(&dev->wl->irq_lock);
+	io_lock();
 
 	if (b43_status(dev) < B43_STAT_STARTED)
 		goto out;
@@ -1545,7 +1547,7 @@ static irqreturn_t b43_interrupt_handler
 	dev->irq_reason = reason;
 	tasklet_schedule(&dev->isr_tasklet);
       out:
-	mmiowb();
+	io_unlock();
 	spin_unlock(&dev->wl->irq_lock);
 
 	return ret;
@@ -2799,8 +2801,9 @@ static int b43_dev_config(struct ieee802
 	}
 
 	spin_lock_irqsave(&wl->irq_lock, flags);
+	io_lock();
 	b43_interrupt_enable(dev, savedirqs);
-	mmiowb();
+	io_unlock();
 	spin_unlock_irqrestore(&wl->irq_lock, flags);
       out_unlock_mutex:
 	mutex_unlock(&wl->mutex);
Index: linux-2.6/drivers/net/wireless/b43/phy.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/phy.c
+++ linux-2.6/drivers/net/wireless/b43/phy.c
@@ -299,7 +299,7 @@ void b43_phy_write(struct b43_wldev *dev
 
 	offset = adjust_phyreg_for_phytype(phy, offset, dev);
 	b43_write16(dev, B43_MMIO_PHY_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43_write16(dev, B43_MMIO_PHY_DATA, val);
 }
 
@@ -2472,7 +2472,7 @@ u16 b43_radio_read16(struct b43_wldev *d
 void b43_radio_write16(struct b43_wldev *dev, u16 offset, u16 val)
 {
 	b43_write16(dev, B43_MMIO_RADIO_CONTROL, offset);
-	mmiowb();
+	io_wmb();
 	b43_write16(dev, B43_MMIO_RADIO_DATA_LOW, val);
 }
 
@@ -2648,7 +2648,7 @@ u8 b43_radio_aci_scan(struct b43_wldev *
 void b43_nrssi_hw_write(struct b43_wldev *dev, u16 offset, s16 val)
 {
 	b43_phy_write(dev, B43_PHY_NRSSILT_CTRL, offset);
-	mmiowb();
+	io_wmb();
 	b43_phy_write(dev, B43_PHY_NRSSILT_DATA, (u16) val);
 }
 
Index: linux-2.6/drivers/net/wireless/b43/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/sysfs.c
+++ linux-2.6/drivers/net/wireless/b43/sysfs.c
@@ -139,13 +139,14 @@ static ssize_t b43_attr_interfmode_store
 
 	mutex_lock(&wldev->wl->mutex);
 	spin_lock_irqsave(&wldev->wl->irq_lock, flags);
+	io_lock();
 
 	err = b43_radio_set_interference_mitigation(wldev, mode);
 	if (err) {
 		b43err(wldev->wl, "Interference Mitigation not "
 		       "supported by device\n");
 	}
-	mmiowb();
+	io_unlock();
 	spin_unlock_irqrestore(&wldev->wl->irq_lock, flags);
 	mutex_unlock(&wldev->wl->mutex);
 
Index: linux-2.6/drivers/net/wireless/b43/pio.h
===================================================================
--- linux-2.6.orig/drivers/net/wireless/b43/pio.h
+++ linux-2.6/drivers/net/wireless/b43/pio.h
@@ -87,7 +87,7 @@ static inline
     void b43_pio_write(struct b43_pioqueue *queue, u16 offset, u16 value)
 {
 	b43_write16(queue->dev, queue->mmio_base + offset, value);
-	mmiowb();
+	io_wmb();
 }
 
 int b43_pio_init(struct b43_wldev *dev);
Index: linux-2.6/drivers/net/s2io.c
===================================================================
--- linux-2.6.orig/drivers/net/s2io.c
+++ linux-2.6/drivers/net/s2io.c
@@ -2446,7 +2446,7 @@ static int fill_rx_buffers(struct s2io_n
 			DBG_PRINT(INFO_DBG, "%s: Out of ", dev->name);
 			DBG_PRINT(INFO_DBG, "memory to allocate SKBs\n");
 			if (first_rxdp) {
-				wmb();
+				wmb(); /* io_wmb? */
 				first_rxdp->Control_1 |= RXD_OWN_XENA;
 			}
 			nic->mac_control.stats_info->sw_stat. \
@@ -2553,7 +2553,7 @@ static int fill_rx_buffers(struct s2io_n
 		rxdp->Control_2 |= SET_RXD_MARKER;
 		if (!(alloc_tab & ((1 << rxsync_frequency) - 1))) {
 			if (first_rxdp) {
-				wmb();
+				io_wmb();
 				first_rxdp->Control_1 |= RXD_OWN_XENA;
 			}
 			first_rxdp = rxdp;
@@ -2568,7 +2568,7 @@ static int fill_rx_buffers(struct s2io_n
 	 * and other fields are seen by adapter correctly.
 	 */
 	if (first_rxdp) {
-		wmb();
+		io_wmb();
 		first_rxdp->Control_1 |= RXD_OWN_XENA;
 	}
 
@@ -4081,7 +4081,7 @@ static int s2io_xmit(struct sk_buff *skb
 
 	writeq(val64, &tx_fifo->List_Control);
 
-	mmiowb();
+	wmb(); /* io_lock() / io_unock() ? */
 
 	put_off++;
 	if (put_off == mac_control->fifos[queue].tx_curr_put_info.fifo_len + 1)
@@ -6665,7 +6665,7 @@ static  int rxd_owner_bit_reset(struct s
 				}
 
 				set_rxd_buffer_size(sp, rxdp, size);
-				wmb();
+				io_wmb();
 				/* flip the Ownership bit to Hardware */
 				rxdp->Control_1 |= RXD_OWN_XENA;
 			}
Index: linux-2.6/drivers/misc/ioc4.c
===================================================================
--- linux-2.6.orig/drivers/misc/ioc4.c
+++ linux-2.6/drivers/misc/ioc4.c
@@ -156,7 +156,7 @@ ioc4_clock_calibrate(struct ioc4_driver_
 
 	/* Reset to power-on state */
 	writel(0, &idd->idd_misc_regs->int_out.raw);
-	mmiowb();
+	io_wmb();
 
 	/* Set up square wave */
 	int_out.raw = 0;
@@ -164,7 +164,7 @@ ioc4_clock_calibrate(struct ioc4_driver_
 	int_out.fields.mode = IOC4_INT_OUT_MODE_TOGGLE;
 	int_out.fields.diag = 0;
 	writel(int_out.raw, &idd->idd_misc_regs->int_out.raw);
-	mmiowb();
+	io_wmb();
 
 	/* Check square wave period averaged over some number of cycles */
 	do {
