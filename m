From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 11:03:59 +0100
Message-ID: <20200701100358.GA14959@willie-the-truck>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgGAKEF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Jul 2020 06:04:05 -0400
Content-Disposition: inline
In-Reply-To: <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Wed, Jul 01, 2020 at 11:41:17AM +0200, Marco Elver wrote:
> On Tue, 30 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 30, 2020 at 09:19:31PM +0200, Marco Elver wrote:
> > > > So, we are probably better off untangling LTO from the story:
> > > >
> > > > 1. LTO or no LTO does not matter. The LTO series should not get tangled
> > > >    up with memory model issues.
> > > >
> > > > 2. The memory model question and problems need to be answered and
> > > >    addressed separately.
> > > >
> > > > Thoughts?
> > >
> > > How hard would it be to creates something that analyzes a build and
> > > looks for all 'dependent load -> control dependency' transformations
> > > headed by a volatile (and/or from asm) load and issues a warning for
> > > them?
> 
> I was thinking about this, but in the context of the "auto-promote to
> acquire" which you didn't like. Issuing a warning should certainly be
> simpler.
> 
> I think there is no one place where we know these transformations
> happen, but rather, need to analyze the IR before transformations,
> take note of all the dependent loads headed by volatile+asm, and then
> run an analysis after optimizations checking the dependencies are
> still there.
> 
> > > This would give us an indication of how valuable this transformation is
> > > for the kernel. I'm hoping/expecting it's vanishingly rare, but what do
> > > I know.
> >
> > This could be quite useful!
> 
> We might then even be able to say, "if you get this warning, turn on
> CONFIG_ACQUIRE_READ_DEPENDENCIES" (or however the option will be
> named). Or some other tricks, like automatically recompile the TU
> where this happens with the option. But again, this is not something
> that should specifically block LTO, because if we have this, we'll
> need to turn it on for everything.

I'm not especially keen on solving this with additional config options --
all it does it further fragment the number of kernels we have to care about
and distributions really won't be in a position to know whether this should
be enabled or not. I would prefer that the build fails, and we figure out
which compiler switch we need to stop the harmful optimisation taking place.
As Peter says, it _should_ be a rare thing to see (empirically, the kernel
seems to be getting away with it so far).

The problem, as I see it, is that the C language doesn't provide us with
a way to express dependency ordering and so we're at the mercy of the
compiler when we roll our own implementation. Paul continues to fight the
good fight at committee meetings to improve the situation, but in the
meantime we'd benefit from two things:

  1. A way to disable any compiler optimisations that break our dependency
     ordering in spite of READ_ONCE()

  2. A way to detect at build time if these harmful optimisations are taking
     place

Finally, while I agree that this problem isn't limited to LTO, my fear is
that LTO provides enough information for address dependencies headed by
a READ_ONCE() to be converted to control dependencies when some common
values of the pointer can be determined by the compiler. If we can rule
this sort of thing out, then great, but in the absence of (2) I think
throwing in an acquire is a sensible safety measure. Doesn't CFI rely
on LTO to do something similar for indirect branch targets, or have I
got that totally mixed up?

Will
