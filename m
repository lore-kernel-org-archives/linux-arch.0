Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18953 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVFmK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Feb 2018 00:42:10 -0500
Subject: Re: [PATCH RFC tools/lkmm 10/12] tools/memory-model: Add a S
 lock-based external-view litmus test
References: <20180220232405.GA19274@linux.vnet.ibm.com>
 <1519169112-20593-10-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180222032349.klcuiq23f52sfop6@tardis>
 <20180222041357.GB2855@linux.vnet.ibm.com>
 <20180222052746.vofmqbpnmfahck3z@tardis>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <fad8e18b-ef5a-5bc0-5d87-6fad2e9f7c95@nvidia.com>
Date: Wed, 21 Feb 2018 21:42:08 -0800
MIME-Version: 1.0
In-Reply-To: <20180222052746.vofmqbpnmfahck3z@tardis>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>

On 2/21/2018 9:27 PM, Boqun Feng wrote:
> On Wed, Feb 21, 2018 at 08:13:57PM -0800, Paul E. McKenney wrote:
>> On Thu, Feb 22, 2018 at 11:23:49AM +0800, Boqun Feng wrote:
>>> On Tue, Feb 20, 2018 at 03:25:10PM -0800, Paul E. McKenney wrote:
>>>> From: Alan Stern <stern@rowland.harvard.edu>
>>>>
>>>> This commit adds a litmus test in which P0() and P1() form a lock-based S
>>>> litmus test, with the addition of P2(), which observes P0()'s and P1()'s
>>>> accesses with a full memory barrier but without the lock.  This litmus
>>>> test asks whether writes carried out by two different processes under the
>>>> same lock will be seen in order by a third process not holding that lock.
>>>> The answer to this question is "yes" for all architectures supporting
>>>
>>> Hmm.. it this true? Our spin_lock() is RCpc because of PowerPC, so
>>> spin_lock()+spin_unlock() pairs don't provide transitivity, and that's
>>> why we have smp_mb__after_unlock_lock(). Is there something I'm missing?
>>> Or there is an upcomming commit to switch PowerPC's lock implementation?
>>
>> The PowerPC lock implementation's unlock-lock pair does not order writes
>> from the previous critical section against reads from the later critical
>> section, but it does order other combinations of reads and writes.
> 
> Ah.. right! Thanks for the explanation ;-)
> 
>> Some have apparently said that RISC-V 's unlock-lock pair also does not
>> order writes from the previous critical section against writes from the
>> later critical section.  And no, I don't claim to have yet gotten my
>> head around RISC-V memory ordering.  ;-)
>>
> 
> Me neither. Now I remember this: we have a off-list(accidentally)
> discussion about this, and IIRC at that moment riscv people confirmed
> that riscv's unlock-lock pair doesn't order write->write, but that was
> before their memory model draft posted for discussions, so things may
> change now... 
> 
> Besides, I think the smp_mb() on P2 can be relaxed to smp_rmb(), no?
> 
> Regards,
> Boqun
> 
>> 							Thanx, Paul
>>

As a matter of fact, the RISC-V memory model committee is debating this
exact question at the moment.  Now that I see this thread I'll have to
go back and catch up on what I've missed, but at least I can be on cc
from this point on to answer any RISC-V questions that come up from
here on.

(Is there some place I should add my name as a RISC-V memory model
contact, so I don't miss threads like this in the future?)

And yes, if we go with a purely RCpc interpretation of acquire and
release, then I don't believe the writes in the previous critical
section would be ordered with the writes in the subsequent critical
section.  That's really all the argument boils down to.  We'd like
to support RCpc if we can since that's all some software needs, but
we also obviously want to make sure we can support RCsc and these
kinds of LKMM subtleties efficiently too when needed.  So we have a
few encoding details that we're still finalizing, because questions
like this one are still popping up :)

Let me know if you had other RISC-V-specific questions I can help
answer.

Dan
