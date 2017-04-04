From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Tue, 4 Apr 2017 13:02:33 +1000
Message-ID: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
        <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
        <20170404095001.664718b8@roar.ozlabs.ibm.com>
        <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36199 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdDDDCu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2017 23:02:50 -0400
In-Reply-To: <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>

On Mon, 3 Apr 2017 17:43:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 3, 2017 at 4:50 PM, Nicholas Piggin <npiggin@gmail.com> wrote:

> > If you have any ideas, I'd be open to them.  
> 
> So the idea would be that maybe we can just make those things
> explicit. IOW, instead of having that magical looping construct that
> does other magical hidden things as part of the loop, maybe we can
> just have a
> 
>    begin_cpu_relax();
>    while (!cond)
>        cpu_relax();
>    end_cpu_relax();
> 
> and then architectures can decide how they implement it. So for x86,
> the begin/end macros would be empty. For ppc, maybe begin/end would be
> the "lower and raise priority", while cpu_relax() itself is an empty
> thing.
> 
> Or maybe "begin" just clears a counter, while "cpu_relax()" does some
> "increase iterations, and lower priority after X iterations", and then
> "end" raises the priority again.
> 
> The "do magic having a special loop" approach disturbs me. I'd much
> rather have more explicit hooks that allow people to do their own loop
> semantics (including having a "return" to exit early).

I guess so. Users will still have to read the documentation rather than
just throw it in ad hoc because it seems like a good idea.

For example powerpc must not use any other primitives that might change
SMT priority in the idle loop. For x86 if you do too much work, the rep
; nop component becomes relatively small and you lose benefit (10 cycles
latency pre-skylake).

I would suggest keeping standalone cpu_relax() for incidental code in
drivers and things (powerpc may add some extra nops between SMT low
and SMT normal priorities to improve it a little), and this would
be used by important core code and primitives.

> But that depends on architectures having some pattern that we *can*
> abstract. Would some "begin/in-loop/end" pattern like the above be
> sufficient?

Yes. begin/in/end would be sufficient for powerpc SMT priority, and
for x86, and it looks like sparc64 too. So we could do that if you
prefer.

After this, I might look at optimizing the loop code itself (optimizing
exit condition, de-pipelining, etc). That would require spin loop
primitives like this again. BUT they would not have funny restrictions
on exit conditions because they wouldn't do SMT priority. If I get
positive numbers for that, would you be opposed to having such
primitives (just for the important core spin loops)?

> I think s390 might have issues too, since they tried to have that
> "cpu_relax_yield" thing (which is only used by stop_machine), and
> they've tried cpu_relax_lowlatency() and other games.

There are some considerations with hv/guest yielding, yes. I'm not
touching that yet, but it needs to be looked at. Generic code has no
chance of looking at primitives available and deciding which should
be best used (not least because they aren't documented).

I think for the most part, busy loops shouldn't be done if they tend
to be more expensive than a context switch + associated cache costs,
so hypervisors are okay there. It's just rare cases where we *have*
to spin. Directed spinning or yielding for a resource is possibly more
general pattern and something to look at adding to these spin APIs, but
for now they should be okay to just remain within the loop body.

Summary: hypervisor guests should not be affected by the new
APIs, but we could look at augmenting them later with some hv hints.

Thanks,
Nick
