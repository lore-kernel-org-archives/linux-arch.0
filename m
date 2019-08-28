From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
Date: Wed, 28 Aug 2019 10:35:24 +1000
Message-ID: <1566947104.2uma6s0pl1.astroid@bobo.none>
References: <20190827131818.14724-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>
List-Id: linux-arch.vger.kernel.org

Will Deacon's on August 27, 2019 11:18 pm:
> can actually raise a translation fault on the load instruction because the
> translation can be performed speculatively before the page table update and
> then marked as "faulting" by the CPU. For user PTEs, this is ok because we
> can handle the spurious fault, but for kernel PTEs and intermediate table
> entries this results in a panic().

powerpc sounds like it has the same coherency issue with stores vs loads 
from the MMU's page table walker, and a barrier called ptesync to order 
them.

> We can fix this by reverting 24fe1b0efad4fcdd, but the fun doesn't stop
> there. If we consider the unmap case, then a similar constraint applies to
> ordering subsequent memory accesses after the completion of the TLB
> invalidation, so we also need to add an ISB instruction to
> __flush_tlb_kernel_pgtable(). For user addresses, the exception return
> provides the necessary context synchronisation.
> 
> This then raises an interesting question: if an ISB is required after a TLBI
> instruction to prevent speculative translation of subsequent instructions,
> how is this speculation prevented on concurrent CPUs that receive the
> broadcast TLB invalidation message? Sending and completing a broadcast TLB
> invalidation message does not imply execution of an ISB on the remote CPU,
> however it /does/ require that the remote CPU will no longer make use of any
> old translations because otherwise we wouldn't be able to guarantee that an
> unmapped page could no longer be modified. In this regard, receiving a TLB
> invalidation is in some ways stronger than sending one (where you need the
> ISB).

Similar with powerpc's tlbie, sender requires extra barriers!

> So far, so good, but the final piece of the puzzle isn't quite so rosy.
> 
> *** Other architecture maintainers -- start here! ***
> 
> In the case that one CPU maps a page and then sets a flag to tell another
> CPU:
> 
> 	CPU 0
> 	-----
> 
> 	MOV	X0, <valid pte>
> 	STR	X0, [Xptep]	// Store new PTE to page table
> 	DSB	ISHST
> 	ISB
> 	MOV	X1, #1
> 	STR	X1, [Xflag]	// Set the flag
> 
> 	CPU 1
> 	-----
> 
> loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
> 	CBZ	X0, loop
> 	LDR	X1, [X2]	// Translates using the new PTE
> 
> then the final load on CPU 1 can raise a translation fault for the same
> reasons as mentioned at the start of this description.

powerpc's ptesync instruction is defined to order MMU memory accesses on
all other CPUs. ptesync does not go out to the fabric though. How does
it work then?

Because the MMU coherency problem (at least we have) is not that the
load will begin to "partially" execute ahead of the store, enough to
kick off a table walk that goes ahead of the store, but not so much
that it violates the regular CPU barriers. It's just that the loads
from the MMU don't participate in the LSU pipeline, they don't snoop
the store queues aren't inserted into load queues so the regular
memory barrier instructions won't see stores from other threads cuasing
ordering violations.

In your first example, if powerpc just has a normal memory barrier
there instead of a ptesync, it could all execute completely
non-speculatively and in-order but still cause a fault, because the
table walker's loads didn't see the store in the store queue.

From the other side of the fabric you have no such problem. The table
walker is cache coherent apart from the local stores, so we don't need a 
special barrier on the other side. That's why ptesync doesn't broadcast.

I would be surprised if ARM's issue is different, but interested to 
hear if it is.

> In reality, code
> such as:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 	spin_lock(&lock);		spin_lock(&lock);
> 	*ptr = vmalloc(size);		if (*ptr)
> 	spin_unlock(&lock);			foo = **ptr;
> 					spin_unlock(&lock);
> 
> will not trigger the fault because there is an address dependency on
> CPU1 which prevents the speculative translation. However, more exotic
> code where the virtual address is known ahead of time, such as:
> 
> 	CPU 0				CPU 1
> 	-----				-----
> 	spin_lock(&lock);		spin_lock(&lock);
> 	set_fixmap(0, paddr, prot);	if (mapped)
> 	mapped = true;				foo = *fix_to_virt(0);
> 	spin_unlock(&lock);		spin_unlock(&lock);
> 
> could fault.

This is kind of a different issue, or part of a wider one at least.
Consider speculative execution more generally, any branch mispredict can 
send us off to crazy town executing instructions using nonsense register
values. CPU0 does not have to be in the picture, or any kernel page 
table modification at all, CPU1 alone will be doing speculative loads 
wildly all over the kernel address space and trying to access pages with
no pte.

Yet we don't have to flush TLB when creating a new kernel mapping, and
we don't get spurious kernel faults. The page table walker won't
install negative entries, at least not "architectural" i.e., that cause
faults and require flushing. My guess is ARM is similar, or you would 
have seen bigger problems by now?

If you have CPU0 doing a ro->rw upgrade on a kernel PTE, then it may
be possible another CPU1 would speculatively install a ro TLB and then
spurious fault on it when attempting to store to it. But no amount of
barriers would help because CPU1 could have picked up that TLB any time
in the past.

Thanks,
Nick
