From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 07:06:54 -0700
Message-ID: <20200701140654.GL9247@paulmck-ThinkPad-P72>
References: <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgGAOGz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Jul 2020 10:06:55 -0400
Content-Disposition: inline
In-Reply-To: <20200701114027.GO4800@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Wed, Jul 01, 2020 at 01:40:27PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 11:41:17AM +0200, Marco Elver wrote:
> > On Tue, 30 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Jun 30, 2020 at 09:19:31PM +0200, Marco Elver wrote:
> 
> > > > > Thoughts?
> > > >
> > > > How hard would it be to creates something that analyzes a build and
> > > > looks for all 'dependent load -> control dependency' transformations
> > > > headed by a volatile (and/or from asm) load and issues a warning for
> > > > them?
> > 
> > I was thinking about this, but in the context of the "auto-promote to
> > acquire" which you didn't like. Issuing a warning should certainly be
> > simpler.
> > 
> > I think there is no one place where we know these transformations
> > happen, but rather, need to analyze the IR before transformations,
> > take note of all the dependent loads headed by volatile+asm, and then
> > run an analysis after optimizations checking the dependencies are
> > still there.
> 
> Urgh, that sounds nasty. The thing is, as I've hinted at in my other
> reply, I would really like a compiler switch to disable this
> optimization entirely -- knowing how relevant the trnaformation is, is
> simply a first step towards that.
> 
> In order to control the tranformation, you have to actually know where
> in the optimization passes it happens.
> 
> Also, if (big if in my book) we find the optimization is actually
> beneficial, we can invert the warning when using the switch and warn
> about lost optimization possibilities and manually re-write the code to
> use control deps.

There are lots of optimization passes and any of them might decide to
destroy dependencies.  :-(

> > > > This would give us an indication of how valuable this transformation is
> > > > for the kernel. I'm hoping/expecting it's vanishingly rare, but what do
> > > > I know.
> > >
> > > This could be quite useful!
> > 
> > We might then even be able to say, "if you get this warning, turn on
> > CONFIG_ACQUIRE_READ_DEPENDENCIES" (or however the option will be
> > named). 
> 
> I was going to suggest: if this happens, employ -fno-wreck-dependencies
> :-)

The current state in the C++ committee is that marking variables
carrying dependencies is the way forward.  This is of course not what
the Linux kernel community does, but it should not be hard to have a
-fall-variables-dependent or some such that causes all variables to be
treated as if they were marked.  Though I was hoping for only pointers.
Are they -sure- that they -absolutely- need to carry dependencies
through integers???

Anyway, the next step is to provide this functionality in one of the
major compilers.  Akshat Garg started this in GCC as a GSoC project
by duplicating "volatile" functionality with a _Dependent_ptr keyword.
Next steps would include removing "volatile" functionality not required
for dependencies.  Here is a random posting, which if I remember correctly
raised some doubts as to whether "volatile" was really carried through
everywhere that it needs to for things like LTO:

https://gcc.gnu.org/legacy-ml/gcc/2019-07/msg00139.html

What happened to this effort?  Akshat graduated and got an unrelated
job, you know, the usual.  ;-)

							Thanx, Paul
