From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Date: Wed, 10 Apr 2019 13:28:34 +0100
Message-ID: <20190410122834.GB21169@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
 <20190410105833.GA116161@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190410105833.GA116161@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@>
List-Id: linux-arch.vger.kernel.org

Hi Ingo,

Thanks for taking a look (diff at the end).

On Wed, Apr 10, 2019 at 12:58:33PM +0200, Ingo Molnar wrote:
> * Will Deacon <will.deacon@arm.com> wrote:
> 
> > + (*) readX(), writeX():
> >  
> > +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
> > +     being accessed as an __iomem * parameter. For pointers mapped with the
> > +     default I/O attributes (e.g. those returned by ioremap()), then the
> > +     ordering guarantees are as follows:
> 
> s/then the
>  /the

Fixed.

> > +     1. All readX() and writeX() accesses to the same peripheral are ordered
> > +        with respect to each other. For example, this ensures that MMIO register
> > +	writes by the CPU to a particular device will arrive in program order.
> 
> Vertical alignment whitespace damage: some indentations are done via 
> spaces, one via tabs. Please standardize to tabs.

Fixed.

> I'd also suggest:
> 
> s/For example, this ensures
>  /For example this ensures

I'll just drop the "For example, " prefix altogether.

> > +     4. A readX() by the CPU from the peripheral will complete before any
> > +	subsequent delay() loop can begin execution. For example, this ensures
> > +	that two MMIO register writes by the CPU to a peripheral will arrive at
> > +	least 1us apart if the first write is immediately read back with readX()
> > +	and udelay(1) is called prior to the second writeX().
> 
> This might be more readable via some short code sequence instead?

Fixed.

> > +     __iomem pointers obtained with non-default attributes (e.g. those returned
> > +     by ioremap_wc()) are unlikely to provide many of these guarantees.
> 
> This part is a bit confusing I think, because it's so cryptic. "Unlikely" 
> as in probabilistic? ;-) So I think we should at least give some scope of 
> the exceptions and expected trouble, or at least direct people to those 
> APIs to see what the semantics are?

Right, so I'm trying to tackle the common case of ioremap() in this patch.
There isn't an agreed portable semantics for ioremap_wc() yet, so I'm taking
a punt for now but it's something I'd like to get back to in the future.
I've tried to clean up the wording in the diff below to spell out that
this this is currently arch-specific.

> >  
> > + (*) readX_relaxed(), writeX_relaxed():
> >  
> > +     These are similar to readX() and writeX(), but provide weaker memory
> > +     ordering guarantees. Specifically, they do not guarantee ordering with
> > +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
> > +     but they are still guaranteed to be ordered with respect to other accesses
> > +     to the same peripheral when operating on __iomem pointers mapped with the
> > +     default I/O attributes.
> >  
> > + (*) readsX(), writesX():
> >  
> > +     The readsX() and writesX() MMIO accessors are designed for accessing
> > +     register-based, memory-mapped FIFOs residing on peripherals that are not
> > +     capable of performing DMA. Consequently, they provide only the ordering
> > +     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
> 
> So is there any difference between 'X_relaxed' and 'sX' variants? What is 
> the 's' about?

From the ordering perspective, there isn't a difference, but they are very
different operations in the I/O access API so I think it's worth calling
them out separately. The 's' stands for "string", and these accessors
repeatedly access the same address, hence the comment about "memory-mapped
FIFOs".

Anyway, please take a look at the diff below and let me know if you're
happy with it. The original commit is currently at the bottom of my mmiowb
tree, so I'll probably put this on top as an extra commit with your
Reported-by.

Cheers,

Will

--->8

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 3522f0cc772f..d0e332161a40 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -2517,80 +2517,88 @@ guarantees:
 
  (*) readX(), writeX():
 
-     The readX() and writeX() MMIO accessors take a pointer to the peripheral
-     being accessed as an __iomem * parameter. For pointers mapped with the
-     default I/O attributes (e.g. those returned by ioremap()), then the
-     ordering guarantees are as follows:
-
-     1. All readX() and writeX() accesses to the same peripheral are ordered
-        with respect to each other. For example, this ensures that MMIO register
-	writes by the CPU to a particular device will arrive in program order.
-
-     2. A writeX() by the CPU to the peripheral will first wait for the
-        completion of all prior CPU writes to memory. For example, this ensures
-        that writes by the CPU to an outbound DMA buffer allocated by
-        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
-        to its MMIO control register to trigger the transfer.
-
-     3. A readX() by the CPU from the peripheral will complete before any
-	subsequent CPU reads from memory can begin. For example, this ensures
-	that reads by the CPU from an incoming DMA buffer allocated by
-	dma_alloc_coherent() will not see stale data after reading from the DMA
-	engine's MMIO status register to establish that the DMA transfer has
-	completed.
-
-     4. A readX() by the CPU from the peripheral will complete before any
-	subsequent delay() loop can begin execution. For example, this ensures
-	that two MMIO register writes by the CPU to a peripheral will arrive at
-	least 1us apart if the first write is immediately read back with readX()
-	and udelay(1) is called prior to the second writeX().
-
-     __iomem pointers obtained with non-default attributes (e.g. those returned
-     by ioremap_wc()) are unlikely to provide many of these guarantees.
+	The readX() and writeX() MMIO accessors take a pointer to the
+	peripheral being accessed as an __iomem * parameter. For pointers
+	mapped with the default I/O attributes (e.g. those returned by
+	ioremap()), the ordering guarantees are as follows:
+
+	1. All readX() and writeX() accesses to the same peripheral are ordered
+	   with respect to each other. This ensures that MMIO register writes by
+	   the CPU to a particular device will arrive in program order.
+
+	2. A writeX() by the CPU to the peripheral will first wait for the
+	   completion of all prior CPU writes to memory. This ensures that
+	   writes by the CPU to an outbound DMA buffer allocated by
+	   dma_alloc_coherent() will be visible to a DMA engine when the CPU
+	   writes to its MMIO control register to trigger the transfer.
+
+	3. A readX() by the CPU from the peripheral will complete before any
+	   subsequent CPU reads from memory can begin. This ensures that reads
+	   by the CPU from an incoming DMA buffer allocated by
+	   dma_alloc_coherent() will not see stale data after reading from the
+	   DMA engine's MMIO status register to establish that the DMA transfer
+	   has completed.
+
+	4. A readX() by the CPU from the peripheral will complete before any
+	   subsequent delay() loop can begin execution. This ensures that two
+	   MMIO register writes by the CPU to a peripheral will arrive at least
+	   1us apart if the first write is immediately read back with readX()
+	   and udelay(1) is called prior to the second writeX():
+
+		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
+		readl(DEVICE_REGISTER_0);
+		udelay(1);
+		writel(42, DEVICE_REGISTER_1); // ... at least 1us before this.
+
+	The ordering properties of __iomem pointers obtained with non-default
+	attributes (e.g. those returned by ioremap_wc()) are specific to the
+	underlying architecture and therefore the guarantees listed above cannot
+	generally be relied upon for these types of mappings.
 
  (*) readX_relaxed(), writeX_relaxed():
 
-     These are similar to readX() and writeX(), but provide weaker memory
-     ordering guarantees. Specifically, they do not guarantee ordering with
-     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
-     but they are still guaranteed to be ordered with respect to other accesses
-     to the same peripheral when operating on __iomem pointers mapped with the
-     default I/O attributes.
+	These are similar to readX() and writeX(), but provide weaker memory
+	ordering guarantees. Specifically, they do not guarantee ordering with
+	respect to normal memory accesses or delay() loops (i.e. bullets 2-4
+	above) but they are still guaranteed to be ordered with respect to other
+	accesses to the same peripheral when operating on __iomem pointers
+	mapped with the default I/O attributes.
 
  (*) readsX(), writesX():
 
-     The readsX() and writesX() MMIO accessors are designed for accessing
-     register-based, memory-mapped FIFOs residing on peripherals that are not
-     capable of performing DMA. Consequently, they provide only the ordering
-     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
+	The readsX() and writesX() MMIO accessors are designed for accessing
+	register-based, memory-mapped FIFOs residing on peripherals that are not
+	capable of performing DMA. Consequently, they provide only the ordering
+	guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
 
  (*) inX(), outX():
 
-     The inX() and outX() accessors are intended to access legacy port-mapped
-     I/O peripherals, which may require special instructions on some
-     architectures (notably x86). The port number of the peripheral being
-     accessed is passed as an argument.
+	The inX() and outX() accessors are intended to access legacy port-mapped
+	I/O peripherals, which may require special instructions on some
+	architectures (notably x86). The port number of the peripheral being
+	accessed is passed as an argument.
 
-     Since many CPU architectures ultimately access these peripherals via an
-     internal virtual memory mapping, the portable ordering guarantees provided
-     by inX() and outX() are the same as those provided by readX() and writeX()
-     respectively when accessing a mapping with the default I/O attributes.
+	Since many CPU architectures ultimately access these peripherals via an
+	internal virtual memory mapping, the portable ordering guarantees
+	provided by inX() and outX() are the same as those provided by readX()
+	and writeX() respectively when accessing a mapping with the default I/O
+	attributes.
 
-     Device drivers may expect outX() to emit a non-posted write transaction
-     that waits for a completion response from the I/O peripheral before
-     returning. This is not guaranteed by all architectures and is therefore
-     not part of the portable ordering semantics.
+	Device drivers may expect outX() to emit a non-posted write transaction
+	that waits for a completion response from the I/O peripheral before
+	returning. This is not guaranteed by all architectures and is therefore
+	not part of the portable ordering semantics.
 
  (*) insX(), outsX():
 
-     As above, the insX() and outsX() accessors provide the same ordering
-     guarantees as readsX() and writesX() respectively when accessing a mapping
-     with the default I/O attributes.
+	As above, the insX() and outsX() accessors provide the same ordering
+	guarantees as readsX() and writesX() respectively when accessing a
+	mapping with the default I/O attributes.
 
- (*) ioreadX(), iowriteX()
+ (*) ioreadX(), iowriteX():
 
-     These will perform appropriately for the type of access they're actually
-     doing, be it inX()/outX() or readX()/writeX().
+	These will perform appropriately for the type of access they're actually
+	doing, be it inX()/outX() or readX()/writeX().
 
 All of these accessors assume that the underlying peripheral is little-endian,
 and will therefore perform byte-swapping operations on big-endian architectures.
