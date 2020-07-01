From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Wed, 1 Jul 2020 09:03:38 -0700
Message-ID: <20200701160338.GN9247@paulmck-ThinkPad-P72>
References: <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200701150512.GH4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 01, 2020 at 05:05:12PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 07:06:54AM -0700, Paul E. McKenney wrote:
> 
> > The current state in the C++ committee is that marking variables
> > carrying dependencies is the way forward.  This is of course not what
> > the Linux kernel community does, but it should not be hard to have a
> > -fall-variables-dependent or some such that causes all variables to be
> > treated as if they were marked.  Though I was hoping for only pointers.
> > Are they -sure- that they -absolutely- need to carry dependencies
> > through integers???
> 
> What's 'need'? :-)

Turning off all dependency-killing optimizations on all pointers is
likely a non-event.  Turning off all dependency-killing optimizations
on all integers is not the road to happiness.

So whatever "need" might be, it would need to be rather earthshaking.  ;-)
It is probably not -that- hard to convert to pointers, even if they
are indexing multiple arrays.

> I'm thinking __ktime_get_fast_ns() is better off with a dependent load
> than it is with an extra smp_rmb().
> 
> Yes we can stick an smp_rmb() in there, but I don't like it. Like I
> wrote earlier, if I wanted a control dependency, I'd have written one.

No argument here.

But it looks like we are going to have to tell the compiler.

							Thanx, Paul
