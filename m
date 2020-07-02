From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Thu, 2 Jul 2020 10:59:48 -0700
Message-ID: <20200702175948.GV9247@paulmck-ThinkPad-P72>
References: <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200702082040.GB4781@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 02, 2020 at 10:20:40AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 09:03:38AM -0700, Paul E. McKenney wrote:
> 
> > But it looks like we are going to have to tell the compiler.
> 
> What does the current proposal look like? I can certainly annotate the
> seqcount latch users, but who knows what other code is out there....

For pointers, yes, within the Linux kernel it is hopeless, thus the
thought of a -fall-dependent-ptr or some such that makes the compiler
pretend that each and every pointer is marked with the _Dependent_ptr
qualifier.

New non-Linux-kernel code might want to use his qualifier explicitly,
perhaps something like the following:

	_Dependent_ptr struct foo *p;  // Or maybe after the "*"?

	rcu_read_lock();
	p = rcu_dereference(gp);
	// And so on...

If a function is to take a dependent pointer as a function argument,
then the corresponding parameter need the _Dependent_ptr marking.
Ditto for return values.

The proposal did not cover integers due to concerns about the number of
optimization passes that would need to be reviewed to make that work.
Nevertheless, using a marked integer would be safer than using an unmarked
one, and if the review can be carried out, why not?  Maybe something
like this:

	_Dependent_ptr int idx;

	rcu_read_lock();
	idx = READ_ONCE(gidx);
	d = rcuarray[idx];
	rcu_read_unlock();
	do_something_with(d);

So use of this qualifier is quite reasonable.

The prototype for GCC is here: https://github.com/AKG001/gcc/

							Thanx, Paul
