Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfBVSvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:24 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 14/20] Documentation: Kill all references to mmiowb()
Date: Fri, 22 Feb 2019 18:50:20 +0000
Message-ID: <20190222185026.10973-15-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190222185020.t21UaP_KxBb5MPDtroCOpsSs-J8qUI4gzYX-pj24Z2M@z>

The guarantees provided by mmiowb() are now provided implicitly by
spin_unlock(), so we can remove all references from this most confusing
of barriers from our Documentation.

Good riddance.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/driver-api/device-io.rst  |  45 --------------
 Documentation/driver-api/pci/p2pdma.rst |   4 --
 Documentation/memory-barriers.txt       | 103 ++------------------------------
 3 files changed, 4 insertions(+), 148 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index b00b23903078..0e389378f71d 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -103,51 +103,6 @@ continuing execution::
         ha->flags.ints_enabled = 0;
     }
 
-In addition to write posting, on some large multiprocessing systems
-(e.g. SGI Challenge, Origin and Altix machines) posted writes won't be
-strongly ordered coming from different CPUs. Thus it's important to
-properly protect parts of your driver that do memory-mapped writes with
-locks and use the :c:func:`mmiowb()` to make sure they arrive in the
-order intended. Issuing a regular readX() will also ensure write ordering,
-but should only be used when the 
-driver has to be sure that the write has actually arrived at the device
-(not that it's simply ordered with respect to other writes), since a
-full readX() is a relatively expensive operation.
-
-Generally, one should use :c:func:`mmiowb()` prior to releasing a spinlock
-that protects regions using :c:func:`writeb()` or similar functions that
-aren't surrounded by readb() calls, which will ensure ordering
-and flushing. The following pseudocode illustrates what might occur if
-write ordering isn't guaranteed via :c:func:`mmiowb()` or one of the
-readX() functions::
-
-    CPU A:  spin_lock_irqsave(&dev_lock, flags)
-    CPU A:  ...
-    CPU A:  writel(newval, ring_ptr);
-    CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-            ...
-    CPU B:  spin_lock_irqsave(&dev_lock, flags)
-    CPU B:  writel(newval2, ring_ptr);
-    CPU B:  ...
-    CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
-
-In the case above, newval2 could be written to ring_ptr before newval.
-Fixing it is easy though::
-
-    CPU A:  spin_lock_irqsave(&dev_lock, flags)
-    CPU A:  ...
-    CPU A:  writel(newval, ring_ptr);
-    CPU A:  mmiowb(); /* ensure no other writes beat us to the device */
-    CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-            ...
-    CPU B:  spin_lock_irqsave(&dev_lock, flags)
-    CPU B:  writel(newval2, ring_ptr);
-    CPU B:  ...
-    CPU B:  mmiowb();
-    CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
-
-See tg3.c for a real world example of how to use :c:func:`mmiowb()`
-
 PCI ordering rules also guarantee that PIO read responses arrive after any
 outstanding DMA writes from that bus, since for some devices the result of
 a readb() call may signal to the driver that a DMA transaction is
diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 6d85b5a2598d..44deb52beeb4 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -132,10 +132,6 @@ precludes passing these pages to userspace.
 P2P memory is also technically IO memory but should never have any side
 effects behind it. Thus, the order of loads and stores should not be important
 and ioreadX(), iowriteX() and friends should not be necessary.
-However, as the memory is not cache coherent, if access ever needs to
-be protected by a spinlock then :c:func:`mmiowb()` must be used before
-unlocking the lock. (See ACQUIRES VS I/O ACCESSES in
-Documentation/memory-barriers.txt)
 
 
 P2P DMA Support Library
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 158947ae78c2..6d6eff413462 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1937,21 +1937,6 @@ There are some more advanced barrier functions:
      information on consistent memory.
 
 
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
-See the subsection "Acquires vs I/O accesses" for more information.
-
-
 ===============================
 IMPLICIT KERNEL MEMORY BARRIERS
 ===============================
@@ -2317,75 +2302,6 @@ But it won't see any of:
 	*E, *F or *G following RELEASE Q
 
 
-
-ACQUIRES VS I/O ACCESSES
-------------------------
-
-Under certain circumstances (especially involving NUMA), I/O accesses within
-two spinlocked sections on two different CPUs may be seen as interleaved by the
-PCI bridge, because the PCI bridge does not necessarily participate in the
-cache-coherence protocol, and is therefore incapable of issuing the required
-read memory barriers.
-
-For example:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	writel(1, DATA);
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					writel(5, DATA);
-					spin_unlock(Q);
-
-may be seen by the PCI bridge as follows:
-
-	STORE *ADDR = 0, STORE *ADDR = 4, STORE *DATA = 1, STORE *DATA = 5
-
-which would probably cause the hardware to malfunction.
-
-
-What is necessary here is to intervene with an mmiowb() before dropping the
-spinlock, for example:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	writel(1, DATA);
-	mmiowb();
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					writel(5, DATA);
-					mmiowb();
-					spin_unlock(Q);
-
-this will ensure that the two stores issued on CPU 1 appear at the PCI bridge
-before either of the stores issued on CPU 2.
-
-
-Furthermore, following a store by a load from the same device obviates the need
-for the mmiowb(), because the load forces the store to complete before the load
-is performed:
-
-	CPU 1				CPU 2
-	===============================	===============================
-	spin_lock(Q)
-	writel(0, ADDR)
-	a = readl(DATA);
-	spin_unlock(Q);
-					spin_lock(Q);
-					writel(4, ADDR);
-					b = readl(DATA);
-					spin_unlock(Q);
-
-
-See Documentation/driver-api/device-io.rst for more information.
-
-
 =================================
 WHERE ARE MEMORY BARRIERS NEEDED?
 =================================
@@ -2532,16 +2448,9 @@ the device to malfunction.
 Inside of the Linux kernel, I/O should be done through the appropriate accessor
 routines - such as inb() or writel() - which know how to make such accesses
 appropriately sequential.  While this, for the most part, renders the explicit
-use of memory barriers unnecessary, there are a couple of situations where they
-might be needed:
-
- (1) On some systems, I/O stores are not strongly ordered across all CPUs, and
-     so for _all_ general drivers locks should be used and mmiowb() must be
-     issued prior to unlocking the critical section.
-
- (2) If the accessor functions are used to refer to an I/O memory window with
-     relaxed memory access properties, then _mandatory_ memory barriers are
-     required to enforce ordering.
+use of memory barriers unnecessary, if the accessor functions are used to refer
+to an I/O memory window with relaxed memory access properties, then _mandatory_
+memory barriers are required to enforce ordering.
 
 See Documentation/driver-api/device-io.rst for more information.
 
@@ -2586,8 +2495,7 @@ explicit barriers are used.
 
 Normally this won't be a problem because the I/O accesses done inside such
 sections will include synchronous load operations on strictly ordered I/O
-registers that form implicit I/O barriers.  If this isn't sufficient then an
-mmiowb() may need to be used explicitly.
+registers that form implicit I/O barriers.
 
 
 A similar situation may occur between an interrupt routine and two routines
@@ -2687,9 +2595,6 @@ guarantees:
 All of these accessors assume that the underlying peripheral is little-endian,
 and will therefore perform byte-swapping operations on big-endian architectures.
 
-Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
-operations is a dangerous sport which may require the use of mmiowb(). See the
-subsection "Acquires vs I/O accesses" for more information.
 
 ========================================
 ASSUMED MINIMUM EXECUTION ORDERING MODEL
-- 
2.11.0
