Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44474 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfDKWNq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Apr 2019 18:13:46 -0400
Message-ID: <080d1ec73e3e29d6ffeeeb50b39b613da28afb37.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 01/21] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 12 Apr 2019 08:12:26 +1000
In-Reply-To: <20190405135936.7266-2-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
         <20190405135936.7266-2-will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>, Akira Yokosawa <akiyks@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190411221226.0-s2RJibHGNEua0nVTEs9HGw0TxTBCvqx6I63ffjmg8@z>

On Fri, 2019-04-05 at 14:59 +0100, Will Deacon wrote:
> +     1. All readX() and writeX() accesses to the same peripheral are ordered
> +        with respect to each other. For example, this ensures that MMIO register
> +       writes by the CPU to a particular device will arrive in program order.

Minor nit... I would have said "All readX() and writeX() accesses _from
the same CPU_ to the same peripheral... and then s/the CPU/this CPU.

> -     Accesses to this space may be fully synchronous (as on i386), but
> -     intermediary bridges (such as the PCI host bridge) may not fully honour
> -     that.
> +     2. A writeX() by the CPU to the peripheral will first wait for the
> +        completion of all prior CPU writes to memory. For example, this ensures
> +        that writes by the CPU to an outbound DMA buffer allocated by
> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
> +        to its MMIO control register to trigger the transfer.

Similarily "the CPU" -> "a CPU"
>  
> -     They are guaranteed to be fully ordered with respect to each other.
> +     3. A readX() by the CPU from the peripheral will complete before any
> +       subsequent CPU reads from memory can begin. For example, this ensures
> +       that reads by the CPU from an incoming DMA buffer allocated by
> +       dma_alloc_coherent() will not see stale data after reading from the DMA
> +       engine's MMIO status register to establish that the DMA transfer has
> +       completed.
>  
> -     They are not guaranteed to be fully ordered with respect to other types of
> -     memory and I/O operation.
> +     4. A readX() by the CPU from the peripheral will complete before any
> +       subsequent delay() loop can begin execution. For example, this ensures
> +       that two MMIO register writes by the CPU to a peripheral will arrive at
> +       least 1us apart if the first write is immediately read back with readX()
> +       and udelay(1) is called prior to the second writeX().
>  
> - (*) readX(), writeX():
> +     __iomem pointers obtained with non-default attributes (e.g. those returned
> +     by ioremap_wc()) are unlikely to provide many of these guarantees.

So we give up on defining _wc semantics ? :-) Fair enough, it's a
mess...

 .../...

> +All of these accessors assume that the underlying peripheral is little-endian,
> +and will therefore perform byte-swapping operations on big-endian architectures.

This is not true of readsX/writesX, those will perform native accesses and are
intrinsically endian neutral.

> +Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
> +operations is a dangerous sport which may require the use of mmiowb(). See the
> +subsection "Acquires vs I/O accesses" for more information.

Cheers,
Ben.
