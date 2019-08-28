Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42190 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1AgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Aug 2019 20:36:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so341841plp.9
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2019 17:36:18 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:35:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
References: <20190827131818.14724-1-will@kernel.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
MIME-Version: 1.0
Message-ID: <1566947104.2uma6s0pl1.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190828003524.bMAt4oyqvCT8sao7KDr_vkGKFRnvRD56D_SgO51HIbA@z>

Will Deacon's on August 27, 2019 11:18 pm:
> can actually raise a translation fault on the load instruction because th=
e
> translation can be performed speculatively before the page table update a=
nd
> then marked as "faulting" by the CPU. For user PTEs, this is ok because w=
e
> can handle the spurious fault, but for kernel PTEs and intermediate table
> entries this results in a panic().

powerpc sounds like it has the same coherency issue with stores vs loads=20
from the MMU's page table walker, and a barrier called ptesync to order=20
them.

> We can fix this by reverting 24fe1b0efad4fcdd, but the fun doesn't stop
> there. If we consider the unmap case, then a similar constraint applies t=
o
> ordering subsequent memory accesses after the completion of the TLB
> invalidation, so we also need to add an ISB instruction to
> __flush_tlb_kernel_pgtable(). For user addresses, the exception return
> provides the necessary context synchronisation.
>=20
> This then raises an interesting question: if an ISB is required after a T=
LBI
> instruction to prevent speculative translation of subsequent instructions=
,
> how is this speculation prevented on concurrent CPUs that receive the
> broadcast TLB invalidation message? Sending and completing a broadcast TL=
B
> invalidation message does not imply execution of an ISB on the remote CPU=
,
> however it /does/ require that the remote CPU will no longer make use of =
any
> old translations because otherwise we wouldn't be able to guarantee that =
an
> unmapped page could no longer be modified. In this regard, receiving a TL=
B
> invalidation is in some ways stronger than sending one (where you need th=
e
> ISB).

Similar with powerpc's tlbie, sender requires extra barriers!

> So far, so good, but the final piece of the puzzle isn't quite so rosy.
>=20
> *** Other architecture maintainers -- start here! ***
>=20
> In the case that one CPU maps a page and then sets a flag to tell another
> CPU:
>=20
> 	CPU 0
> 	-----
>=20
> 	MOV	X0, <valid pte>
> 	STR	X0, [Xptep]	// Store new PTE to page table
> 	DSB	ISHST
> 	ISB
> 	MOV	X1, #1
> 	STR	X1, [Xflag]	// Set the flag
>=20
> 	CPU 1
> 	-----
>=20
> loop:	LDAR	X0, [Xflag]	// Poll flag with Acquire semantics
> 	CBZ	X0, loop
> 	LDR	X1, [X2]	// Translates using the new PTE
>=20
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
