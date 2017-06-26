From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Mon, 26 Jun 2017 13:07:09 -0700 (PDT)
Message-ID: <mhng-107d5417-a33b-4b20-96cb-6adead7c3130@palmer-si-x1c4>
References: <20170607131611.GF30263@arm.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33497 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdFZUHK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2017 16:07:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id e199so1600797pfh.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jun 2017 13:07:10 -0700 (PDT)
In-Reply-To: <20170607131611.GF30263@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, dlustig@nvidia.com
Cc: peterz@infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org

On Wed, 07 Jun 2017 06:16:11 PDT (-0700), will.deacon@arm.com wrote:
> [sorry, jumping in here because it's the only mail I have relating to
>  patch 13]
>
> On Wed, Jun 07, 2017 at 02:58:50PM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 07, 2017 at 02:36:27PM +0200, Peter Zijlstra wrote:
>> > Which (pending the sub confusion) will generate the entire set of:
>> >
>> >  atomic_add, atomic_add_return{_relaxed,_acquire,_release,} atomic_fetch_add{_relaxed,_acquire,_release,}
>> >  atomic_sub, atomic_sub_return{_relaxed,_acquire,_release,} atomic_fetch_sub{_relaxed,_acquire,_release,}
>> >
>> >  atomic_and, atomic_fetch_and{_relaxed,_acquire,_release,}
>> >  atomic_or,  atomic_fetch_or{_relaxed,_acquire,_release,}
>> >  atomic_xor, atomic_fetch_xor{_relaxed,_acquire,_release,}
>> >
>>
>> Another approach would be to override __atomic_op_{acquire,release} and
>> use things like:
>>
>> 	"FENCE r,rw" -- (load) ACQUIRE
>> 	"FENCE rw,w" -- (store) RELEASE
>>
>> And then you only need to provide _relaxed atomics.
>>
>> Also, and I didn't check for that, you need to provide:
>>
>> smp_load_acquire(), smp_store_release(), atomic_read_acquire(),
>> atomic_store_release().
>
> Is there an up-to-date specification for the RISC-V memory model? I looked
> at:
>
> https://github.com/riscv/riscv-isa-manual/releases/download/riscv-user-2.2/riscv-spec-v2.2.pdf

That's the most up to date spec.

> but it says:
>
> | 2.7 Memory Model
> | This section is out of date as the RISC-V memory model is
> | currently under revision to ensure it can efficiently support current
> | programming language memory models. The revised base mem- ory model will
> | contain further ordering constraints, including at least that loads to the
> | same address from the same hart cannot be reordered, and that syntactic data
> | dependencies between instructions are respected
>
> which, on the one hand is reassuring (because ignoring dependency ordering is
> plain broken), but on the other it doesn't go quite far enough in defining
> exactly what constitutes a "syntactic data dependency". The cumulativity of
> your fences also needs defining, because I think this was up in the air at some
> point and the document above doesn't seem to tackle it (it doesn't seem to
> describe what constitutes being a memory of the predecessor or successor sets)

Unfortunately I'm not really a formal memory model guy, so I probably know a
lot less about what a "syntactic data dependency" is than you do.  I believe
the plan (like for most of RISC-V) is to avoid doing anything weird, to support
existing software systems, and to allow for implementation flexibility where
possible.

> Could you shed some light on this please? We've started relying on RW control
> dependencies in semi-recent history, so it's important to get this nailed down.

This has been a sticking point for a while.  The result of lacking a proper
memory model has been that implementations have been extremely conservative and
as a result there aren't any issues in practice, but that itself is a bad
thing.

> Thanks,
>
> Will
>
> P.S. You should also totally get your architects to write a formal model ;)

The RISC-V organization has a working group defining a formal memory model.
Here's the original posting about the working group

  https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/Oxm_IvfYItY

To the best of my understanding we hope to have a formal memory model defined
by the end of the year.  I've added Daniel Lustig, the chair of the working
group, to the thread.  He knows a lot more about this than I do.
