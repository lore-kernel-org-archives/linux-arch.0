Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50122 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfDPJOD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Apr 2019 05:14:03 -0400
Date: Tue, 16 Apr 2019 10:13:56 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190416091356.GB31579@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
 <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
 <e172bf1d741eafd8c056ae3692b400f24bb7c3a7.camel@kernel.crashing.org>
 <20190412131727.GB29218@fuggles.cambridge.arm.com>
 <7ff812ec9c1e2a8b734b90f7480752dfd74cb8ad.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff812ec9c1e2a8b734b90f7480752dfd74cb8ad.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190416091356.QkckVGIbhDxSD4bl8iXTh8byybjXdMRo4CLdpz8mJdE@z>

Hi Ben,

On Mon, Apr 15, 2019 at 02:05:30PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2019-04-12 at 14:17 +0100, Will Deacon wrote:
> > 
> > +	   the same CPU thread to a particular device will arrive in program
> > +	   order.
> > +
> > +	2. A writeX() by a CPU thread to the peripheral will first wait for the
> > +	   completion of all prior writes to memory either issued by the thread
> > +	   or issued while holding a spinlock that was subsequently taken by the
> > +	   thread. This ensures that writes by the CPU to an outbound DMA
> > +	   buffer allocated by dma_alloc_coherent() will be visible to a DMA
> > +	   engine when the CPU writes to its MMIO control register to trigger
> > +	   the transfer.
> 
> Not particularily trying to be annoying here but I find the above
> rather hard to parse :) I know what you're getting at but I'm not sure
> somebody who doesn't will understand.
> 
> One way would be to instead prefix the whole thing with a blurb along
> the lines of:
> 
> 	readX() and writeX() provide some ordering guarantees versus
>         each other and other memory accesses that are described below. 
> 	Those guarantees apply to accesses performed either by the same
>         logical thread of execution, or by different threads but while 
>         holding the same lock (spinlock or mutex).
> 
> Then have as simpler description of each case. No ?

Argh, I think we've ended up confusing two different things in our edits:

  1. Ordering of readX()/writeX() between threads
  2. Ordering of memory accesses in one thread vs readX()/writeX() in another

and these are very different beasts.

For (1), with my mmiowb() patches we can provide some guarantees for
writeX() in conjunction with spinlocks. I'm not convinced we can provide
these same guarantees for combinations involving readX(). For example:

	CPU 1:
	val1 = readl(dev_base + REG1);
	flag = 1;
	spin_unlock(&dev_lock);

	CPU 2:
	spin_lock(&dev_lock);
	if (flag == 1)
		val2 = readl(dev_base + REG2);

In the case that CPU 2 sees the updated flag, do we require that CPU 1's readl()
reads from the device first? I'm not sure that RISC-V's implementation ensures
that readl() is ordered with a subsequent spin_unlock().

For (2), we would need to make this part of LKMM if we wanted to capture
the precise semantics here (e.g. by using the 'prop' relation to figure out
which writes are ordered by a writel). This is a pretty significant piece of
work, so perhaps just referring informally to propagation would be better for
the English text.

Updated diff below.

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1660dde75e14..bc4c6a76c53a 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2524,26 +2524,36 @@ guarantees:
 
 	1. All readX() and writeX() accesses to the same peripheral are ordered
 	   with respect to each other. This ensures that MMIO register writes by
-	   the CPU to a particular device will arrive in program order.
-
-	2. A writeX() by the CPU to the peripheral will first wait for the
-	   completion of all prior CPU writes to memory. This ensures that
-	   writes by the CPU to an outbound DMA buffer allocated by
-	   dma_alloc_coherent() will be visible to a DMA engine when the CPU
-	   writes to its MMIO control register to trigger the transfer.
-
-	3. A readX() by the CPU from the peripheral will complete before any
-	   subsequent CPU reads from memory can begin. This ensures that reads
-	   by the CPU from an incoming DMA buffer allocated by
-	   dma_alloc_coherent() will not see stale data after reading from the
-	   DMA engine's MMIO status register to establish that the DMA transfer
-	   has completed.
-
-	4. A readX() by the CPU from the peripheral will complete before any
-	   subsequent delay() loop can begin execution. This ensures that two
-	   MMIO register writes by the CPU to a peripheral will arrive at least
-	   1us apart if the first write is immediately read back with readX()
-	   and udelay(1) is called prior to the second writeX():
+	   the same CPU thread to a particular device will arrive in program
+	   order.
+
+	2. A writeX() issued by a CPU thread holding a spinlock is ordered
+	   before a writeX() to the same peripheral from another CPU thread
+	   issued after a later acquisition of the same spinlock. This ensures
+	   that MMIO register writes to a particular device issued while holding
+	   a spinlock will arrive in an order consistent with acquisitions of
+	   the lock.
+
+	3. A writeX() by a CPU thread to the peripheral will first wait for the
+	   completion of all prior writes to memory either issued by, or
+	   propagated to, the same thread. This ensures that writes by the CPU
+	   to an outbound DMA buffer allocated by dma_alloc_coherent() will be
+	   visible to a DMA engine when the CPU writes to its MMIO control
+	   register to trigger the transfer.
+
+	4. A readX() by a CPU thread from the peripheral will complete before
+	   any subsequent reads from memory by the same thread can begin. This
+	   ensures that reads by the CPU from an incoming DMA buffer allocated
+	   by dma_alloc_coherent() will not see stale data after reading from
+	   the DMA engine's MMIO status register to establish that the DMA
+	   transfer has completed.
+
+	5. A readX() by a CPU thread from the peripheral will complete before
+	   any subsequent delay() loop can begin execution on the same thread.
+	   This ensures that two MMIO register writes by the CPU to a peripheral
+	   will arrive at least 1us apart if the first write is immediately read
+	   back with readX() and udelay(1) is called prior to the second
+	   writeX():
 
 		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
 		readl(DEVICE_REGISTER_0);
@@ -2559,10 +2569,11 @@ guarantees:
 
 	These are similar to readX() and writeX(), but provide weaker memory
 	ordering guarantees. Specifically, they do not guarantee ordering with
-	respect to normal memory accesses or delay() loops (i.e. bullets 2-4
-	above) but they are still guaranteed to be ordered with respect to other
-	accesses to the same peripheral when operating on __iomem pointers
-	mapped with the default I/O attributes.
+	respect to locking, normal memory accesses or delay() loops (i.e.
+	bullets 2-5 above) but they are still guaranteed to be ordered with
+	respect to other accesses from the same CPU thread to the same
+	peripheral when operating on __iomem pointers mapped with the default
+	I/O attributes.
 
  (*) readsX(), writesX():
 
@@ -2600,8 +2611,10 @@ guarantees:
 	These will perform appropriately for the type of access they're actually
 	doing, be it inX()/outX() or readX()/writeX().
 
-All of these accessors assume that the underlying peripheral is little-endian,
-and will therefore perform byte-swapping operations on big-endian architectures.
+With the exception of the string accessors (insX(), outsX(), readsX() and
+writesX()), all of the above assume that the underlying peripheral is
+little-endian and will therefore perform byte-swapping operations on big-endian
+architectures.
 
 
 ========================================
