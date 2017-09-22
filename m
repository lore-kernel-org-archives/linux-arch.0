From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Fri, 22 Sep 2017 15:08:00 +1000
Message-ID: <87377fuxqn.fsf@concordia.ellerman.id.au>
References: <20170917223608.GA14577@linux.vnet.ibm.com> <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com> <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com> <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50739 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbdIVFIE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Sep 2017 01:08:04 -0400
In-Reply-To: <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Sep 20, 2017 at 06:13:50PM +0000, Mathieu Desnoyers wrote:
>
>> > Also, can you elaborate on the PPC issue?  PPC appears to track
>> > mm_cpumask more or less just like x86.  Is the issue just that this
>> > tracking has no implied barriers?  If so, how does TLB flush on ppc
>> > work?  It really does seem impressive to me that an architecture can
>> > efficiently support munmap() but not an expedited private membarrier.
>> 
>> I'll leave this question to the PPC experts :)
>
> IIRC PPC does not keep a tight mm_cpumask, it only sets bit, it never
> clears bits. The atomic op required to set bits does not imply any
> memory barrier on PPC.

Yep.

We do have a full barrier now when we set a bit, but not if the bit was
already set.

> TLB invalidation is a TLBI instruction, it sends TLBI broadcast packets
> over the interconnect, it doesn't require IPIs like x86.

Yep.

> The only optimization PPC does is that if the mm_cpumask has only a
> single bit set, it uses a TLBI instruction without broadcast, which is
> cheaper.

Yep.

We would like to trim the mm_cpumask, but it's one of those hairy
optimisations we have never quite found time to do.

I've been away for two weeks so I've not been able to keep up with the
membarrier discussions. Will try and page it back in next week.

cheers
