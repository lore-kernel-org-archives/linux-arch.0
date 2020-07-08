From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Wed, 8 Jul 2020 10:12:31 -0400 (EDT)
Message-ID: <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
References: <20200706021822.1515189-1-npiggin@gmail.com> <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu> <1594098302.nadnq2txti.astroid@bobo.none> <638683144.970.1594121101349.JavaMail.zimbra@efficios.com> <1594185107.e130s0d92x.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:43086 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHOMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 10:12:33 -0400
In-Reply-To: <1594185107.e130s0d92x.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

----- On Jul 8, 2020, at 1:17 AM, Nicholas Piggin npiggin@gmail.com wrote:

> Excerpts from Mathieu Desnoyers's message of July 7, 2020 9:25 pm:
>> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> 
[...]
>>> I should actually change the comment for 64-bit because soft masked
>>> interrupt replay is an interesting case. I thought it was okay (because
>>> the IPI would cause a hard interrupt which does do the rfi) but that
>>> should at least be written.
>> 
>> Yes.
>> 
>>> The context synchronisation happens before
>>> the Linux IPI function is called, but for the purpose of membarrier I
>>> think that is okay (the membarrier just needs to have caused a memory
>>> barrier + context synchronistaion by the time it has done).
>> 
>> Can you point me to the code implementing this logic ?
> 
> It's mostly in arch/powerpc/kernel/exception-64s.S and
> powerpc/kernel/irq.c, but a lot of asm so easier to explain.
> 
> When any Linux code does local_irq_disable(), we set interrupts as
> software-masked in a per-cpu flag. When interrupts (including IPIs) come
> in, the first thing we do is check that flag and if we are masked, then
> record that the interrupt needs to be "replayed" in another per-cpu
> flag. The interrupt handler then exits back using RFI (which is context
> synchronising the CPU). Later, when the kernel code does
> local_irq_enable(), it checks the replay flag to see if anything needs
> to be done. At that point we basically just call the interrupt handler
> code like a normal function, and when that returns there is no context
> synchronising instruction.

AFAIU this can only happen for interrupts nesting over irqoff sections,
therefore over kernel code, never userspace, right ?

> 
> So membarrier IPI will always cause target CPUs to perform a context
> synchronising instruction, but sometimes it happens before the IPI
> handler function runs.

If my understanding is correct, the replayed interrupt handler logic
only nests over kernel code, which will eventually need to issue a
context synchronizing instruction before returning to user-space.

All we care about is that starting from the membarrier, each core
either:

- interrupt user-space to issue the context synchronizing instruction if
  they were running userspace, or
- _eventually_ issue a context synchronizing instruction before returning
  to user-space if they were running kernel code.

So your earlier statement "the membarrier just needs to have caused a memory
barrier + context synchronistaion by the time it has done" is not strictly
correct: the context synchronizing instruction does not strictly need to
happen on each core before membarrier returns. A similar line of thoughts
can be followed for memory barriers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
