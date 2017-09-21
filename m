From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Thu, 21 Sep 2017 18:03:06 +0000 (UTC)
Message-ID: <182479244.15905.1506016986660.JavaMail.zimbra@efficios.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com> <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com> <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com> <20170921131501.abv4ul2cnpef72j2@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170921131501.abv4ul2cnpef72j2@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>
List-Id: linux-arch.vger.kernel.org

----- On Sep 21, 2017, at 9:15 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Sep 20, 2017 at 06:13:50PM +0000, Mathieu Desnoyers wrote:
>> My proposed RFC for private expedited membarrier enforces that all
>> architectures perform the registration step. Using the "PRIVATE_EXPEDITED"
>> command without prior process registration returns an error on all
>> architectures. The goal here is to make all architectures behave in the
>> same way, and it allows us to rely on process registration to deal
>> with future arch-specific optimizations.
>> 
>> Adding the "core_sync" behavior could then be done for the next kernel
>> merge window. I'm currently foreseeing two possible ABI approaches to
>> expose it:
>> 
>> Approach 1:
>> 
>> Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE and
>> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE commands. This
>> allows us to return their availability through MEMBARRIER_CMD_QUERY.
>> 
>> Approach 2:
>> 
>> Add a "MEMBARRIER_FLAG_SYNC_CORE" as flag parameter. It could be set
>> when issuing both MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED and
>> MEMBARRIER_CMD_PRIVATE_EXPEDITED, thus ensuring core serializing
>> behavior. Querying whether core serialization is supported could
>> be done by issuing the MEMBARRIER_CMD_QUERY command with the
>> MEMBARRIER_FLAG_SYNC_CORE flag set.
>> 
>> Any other ideas ? Any approach seems better ?
> 
> So we really need another FLAG for that? AFAICT the current
> PRIVATE_EXPEDITED is already sufficient for the cross modifying code,
> since the IPI triggers an exception return on all currently running CPUs
> and the future running CPUs will have the return to userspace doing the
> exception return.
> 
> The only issue is Andy fudging our x86 ret-to-userspace to not use IRET,
> which we can fix by forcing it into the slowpath (that needs to exist
> anyway) using that new TIF flag.

I agree that x86, as it stands today, would provide core serialization
with the private expedited membarrier command. And we can deal with
future optimization of ret-to-userspace using the TIF flag set on
registration.

I'm wondering whether all architectures guarantee core serialization
on return from interrupt triggered by the IPI, and on ret-to-userspace ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
