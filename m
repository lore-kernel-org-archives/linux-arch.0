Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfDLNRe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 09:17:34 -0400
Date: Fri, 12 Apr 2019 14:17:27 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190412131727.GB29218@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
 <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
 <e172bf1d741eafd8c056ae3692b400f24bb7c3a7.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e172bf1d741eafd8c056ae3692b400f24bb7c3a7.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190412131727.Mb6I_OW2Nx_6GXwCiwb7dPxLlg5VngaaZPnDRFoVtVg@z>

On Fri, Apr 12, 2019 at 12:07:09PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2019-04-11 at 15:34 -0700, Linus Torvalds wrote:
> > On Thu, Apr 11, 2019 at 3:13 PM Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > 
> > > Minor nit... I would have said "All readX() and writeX() accesses
> > > _from
> > > the same CPU_ to the same peripheral... and then s/the CPU/this
> > > CPU.
> > 
> > Maybe talk about "same thread" rather than "same cpu", with the
> > understanding that scheduling/preemption has to include the
> > appropriate cross-CPU IO barrier?
> 
> Works for me, but why not spell all this out in the document ? We know,
> but others might not.

Ok, how about the diff below on top of:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/mmiowb

?

I do plan to investigate ioremap_wc() and friends in the future, but it's
been painful enough just dealing with the common case! I'll almost certainly
need your help with that too.

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1660dde75e14..8ce298e09d54 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2524,26 +2524,30 @@ guarantees:
 
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
+	2. A writeX() by a CPU thread to the peripheral will first wait for the
+	   completion of all prior writes to memory either issued by the thread
+	   or issued while holding a spinlock that was subsequently taken by the
+	   thread. This ensures that writes by the CPU to an outbound DMA
+	   buffer allocated by dma_alloc_coherent() will be visible to a DMA
+	   engine when the CPU writes to its MMIO control register to trigger
+	   the transfer.
+
+	3. A readX() by a CPU thread from the peripheral will complete before
+	   any subsequent reads from memory by the same thread can begin. This
+	   ensures that reads by the CPU from an incoming DMA buffer allocated
+	   by dma_alloc_coherent() will not see stale data after reading from
+	   the DMA engine's MMIO status register to establish that the DMA
+	   transfer has completed.
+
+	4. A readX() by a CPU thread from the peripheral will complete before
+	   any subsequent delay() loop can begin execution on the same thread.
+	   This ensures that two MMIO register writes by the CPU to a peripheral
+	   will arrive at least 1us apart if the first write is immediately read
+	   back with readX() and udelay(1) is called prior to the second
+	   writeX():
 
 		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
 		readl(DEVICE_REGISTER_0);
@@ -2600,8 +2604,10 @@ guarantees:
 	These will perform appropriately for the type of access they're actually
 	doing, be it inX()/outX() or readX()/writeX().
 
-All of these accessors assume that the underlying peripheral is little-endian,
-and will therefore perform byte-swapping operations on big-endian architectures.
+With the exception of the string accessors (insX(), outsX(), readsX() and
+writesX()), all of the above assume that the underlying peripheral is
+little-endian and will therefore perform byte-swapping operations on big-endian
+architectures.
 
 
 ========================================
