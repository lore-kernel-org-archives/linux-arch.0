From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Mon, 10 Jul 2017 13:18:23 -0700 (PDT)
Message-ID: <mhng-70bfae2b-3aa2-4d9b-b4a1-b6662fc86917@palmer-si-x1c4>
References: <mhng-f92ef7c4-049a-4a71-be12-c600d1d7858b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34377 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdGJUSY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2017 16:18:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so15899119pfe.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 13:18:24 -0700 (PDT)
In-Reply-To: <mhng-f92ef7c4-049a-4a71-be12-c600d1d7858b@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: hch@infradead.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org, mathieu.desnoyers@efficios.com

On Mon, 10 Jul 2017 13:00:29 PDT (-0700), Palmer Dabbelt wrote:
> On Thu, 06 Jul 2017 08:45:13 PDT (-0700), will.deacon@arm.com wrote:
>> On Thu, Jul 06, 2017 at 08:34:27AM -0700, Christoph Hellwig wrote:
>>> On Thu, Jul 06, 2017 at 09:55:03AM +0100, Will Deacon wrote:
>>> > Agreed on the indirection; it feels like this is something that should be in
>>> > the vDSO, which could use the cmpxchg instruction if it's available, or
>>> > otherwise just uses plain loads and stores.
>
> These are already in the vDSO, and use the corresponding atomic instructions on
> systems with the A extension.  The vDSO routines call the system calls in non-A
> systems.  As far as I can tell that's necessary to preserve atomicity, which we
> currently do by disabling scheduling.  If there's a way to do this without
> entering the kernel then I'd be happy to support it, but I'm not sure how we
> could maintain atomicity using only regular loads and stores.
>
>>> Even that seems like a lot of indirection for something that is in
>>> the critical fast path for synchronization.  I really can't understand
>>> how a new ISA / ABI could even come up with an idea as stupid as making
>>> essential synchronization primitives optional.
>>
>> No disagreement there!
>
> The default set of multilibs on Linux are:
>
>  * rv32imac: 32-bit; Multiply, Atomic, and Compressed extensions
>  * rv32imafdc: like above, but with single+double float
>  * rv64imac: 64-bit, Multiply, Atomic and Compressed
>  * rv64imafdc: like above, but with single+double float
>
> all of which support the A extension.  We certainly don't plan on building any
> systems that support Linux without the A extension at SiFive, so I'm fine
> removing the system call -- this was originally added by a user, so there was
> at least enough interest for someone to add the system call.
>
> We've found people are retrofitting other cores to run RISC-V, and I could
> certainly imagine an older design that lacks a beefy enough memory system to
> support our atomics (which are LR/SC based) being a design that might arise.
> There's a lot of systems where people don't seem to care that much about the
> performance and just want something to work -- if they're on such a tiny system
> they can't implement the A extension then they're probably not going to be
> doing a lot of atomics anyway, so maybe it doesn't matter if atomics are slow.
> As the cost for supporting these A-less systems seems fairly small, it seemed
> like the right thing to do -- one of the points of making RISC-V have many
> optional extensions was to let people pick the ones they view as important.
> Since I don't know the performance constraints of their systems or the cost of
> implementing the A extension in their design, I'm not really qualified to tell
> them a cmpxchg syscall is a bad idea.
>
> I'm fine either way here: if someone's core can't support the A extension they
> can always just buy one that does (ideally from us :)).  If it was up to be I'd
> leave the calls in there, as I generally don't like to tell users we won't
> support their use case, but since you guys seem to know a lot more about this
> than I do I'll just leave the decision up to you.
>
> If you want the system call (and the corresponding vDSO entry, which will be
> unnecessary if we mandate A) gone then I'll remove it for our v5.  Just give me
> a heads up.
>
> Thanks, and sorry for wasting your time!

I mangled this message when sending it so I'm trying again.
