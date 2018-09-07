Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2302 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeIGVVn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 17:21:43 -0400
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
References: <20180906093655.GA9653@andrea>
 <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
 <20180907160950.GH12788@arm.com>
From: Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20990a3f-1507-c98b-f14e-2f5241319d8c@nvidia.com>
Date: Fri, 7 Sep 2018 09:39:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180907160950.GH12788@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20180907163958.2lszZ7NUsdF8HK7Qo9eQdWJtvAOsGOtmGh7LNcZPCJY@z>

On 9/7/2018 9:09 AM, Will Deacon wrote:
> On Fri, Sep 07, 2018 at 12:00:19PM -0400, Alan Stern wrote:
>> On Thu, 6 Sep 2018, Andrea Parri wrote:
>>
>>>> Have you noticed any part of the generic code that relies on ordinary 
>>>> acquire-release (rather than atomic RMW acquire-release) in order to 
>>>> implement locking constructs?
>>>
>>> There are several places in code where the "lock-acquire" seems to be
>>> provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
>>> mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
>>> provide other examples (grep for the primitives...).
>>>
>>> As long as we don't consider these primitive as RMW (which would seem
>>> odd...) or as acquire for which "most people expect strong ordering"
>>> (see above), these provides other examples for the _gap_ I mentioned.
>>
>> Okay, now I understand your objection.  It does appear that on RISC-V,
>> if nowhere else, the current implementations of qspinlock, qrwlock,
>> etc. will not provide "RCtso" ordering.
>>
>> The discussions surrounding this topic have been so lengthy and 
>> confusing that I have lost track of any comments Palmer or Daniel may 
>> have made concerning this potential problem.
>>
>> One possible resolution would be to define smp_cond_load_acquire() 
>> specially on RISC-V so that it provided the same ordering guarantees as 
>> RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
>> pointing out the necessity for the stronger guarantee on all 
>> architectures.)
>>
>> Another would be to replace the usages of atomic/smp_cond_load_acquire 
>> in the locking constructs with a new function that would otherwise be 
>> the same but would provide the ordering guarantee we want.
>>
>> Do you think either of these would be an adequate fix?
> 
> I didn't think RISC-V used qspinlock or qrwlock, so I'm not sure there's
> actually anything to fix, is there?
> 
> Will

I've also lost track of whether the current preference is or is not for
RCtso, or in which subset of cases RCtso is currently preferred.  For
whichever cases do in fact need to be RCtso, the RISC-V approach would
still be the same as what I've written in the past, as far as I can
tell [1].

In a nutshell, if a data structure uses only atomics with .aq/.rl,
RISC-V provides RCtso already anyway.  If a data structure uses fences,
or mixes fences and atomics, we can replace a "fence r,rw" or a
"fence rw,w" with a "fence.tso" (== fence r,rw + fence rw,w) as
necessary, at the cost of some amount of performance.

I suppose the answer to the question of whether smp_cond_load_acquire()
needs to change depends on where exactly RCtso is needed, and which
data structures actually use that vs. some other macro. 

Does that answer your question Alan?  Does it make sense?

[1] https://lore.kernel.org/lkml/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com/

Dan
