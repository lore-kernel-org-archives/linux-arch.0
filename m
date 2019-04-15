Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51734 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfDOEHI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Apr 2019 00:07:08 -0400
Message-ID: <7ff812ec9c1e2a8b734b90f7480752dfd74cb8ad.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Apr 2019 14:05:30 +1000
In-Reply-To: <20190412131727.GB29218@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
         <20190405135936.7266-2-will.deacon@arm.com>
         <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
         <CAHk-=wgLLOmocrOw2uH9QxsV=SK236gv0Df8SWXGS8c8LAiyCA@mail.gmail.com>
         <e172bf1d741eafd8c056ae3692b400f24bb7c3a7.camel@kernel.crashing.org>
         <20190412131727.GB29218@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190415040530.I67QRyftEvDOodR1A-jqqxsglnLRrxxXUd1RHMaGNXs@z>

On Fri, 2019-04-12 at 14:17 +0100, Will Deacon wrote:
> 
> +	   the same CPU thread to a particular device will arrive in program
> +	   order.
> +
> +	2. A writeX() by a CPU thread to the peripheral will first wait for the
> +	   completion of all prior writes to memory either issued by the thread
> +	   or issued while holding a spinlock that was subsequently taken by the
> +	   thread. This ensures that writes by the CPU to an outbound DMA
> +	   buffer allocated by dma_alloc_coherent() will be visible to a DMA
> +	   engine when the CPU writes to its MMIO control register to trigger
> +	   the transfer.

Not particularily trying to be annoying here but I find the above
rather hard to parse :) I know what you're getting at but I'm not sure
somebody who doesn't will understand.

One way would be to instead prefix the whole thing with a blurb along
the lines of:

	readX() and writeX() provide some ordering guarantees versus
        each other and other memory accesses that are described below. 
	Those guarantees apply to accesses performed either by the same
        logical thread of execution, or by different threads but while 
        holding the same lock (spinlock or mutex).

Then have as simpler description of each case. No ?

> +	3. A readX() by a CPU thread from the peripheral will complete before
> +	   any subsequent reads from memory by the same thread can begin. This
> +	   ensures that reads by the CPU from an incoming DMA buffer allocated
> +	   by dma_alloc_coherent() will not see stale data after reading from
> +	   the DMA engine's MMIO status register to establish that the DMA
> +	   transfer has completed.
> +
> +	4. A readX() by a CPU thread from the peripheral will complete before
> +	   any subsequent delay() loop can begin execution on the same thread.
> +	   This ensures that two MMIO register writes by the CPU to a peripheral
> +	   will arrive at least 1us apart if the first write is immediately read
> +	   back with readX() and udelay(1) is called prior to the second
> +	   writeX():
>  
>  		writel(42, DEVICE_REGISTER_0); // Arrives at the device...
>  		readl(DEVICE_REGISTER_0);
> @@ -2600,8 +2604,10 @@ guarantees:
>  	These will perform appropriately for the type of access they're actually
>  	doing, be it inX()/outX() or readX()/writeX().
>  
> -All of these accessors assume that the underlying peripheral is little-endian,
> -and will therefore perform byte-swapping operations on big-endian architectures.
> +With the exception of the string accessors (insX(), outsX(), readsX() and
> +writesX()), all of the above assume that the underlying peripheral is
> +little-endian and will therefore perform byte-swapping operations on big-endian
> +architectures.
>  
>  
>  ========================================
