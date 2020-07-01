Return-Path: <SRS0=f/HW=AM=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26627 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731622AbgGAOUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 10:20:18 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 14:20:13 +0000
Message-ID: <4427b0f825324da4b1640e32265b04bd@AcuMS.aculab.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <20200701091054.GW4781@hirez.programming.kicks-ass.net>
In-Reply-To: <20200701091054.GW4781@hirez.programming.kicks-ass.net>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200701142013.LVRRkASoPEawbbpT3DxuE8XITRZnJFXbkOOexX3Uhe4@z>

From: Peter Zijlstra
> Sent: 01 July 2020 10:11
> On Tue, Jun 30, 2020 at 01:30:16PM -0700, Paul E. McKenney wrote:
> > On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> 
> > > I'm not convinced C11 memory_order_consume would actually work for us,
> > > even if it would work. That is, given:
> > >
> > >   https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/
> > >
> > > only pointers can have consume, but like I pointed out, we have code
> > > that relies on dependent loads from integers.
> >
> > I agree that C11 memory_order_consume is not normally what we want,
> > given that it is universally promoted to memory_order_acquire.
> >
> > However, dependent loads from integers are, if anything, more difficult
> > to defend from the compiler than are control dependencies.  This applies
> > doubly to integers that are used to index two-element arrays, in which
> > case you are just asking the compiler to destroy your dependent loads
> > by converting them into control dependencies.
> 
> Yes, I'm aware. However, as you might know, I'm firmly in the 'C is a
> glorified assembler' camp (as I expect most actual OS people are, out of
> necessity if nothing else) and if I wanted a control dependency I
> would've bloody well written one.

I write in C because doing register tracking is hard :-)
I've got an hdlc implementation in C that is carefully adjusted
so that the worst case path is bounded.
I probably know every one of the 1000 instructions in it.

Would an asm statement that uses the same 'register' for input and
output but doesn't actually do anything help?
It won't generate any code, but the compiler ought to assume that
it might change the value - so can't do optimisations that track
the value across the call.

> I think an optimizing compiler is awesome, but only in so far as that
> optimization is actually helpful -- and yes, I just stepped into a giant
> twilight zone there. That is, any optimization that has _any_
> controversy should be controllable (like -fno-strict-overflow
> -fno-strict-aliasing) and I'd very much like the same here.

I'm fed up of gcc generating the code that uses SIMD instructions
for the 'tail' loop at the end of a function that is already doing
SIMD operations for the main part of the loop.
And compilers that convert a byte copy loop to 'rep movsb'.
If I'm copying 3 or 4 bytes I don't want a 40 clock overhead.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
