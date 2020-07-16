From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Thu, 16 Jul 2020 11:46:22 -0400 (EDT)
Message-ID: <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com> <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com> <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none> <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com> <1594868476.6k5kvx8684.astroid@bobo.none> <1594873644.viept6os6j.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.26.124]:41972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGPPqY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 11:46:24 -0400
In-Reply-To: <1594873644.viept6os6j.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>



----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
> I should be more complete here, especially since I was complaining
> about unclear barrier comment :)
> 
> 
> CPU0                     CPU1
> a. user stuff            1. user stuff
> b. membarrier()          2. enter kernel
> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
> d. read rq->curr         4. rq->curr switched to kthread
> e. is kthread, skip IPI  5. switch_to kthread
> f. return to user        6. rq->curr switched to user thread
> g. user stuff            7. switch_to user thread
>                         8. exit kernel
>                         9. more user stuff
> 
> What you're really ordering is a, g vs 1, 9 right?
> 
> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
> etc.
> 
> Userspace does not care where the barriers are exactly or what kernel
> memory accesses might be being ordered by them, so long as there is a
> mb somewhere between a and g, and 1 and 9. Right?

This is correct. Note that the accesses to user-space memory can be
done either by user-space code or kernel code, it doesn't matter.
However, in order to be considered as happening before/after
either membarrier or the matching compiler barrier, kernel code
needs to have causality relationship with user-space execution,
e.g. user-space does a system call, or returns from a system call.

In the case of io_uring, submitting a request or returning from waiting
on request completion appear to provide this causality relationship.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
