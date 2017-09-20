From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Wed, 20 Sep 2017 18:13:50 +0000 (UTC)
Message-ID: <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com> <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([167.114.142.141]:50046 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdITSM7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Sep 2017 14:12:59 -0400
In-Reply-To: <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

----- On Sep 20, 2017, at 12:02 PM, Andy Lutomirski luto@kernel.org wrote:

> On Sun, Sep 17, 2017 at 3:36 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
>> Hello!
>>
>> Rough notes from our discussion last Thursday.  Please reply to the
>> group with any needed elaborations or corrections.
>>
>> Adding Andy and Michael on CC since this most closely affects their
>> architectures.  Also adding Dave Watson and Maged Michael because
>> the preferred approach requires that processes wanting to use the
>> lightweight sys_membarrier() do a registration step.
> 
> Not to be too much of a curmudgeon, but I think that there should be a
> real implementation of the isync membarrier before this get merged.
> This series purports to solve two problems, ppc barriers and x86
> exit-without-isync, but it's very hard to evaluate whether it actually
> solves the latter problem given the complete lack of x86 or isync code
> in the current RFC.
> 
> It still seems to me that you won't get any particular advantage for
> using this registration mechanism on x86 even when you implement
> isync.  Unless I've misunderstood, the only real issue on x86 is that
> you need a helper like arch_force_isync_before_usermode(), and that
> helper doesn't presently exist.  That means that this whole patchset
> is standing on very dangerous ground: you'll end up with an efficient
> implementation that works just fine without even requesting
> registration on every architecture except ppc.  That way lies
> userspace bugs.

My proposed RFC for private expedited membarrier enforces that all
architectures perform the registration step. Using the "PRIVATE_EXPEDITED"
command without prior process registration returns an error on all
architectures. The goal here is to make all architectures behave in the
same way, and it allows us to rely on process registration to deal
with future arch-specific optimizations.

Adding the "core_sync" behavior could then be done for the next kernel
merge window. I'm currently foreseeing two possible ABI approaches to
expose it:

Approach 1:

Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE and
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE commands. This
allows us to return their availability through MEMBARRIER_CMD_QUERY.

Approach 2:

Add a "MEMBARRIER_FLAG_SYNC_CORE" as flag parameter. It could be set
when issuing both MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED and
MEMBARRIER_CMD_PRIVATE_EXPEDITED, thus ensuring core serializing
behavior. Querying whether core serialization is supported could
be done by issuing the MEMBARRIER_CMD_QUERY command with the
MEMBARRIER_FLAG_SYNC_CORE flag set.

Any other ideas ? Any approach seems better ?

> 
> Also, can you elaborate on the PPC issue?  PPC appears to track
> mm_cpumask more or less just like x86.  Is the issue just that this
> tracking has no implied barriers?  If so, how does TLB flush on ppc
> work?  It really does seem impressive to me that an architecture can
> efficiently support munmap() but not an expedited private membarrier.

I'll leave this question to the PPC experts :)

Thanks,

Mathieu

> 
> --Andy

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
