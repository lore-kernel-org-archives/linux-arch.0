Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730823AbfBKUW0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 15:22:26 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BKDbla099016
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 15:22:26 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkdbm6yav-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 11 Feb 2019 15:22:25 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 11 Feb 2019 20:22:24 -0000
Date: Mon, 11 Feb 2019 12:22:18 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Reply-To: paulmck@linux.ibm.com
References: <20190211172948.3322-1-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211172948.3322-1-will.deacon@arm.com>
Message-ID: <20190211202218.GQ4240@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190211202218.TCeV30UrUTsLftGIYQgnI3Yp6yUjzo-dS_3rF-NAYhw@z>

On Mon, Feb 11, 2019 at 05:29:48PM +0000, Will Deacon wrote:
> The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
> x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
> This is largely because I/O ordering is a horrible can of worms, but also
> because the document has stagnated as our understanding has evolved.
> 
> Attempt to address some of that, by rewriting the section based on
> recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
> find a way to formalise this stuff, but for now let's at least try to
> make the English easier to understand.
> 
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Hello, Will,

The intent is to replace commit 3f305018dcf3 ("docs/memory-barriers.txt:
Enforce heavy ordering for port I/O accesses"), correct?  Either way is
fine, just guessing based on the conflicts when applying this one.  ;-)

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 115 ++++++++++++++++++++------------------
>  1 file changed, 62 insertions(+), 53 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 1c22b21ae922..d08b49b2c011 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2599,72 +2599,81 @@ likely, then interrupt-disabling locks should be used to guarantee ordering.
>  KERNEL I/O BARRIER EFFECTS
>  ==========================
>  
> -When accessing I/O memory, drivers should use the appropriate accessor
> -functions:
> -
> - (*) inX(), outX():
> -
> -     These are intended to talk to I/O space rather than memory space, but
> -     that's primarily a CPU-specific concept.  The i386 and x86_64 processors
> -     do indeed have special I/O space access cycles and instructions, but many
> -     CPUs don't have such a concept.
> -
> -     The PCI bus, amongst others, defines an I/O space concept which - on such
> -     CPUs as i386 and x86_64 - readily maps to the CPU's concept of I/O
> -     space.  However, it may also be mapped as a virtual I/O space in the CPU's
> -     memory map, particularly on those CPUs that don't support alternate I/O
> -     spaces.
> -
> -     Accesses to this space may be fully synchronous (as on i386), but
> -     intermediary bridges (such as the PCI host bridge) may not fully honour
> -     that.
> -
> -     They are guaranteed to be fully ordered with respect to each other.
> -
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +Interfacing with peripherals via I/O accesses is deeply architecture and device
> +specific. Therefore, drivers which are inherently non-portable may rely on
> +specific behaviours of their target systems in order to achieve synchronization
> +in the most lightweight manner possible. For drivers intending to be portable
> +between multiple architectures and bus implementations, the kernel offers a
> +series of accessor functions that provide various degrees of ordering
> +guarantees:
>  
>   (*) readX(), writeX():
>  
> -     Whether these are guaranteed to be fully ordered and uncombined with
> -     respect to each other on the issuing CPU depends on the characteristics
> -     defined for the memory window through which they're accessing.  On later
> -     i386 architecture machines, for example, this is controlled by way of the
> -     MTRR registers.
> +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
> +     being accessed as an __iomem * parameter. For pointers mapped with the
> +     default I/O attributes (e.g. those returned by ioremap()), then the
> +     ordering guarantees are as follows:
> +
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +	writes by the CPU to a particular device will arrive in program order.
> +
> +     2. A writeX() by the CPU to the peripheral will first wait for the
> +        completion of all prior CPU writes to memory. For example, this ensures
> +        that writes by the CPU to an outbound DMA buffer allocated by
> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
> +        to its MMIO control register to trigger the transfer.
> +
> +     3. A readX() by the CPU from the peripheral will complete before any
> +	subsequent CPU reads from memory can begin. For example, this ensures
> +	that reads by the CPU from an incoming DMA buffer allocated by
> +	dma_alloc_coherent() will not see stale data after reading from the DMA
> +	engine's MMIO status register to establish that the DMA transfer has
> +	completed.
> +
> +     4. A readX() by the CPU from the peripheral will complete before any
> +	subsequent delay() loop can begin execution. For example, this ensures
> +	that two MMIO register writes by the CPU to a peripheral will arrive at
> +	least 1us apart if the first write is immediately read back with readX()
> +	and udelay(1) is called prior to the second writeX().
> +
> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees. If
> +     ordering is required for such mappings, then the mandatory barriers should
> +     be used in conjunction with the _relaxed() accessors defined below.
> +
> + (*) readX_relaxed(), writeX_relaxed():
>  
> -     Ordinarily, these will be guaranteed to be fully ordered and uncombined,
> -     provided they're not accessing a prefetchable device.
> -
> -     However, intermediary hardware (such as a PCI bridge) may indulge in
> -     deferral if it so wishes; to flush a store, a load from the same location
> -     is preferred[*], but a load from the same device or from configuration
> -     space should suffice for PCI.
> -
> -     [*] NOTE! attempting to load from the same location as was written to may
> -	 cause a malfunction - consider the 16550 Rx/Tx serial registers for
> -	 example.
> -
> -     Used with prefetchable I/O memory, an mmiowb() barrier may be required to
> -     force stores to be ordered.
> +     These are similar to readX() and writeX(), but provide weaker memory
> +     ordering guarantees. Specifically, they do not guarantee ordering with
> +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
> +     but they are still guaranteed to be ordered with respect to other accesses
> +     to the same peripheral when operating on __iomem pointers mapped with the
> +     default I/O attributes.
>  
> -     Please refer to the PCI specification for more information on interactions
> -     between PCI transactions.
> + (*) inX(), outX():
>  
> - (*) readX_relaxed(), writeX_relaxed()
> +     The inX() and outX() accessors are intended to access legacy port-mapped
> +     I/O peripherals, which may require special instructions on some
> +     architectures (notably x86). The port number of the peripheral being
> +     accessed is passed as an argument.
>  
> -     These are similar to readX() and writeX(), but provide weaker memory
> -     ordering guarantees.  Specifically, they do not guarantee ordering with
> -     respect to normal memory accesses (e.g. DMA buffers) nor do they guarantee
> -     ordering with respect to LOCK or UNLOCK operations.  If the latter is
> -     required, an mmiowb() barrier can be used.  Note that relaxed accesses to
> -     the same peripheral are guaranteed to be ordered with respect to each
> -     other.
> +     Since many CPU architectures ultimately access these peripherals via an
> +     internal virtual memory mapping, the portable ordering guarantees provided
> +     by inX() and outX() are the same as those provided by readX() and writeX()
> +     respectively when accessing a mapping with the default I/O attributes.
>  
>   (*) ioreadX(), iowriteX()
>  
>       These will perform appropriately for the type of access they're actually
>       doing, be it inX()/outX() or readX()/writeX().
>  
> +All of these accessors assume that the underlying peripheral is little-endian,
> +and will therefore perform byte-swapping operations on big-endian architectures.
> +
> +Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
> +operations is a dangerous sport which may require the use of mmiowb(). See the
> +subsection "Acquires vs I/O accesses" for more information.
>  
>  ========================================
>  ASSUMED MINIMUM EXECUTION ORDERING MODEL
> -- 
> 2.11.0
> 
