From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 13:40:27 +0200
Message-ID: <20200701114027.GO4800@hirez.programming.kicks-ass.net>
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
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 01, 2020 at 11:41:17AM +0200, Marco Elver wrote:
> On Tue, 30 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> > > On Tue, Jun 30, 2020 at 09:19:31PM +0200, Marco Elver wrote:

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

Urgh, that sounds nasty. The thing is, as I've hinted at in my other
reply, I would really like a compiler switch to disable this
optimization entirely -- knowing how relevant the trnaformation is, is
simply a first step towards that.

In order to control the tranformation, you have to actually know where
in the optimization passes it happens.

Also, if (big if in my book) we find the optimization is actually
beneficial, we can invert the warning when using the switch and warn
about lost optimization possibilities and manually re-write the code to
use control deps.

> > > This would give us an indication of how valuable this transformation is
> > > for the kernel. I'm hoping/expecting it's vanishingly rare, but what do
> > > I know.
> >
> > This could be quite useful!
> 
> We might then even be able to say, "if you get this warning, turn on
> CONFIG_ACQUIRE_READ_DEPENDENCIES" (or however the option will be
> named). 

I was going to suggest: if this happens, employ -fno-wreck-dependencies
:-)
