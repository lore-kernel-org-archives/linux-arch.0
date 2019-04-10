Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39974 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfDJK6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Apr 2019 06:58:39 -0400
Date: Wed, 10 Apr 2019 12:58:33 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190410105833.GA116161@gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <20190405135936.7266-2-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405135936.7266-2-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190410105833.1KSVgLy5YHdXgyNtigT2CKmXQzH_C_GuMyUzZcY7PpQ@z>


Mostly minor grammer fixes:

* Will Deacon <will.deacon@arm.com> wrote:

> + (*) readX(), writeX():
>  
> +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
> +     being accessed as an __iomem * parameter. For pointers mapped with the
> +     default I/O attributes (e.g. those returned by ioremap()), then the
> +     ordering guarantees are as follows:

s/then the
 /the

> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +	writes by the CPU to a particular device will arrive in program order.

Vertical alignment whitespace damage: some indentations are done via 
spaces, one via tabs. Please standardize to tabs.

I'd also suggest:

s/For example, this ensures
 /For example this ensures


for the rest of the text too. The comma after the 'For example,' 
introductory phrase is grammatically correct but stylistically confusing, 
because in reality there's a *second* introductory phrase via "this 
ensures".

>  
> +     2. A writeX() by the CPU to the peripheral will first wait for the
> +        completion of all prior CPU writes to memory. For example, this ensures
> +        that writes by the CPU to an outbound DMA buffer allocated by
> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
> +        to its MMIO control register to trigger the transfer.
>  
> +     3. A readX() by the CPU from the peripheral will complete before any
> +	subsequent CPU reads from memory can begin. For example, this ensures
> +	that reads by the CPU from an incoming DMA buffer allocated by
> +	dma_alloc_coherent() will not see stale data after reading from the DMA
> +	engine's MMIO status register to establish that the DMA transfer has
> +	completed.
>  
> +     4. A readX() by the CPU from the peripheral will complete before any
> +	subsequent delay() loop can begin execution. For example, this ensures
> +	that two MMIO register writes by the CPU to a peripheral will arrive at
> +	least 1us apart if the first write is immediately read back with readX()
> +	and udelay(1) is called prior to the second writeX().

This might be more readable via some short code sequence instead?

>  
> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees.

This part is a bit confusing I think, because it's so cryptic. "Unlikely" 
as in probabilistic? ;-) So I think we should at least give some scope of 
the exceptions and expected trouble, or at least direct people to those 
APIs to see what the semantics are?

>  
> + (*) readX_relaxed(), writeX_relaxed():
>  
> +     These are similar to readX() and writeX(), but provide weaker memory
> +     ordering guarantees. Specifically, they do not guarantee ordering with
> +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
> +     but they are still guaranteed to be ordered with respect to other accesses
> +     to the same peripheral when operating on __iomem pointers mapped with the
> +     default I/O attributes.
>  
> + (*) readsX(), writesX():
>  
> +     The readsX() and writesX() MMIO accessors are designed for accessing
> +     register-based, memory-mapped FIFOs residing on peripherals that are not
> +     capable of performing DMA. Consequently, they provide only the ordering
> +     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.

So is there any difference between 'X_relaxed' and 'sX' variants? What is 
the 's' about?

Thanks,

	Ingo
