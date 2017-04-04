From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Mon, 3 Apr 2017 17:43:05 -0700
Message-ID: <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
References: <20170403081328.30266-1-npiggin@gmail.com> <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
 <20170404095001.664718b8@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33320 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdDDAnH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2017 20:43:07 -0400
In-Reply-To: <20170404095001.664718b8@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>

On Mon, Apr 3, 2017 at 4:50 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> POWER does not have an instruction like pause. We can only set current
> thread priority, and current implementations do something like allocate
> issue cycles to threads based on relative priorities. So there should
> be at least one or two issue cycles at low priority, but ideally we
> would not be changing priority in the busy-wait loop because it can
> impact other threads in the core.
>
> I couldn't think of a good way to improve cpu_relax. Our (open source)
> firmware has a cpu_relax, and it puts a bunch of nops between low and
> normal priority instructions so we get some fetch cycles at low prio.
> That isn't ideal though.
>
> If you have any ideas, I'd be open to them.

So the idea would be that maybe we can just make those things
explicit. IOW, instead of having that magical looping construct that
does other magical hidden things as part of the loop, maybe we can
just have a

   begin_cpu_relax();
   while (!cond)
       cpu_relax();
   end_cpu_relax();

and then architectures can decide how they implement it. So for x86,
the begin/end macros would be empty. For ppc, maybe begin/end would be
the "lower and raise priority", while cpu_relax() itself is an empty
thing.

Or maybe "begin" just clears a counter, while "cpu_relax()" does some
"increase iterations, and lower priority after X iterations", and then
"end" raises the priority again.

The "do magic having a special loop" approach disturbs me. I'd much
rather have more explicit hooks that allow people to do their own loop
semantics (including having a "return" to exit early).

But that depends on architectures having some pattern that we *can*
abstract. Would some "begin/in-loop/end" pattern like the above be
sufficient? The pure "in-loop" case we have now (ie "cpu_relax()"
clearly isn't sufficient.

I think s390 might have issues too, since they tried to have that
"cpu_relax_yield" thing (which is only used by stop_machine), and
they've tried cpu_relax_lowlatency() and other games.

                    Linus
