Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44610 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbfDDP6p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 11:58:45 -0400
Subject: Re: [PATCH tip/core/rcu 04/21] docs/memory-barriers.txt: Rewrite
 "KERNEL I/O BARRIER EFFECTS" section
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-4-paulmck@linux.ibm.com>
 <20190402130346.GA14559@fuggles.cambridge.arm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <7c0b1afc-9308-e060-d1cc-7389a2330e97@gmail.com>
Date: Fri, 5 Apr 2019 00:58:36 +0900
MIME-Version: 1.0
In-Reply-To: <20190402130346.GA14559@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20190404155836.W-trh7RkBEtx1aFLPVLsZ39HL-0wkqAzm6NenxkeZtQ@z>

Hi Will,

On Tue, 2 Apr 2019 14:03:46 +0100, Will Deacon wrote:
> On Tue, Mar 26, 2019 at 04:41:16PM -0700, Paul E. McKenney wrote:
>> From: Will Deacon <will.deacon@arm.com>
>>
>> The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
>> x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
>> This is largely because I/O ordering is a horrible can of worms, but also
>> because the document has stagnated as our understanding has evolved.
>>
>> Attempt to address some of that, by rewriting the section based on
>> recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
>> find a way to formalise this stuff, but for now let's at least try to
>> make the English easier to understand.
>>
>> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Daniel Lustig <dlustig@nvidia.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
>> Cc: Mikulas Patocka <mpatocka@redhat.com>
>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>> ---
>>  Documentation/memory-barriers.txt | 115 ++++++++++++++++++------------
>>  1 file changed, 70 insertions(+), 45 deletions(-)
> 
> If somebody could provide an Ack on this patch, I'd really appreciate it,
> please. Whilst the portable ordering guarantees that I've documented are
> fairly conservative, I do think that this change is a big improvement and
> gives you what you need if you're writing a portable device driver for a new
> piece of hardware. I'm tackling the removal of MMIOWB as a separate series.
> 
> I think Paul now requires an Ack before he'll send a patch to mainline,
> hence the grovelling.

I'm afraid I'm not that qualified to provide an Ack to this patch,
but please find a nit fix below.

> 
> Cheers,
> 
> Will
> 
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index 1c22b21ae922..158947ae78c2 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -2599,72 +2599,97 @@ likely, then interrupt-disabling locks should be used to guarantee ordering.
>>  KERNEL I/O BARRIER EFFECTS
>>  ==========================
>>  
>> -When accessing I/O memory, drivers should use the appropriate accessor
>> -functions:
>> +Interfacing with peripherals via I/O accesses is deeply architecture and device
>> +specific. Therefore, drivers which are inherently non-portable may rely on
>> +specific behaviours of their target systems in order to achieve synchronization
>> +in the most lightweight manner possible. For drivers intending to be portable
>> +between multiple architectures and bus implementations, the kernel offers a
>> +series of accessor functions that provide various degrees of ordering
>> +guarantees:
>>  
>> - (*) inX(), outX():
>> + (*) readX(), writeX():
>>  
>> -     These are intended to talk to I/O space rather than memory space, but
>> -     that's primarily a CPU-specific concept.  The i386 and x86_64 processors
>> -     do indeed have special I/O space access cycles and instructions, but many
>> -     CPUs don't have such a concept.
>> +     The readX() and writeX() MMIO accessors take a pointer to the peripheral
>> +     being accessed as an __iomem * parameter. For pointers mapped with the
>> +     default I/O attributes (e.g. those returned by ioremap()), then the
>> +     ordering guarantees are as follows:
>>  
>> -     The PCI bus, amongst others, defines an I/O space concept which - on such
>> -     CPUs as i386 and x86_64 - readily maps to the CPU's concept of I/O
>> -     space.  However, it may also be mapped as a virtual I/O space in the CPU's
>> -     memory map, particularly on those CPUs that don't support alternate I/O
>> -     spaces.
>> +     1. All readX() and writeX() accesses to the same peripheral are ordered
>> +        with respect to each other. For example, this ensures that MMIO register
>> +	writes by the CPU to a particular device will arrive in program order.
>>  
>> -     Accesses to this space may be fully synchronous (as on i386), but
>> -     intermediary bridges (such as the PCI host bridge) may not fully honour
>> -     that.
>> +     2. A writeX() by the CPU to the peripheral will first wait for the
>> +        completion of all prior CPU writes to memory. For example, this ensures
>> +        that writes by the CPU to an outbound DMA buffer allocated by
>> +        dma_alloc_coherent() will be visible to a DMA engine when the CPU writes
>> +        to its MMIO control register to trigger the transfer.
>>  
>> -     They are guaranteed to be fully ordered with respect to each other.
>> +     3. A readX() by the CPU from the peripheral will complete before any
>> +	subsequent CPU reads from memory can begin. For example, this ensures
>> +	that reads by the CPU from an incoming DMA buffer allocated by
>> +	dma_alloc_coherent() will not see stale data after reading from the DMA
>> +	engine's MMIO status register to establish that the DMA transfer has
>> +	completed.
>>  
>> -     They are not guaranteed to be fully ordered with respect to other types of
>> -     memory and I/O operation.
>> +     4. A readX() by the CPU from the peripheral will complete before any
>> +	subsequent delay() loop can begin execution. For example, this ensures
>> +	that two MMIO register writes by the CPU to a peripheral will arrive at
>> +	least 1us apart if the first write is immediately read back with readX()
>> +	and udelay(1) is called prior to the second writeX().
>>  
>> - (*) readX(), writeX():
>> +     __iomem pointers obtained with non-default attributes (e.g. those returned
>> +     by ioremap_wc()) are unlikely to provide many of these guarantees.
>>  
>> -     Whether these are guaranteed to be fully ordered and uncombined with
>> -     respect to each other on the issuing CPU depends on the characteristics
>> -     defined for the memory window through which they're accessing.  On later
>> -     i386 architecture machines, for example, this is controlled by way of the
>> -     MTRR registers.
>> + (*) readX_relaxed(), writeX_relaxed():
>>  
>> -     Ordinarily, these will be guaranteed to be fully ordered and uncombined,
>> -     provided they're not accessing a prefetchable device.
>> +     These are similar to readX() and writeX(), but provide weaker memory
>> +     ordering guarantees. Specifically, they do not guarantee ordering with
>> +     respect to normal memory accesses or delay() loops (i.e bullets 2-4 above)
>> +     but they are still guaranteed to be ordered with respect to other accesses
>> +     to the same peripheral when operating on __iomem pointers mapped with the
>> +     default I/O attributes.
>>  
>> -     However, intermediary hardware (such as a PCI bridge) may indulge in
>> -     deferral if it so wishes; to flush a store, a load from the same location
>> -     is preferred[*], but a load from the same device or from configuration
>> -     space should suffice for PCI.
>> + (*) readsX(), writesX():
>>  
>> -     [*] NOTE! attempting to load from the same location as was written to may
>> -	 cause a malfunction - consider the 16550 Rx/Tx serial registers for
>> -	 example.
>> +     The readsX() and writesX() MMIO accessors are designed for accessing
>> +     register-based, memory-mapped FIFOs residing on peripherals that are not
>> +     capable of performing DMA. Consequently, they provide only the ordering
>> +     guarantees of readX_relaxed() and writeX_relaxed(), as documented above.
>>  
>> -     Used with prefetchable I/O memory, an mmiowb() barrier may be required to
>> -     force stores to be ordered.
>> + (*) inX(), outX():
>>  
>> -     Please refer to the PCI specification for more information on interactions
>> -     between PCI transactions.
>> +     The inX() and outX() accessors are intended to access legacy port-mapped
>> +     I/O peripherals, which may require special instructions on some
>> +     architectures (notably x86). The port number of the peripheral being
>> +     accessed is passed as an argument.
>>  
>> - (*) readX_relaxed(), writeX_relaxed()
>> +     Since many CPU architectures ultimately access these peripherals via an
>> +     internal virtual memory mapping, the portable ordering guarantees provided
>> +     by inX() and outX() are the same as those provided by readX() and writeX()
>> +     respectively when accessing a mapping with the default I/O attributes.
>>  
>> -     These are similar to readX() and writeX(), but provide weaker memory
>> -     ordering guarantees.  Specifically, they do not guarantee ordering with
>> -     respect to normal memory accesses (e.g. DMA buffers) nor do they guarantee
>> -     ordering with respect to LOCK or UNLOCK operations.  If the latter is
>> -     required, an mmiowb() barrier can be used.  Note that relaxed accesses to
>> -     the same peripheral are guaranteed to be ordered with respect to each
>> -     other.
>> +     Device drivers may expect outX() to emit a non-posted write transaction
>> +     that waits for a completion response from the I/O peripheral before
>> +     returning. This is not guaranteed by all architectures and is therefore
>> +     not part of the portable ordering semantics.
>> +
>> + (*) insX(), outsX():
>> +
>> +     As above, the insX() and outX() accessors provide the same ordering
                                  outsX()

>> +     guarantees as readsX() and writesX() respectively when accessing a mapping
>> +     with the default I/O attributes.
>>  
>>   (*) ioreadX(), iowriteX()
>>  
>>       These will perform appropriately for the type of access they're actually
>>       doing, be it inX()/outX() or readX()/writeX().
>>  
>> +All of these accessors assume that the underlying peripheral is little-endian,
>> +and will therefore perform byte-swapping operations on big-endian architectures.
>> +
>> +Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
>> +operations is a dangerous sport which may require the use of mmiowb(). See the
>> +subsection "Acquires vs I/O accesses" for more information.
>>  
>>  ========================================
>>  ASSUMED MINIMUM EXECUTION ORDERING MODEL
>> -- 
>> 2.17.1
>>

JFYI, there is another document Documentation/driver-api/device-io.rst,
which is somewhat related to this update. It looks like this one also needs
some update, as Jon commented in transforming to .rst format in commit
8a8a602fdb83 ("docs: Convert the deviceio template to RST"):
<quote>
    Like the rest of our documentation, this one could use some work.  There's
    no mention of ioremap() and friends, no mention of io_read*() and friends.
    But we have nice documentation for all those folks writing new drivers that
    do port I/O :).
</quote>

This commit was merged in v4.11 cycle. And there has been no update whatsoever
since. mmiowb() is lightly mentioned therein. IMHO, just updating
memory-barriers.txt would widen the gap of information.

Thoughts?

        Thanks, Akira
