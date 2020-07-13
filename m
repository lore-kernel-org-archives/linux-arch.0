From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Mon, 13 Jul 2020 14:45:59 +1000
Message-ID: <1594613902.1wzayj0p15.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMEqG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 00:46:06 -0400
In-Reply-To: <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>

Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
> On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> And get rid of the generic sync_core_before_usermode facility.
>>
>> This helper is the wrong way around I think. The idea that membarrier
>> state requires a core sync before returning to user is the easy one
>> that does not need hiding behind membarrier calls. The gap in core
>> synchronization due to x86's sysret/sysexit and lazy tlb mode, is the
>> tricky detail that is better put in x86 lazy tlb code.
>>
>> Consider if an arch did not synchronize core in switch_mm either, then
>> membarrier_mm_sync_core_before_usermode would be in the wrong place
>> but arch specific mmu context functions would still be the right place.
>> There is also a exit_lazy_tlb case that is not covered by this call, whi=
ch
>> could be a bugs (kthread use mm the membarrier process's mm then context
>> switch back to the process without switching mm or lazy mm switch).
>>
>> This makes lazy tlb code a bit more modular.
>=20
> The mm-switching and TLB-management has often had the regrettable
> property that it gets wired up in a way that seems to work at the time
> but doesn't have clear semantics, and I'm a bit concerned that this
> patch is in that category.

It's much more explicit in the core code about where hooks are called
after this patch. And then the x86 membarrier implementation details
are contained to the x86 code where they belong, and we don't have the
previous hook with unclear semantics missing from core code.

> If I'm understanding right, you're trying
> to enforce the property that exiting lazy TLB mode will promise to
> sync the core eventually.  But this has all kinds of odd properties:
>=20
>  - Why is exit_lazy_tlb() getting called at all in the relevant cases?

It's a property of how MEMBARRIER_SYNC_CORE is implemented by arch/x86,
see the membarrier comment in finish_task_switch (for analogous reason).

>  When is it permissible to call it?

Comment for the asm-generic code says it's to be called when the lazy
active mm becomes non-lazy.

> I look at your new code and see:
>=20
>> +/*
>> + * Ensure that a core serializing instruction is issued before returnin=
g
>> + * to user-mode, if a SYNC_CORE was requested. x86 implements return to
>> + * user-space through sysexit, sysrel, and sysretq, which are not core
>> + * serializing.
>> + *
>> + * See the membarrier comment in finish_task_switch as to why this is d=
one
>> + * in exit_lazy_tlb.
>> + */
>> +#define exit_lazy_tlb exit_lazy_tlb
>> +static inline void exit_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
>> +{
>> +       /* Switching mm is serializing with write_cr3 */
>> +        if (tsk->mm !=3D mm)
>> +                return;
>=20
> And my brain says WTF?  Surely you meant something like if
> (WARN_ON_ONCE(tsk->mm !=3D mm)) { /* egads, what even happened?  how do
> we try to recover well enough to get a crashed logged at least? */ }

No, the active mm can be unlazied by switching to a different mm.

> So this needs actual documentation, preferably in comments near the
> function, of what the preconditions are and what this mm parameter is.
> Once that's done, then we could consider whether it's appropriate to
> have this function promise to sync the core under some conditions.

It's documented in generic code. I prefer not to duplicate comments
too much but I can add a "refer to asm-generic version for usage" or
something if you'd like?

>  - This whole structure seems to rely on the idea that switching mm
> syncs something.

Which whole structure? The x86 implementation of sync core explicitly
does rely on that, yes. But I've pulled that out of core code with
this patch.

> I periodically ask chip vendor for non-serializing
> mm switches.  Specifically, in my dream world, we have totally
> separate user and kernel page tables.  Changing out the user tables
> doesn't serialize or even create a fence.  Instead it creates the
> minimum required pipeline hazard such that user memory access and
> switches to usermode will make sure they access memory through the
> correct page tables.  I haven't convinced a chip vendor yet, but there
> are quite a few hundreds of cycles to be saved here.

The fundmaental difficulty is that the kernel can still access user
mappings any time after the switch. We can probably handwave ways
around it by serializing lazily when encountering the next user
access and hoping that most of your mm switches result in a kernel
exit that serializes or some other unavoidable serialize so you can
avoid the mm switch one. In practice it sounds like a lot of trouble.
But anyway the sync core could presumably be adjusted or reasoned to
still be correct, depending on how it works.

> With this in
> mind, I see the fencing aspects of the TLB handling code as somewhat
> of an accident.  I'm fine with documenting them and using them to
> optimize other paths, but I think it should be explicit.  For example:
>=20
> /* Also does a full barrier?  (Or a sync_core()-style barrier.)
> However, if you rely on this, you must document it in a comment where
> you call this function. *?
> void switch_mm_irqs_off()
> {
> }
>=20
> This is kind of like how we strongly encourage anyone using smp_?mb()
> to document what they are fencing against.

Hmm. I don't think anything outside core scheduler/arch code is allowed
to assume that, because they don't really know if schedule() will cause
a switch. Hopefully nobody does, I would agree it shouldn't be=20
encouraged.

It is pretty fundamental to how we do task CPU migration so I don't see
it ever going away. A push model where the source CPU has to release=20
tasks that it last ran before they can be run elsewhere is unworkable.=20
(Or maybe it's not, but no getting around that would require careful
audits of said low level code).

> Also, as it stands, I can easily see in_irq() ceasing to promise to
> serialize.  There are older kernels for which it does not promise to
> serialize.  And I have plans to make it stop serializing in the
> nearish future.

You mean x86's return from interrupt? Sounds fun... you'll konw where to=20
update the membarrier sync code, at least :)

Thanks,
Nick
