From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Fri, 3 Jul 2020 07:42:28 -0700
Message-ID: <20200703144228.GF9247@paulmck-ThinkPad-P72>
References: <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200703131330.GX4800@hirez.programming.kicks-ass.net>
Sender: linux-kbuild-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 03, 2020 at 03:13:30PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 02, 2020 at 10:59:48AM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 02, 2020 at 10:20:40AM +0200, Peter Zijlstra wrote:
> > > On Wed, Jul 01, 2020 at 09:03:38AM -0700, Paul E. McKenney wrote:
> > > 
> > > > But it looks like we are going to have to tell the compiler.
> > > 
> > > What does the current proposal look like? I can certainly annotate the
> > > seqcount latch users, but who knows what other code is out there....
> > 
> > For pointers, yes, within the Linux kernel it is hopeless, thus the
> > thought of a -fall-dependent-ptr or some such that makes the compiler
> > pretend that each and every pointer is marked with the _Dependent_ptr
> > qualifier.
> > 
> > New non-Linux-kernel code might want to use his qualifier explicitly,
> > perhaps something like the following:
> > 
> > 	_Dependent_ptr struct foo *p;  // Or maybe after the "*"?
> 
> After, as you've written it, it's a pointer to a '_Dependent struct
> foo'.

Yeah, I have to look that up every time.  :-/

Thank you for checking!

> > 	rcu_read_lock();
> > 	p = rcu_dereference(gp);
> > 	// And so on...
> > 
> > If a function is to take a dependent pointer as a function argument,
> > then the corresponding parameter need the _Dependent_ptr marking.
> > Ditto for return values.
> > 
> > The proposal did not cover integers due to concerns about the number of
> > optimization passes that would need to be reviewed to make that work.
> > Nevertheless, using a marked integer would be safer than using an unmarked
> > one, and if the review can be carried out, why not?  Maybe something
> > like this:
> > 
> > 	_Dependent_ptr int idx;
> > 
> > 	rcu_read_lock();
> > 	idx = READ_ONCE(gidx);
> > 	d = rcuarray[idx];
> > 	rcu_read_unlock();
> > 	do_something_with(d);
> > 
> > So use of this qualifier is quite reasonable.
> 
> The above usage might warrant a rename of the qualifier though, since
> clearly there isn't anything ptr around.

Given the large number of additional optimizations that need to be
suppressed in the non-pointer case, any discouragement based on the "_ptr"
at the end of the name is all to the good.

And if that line of reasoning is unconvincing, please look at the program
at the end of this email, which compiles without errors with -Wall and
gives the expected output.  ;-)

> > The prototype for GCC is here: https://github.com/AKG001/gcc/
> 
> Thanks! Those test cases are somewhat over qualified though:
> 
>        static volatile _Atomic (TYPE) * _Dependent_ptr a;     		\

Especially given that in C, _Atomic operations are implicitly volatile.
But this is likely a holdover from Akshat's implementation strategy,
which was to pattern _Dependent_ptr after the volatile keyword.

> Also, if C goes and specifies load dependencies, in any form, is then
> not the corrolary that they need to specify control dependencies? How
> else can they exclude the transformation.

By requiring that any temporaries generated from variables that are
marked _Dependent_ptr also be marked _Dependent_ptr.  This is of course
one divergence of _Dependent_ptr from the volatile keyword.

> And of course, once we're there, can we get explicit support for control
> dependencies too? :-) :-)

Keep talking like this and I am going to make sure that you attend a
standards committee meeting.  If need be, by arranging for you to be
physically dragged there.  ;-)

More seriously, for control dependencies, the variable that would need
to be marked would be the program counter, which might require some
additional syntax.

							Thanx, Paul

------------------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int foo(int *p, int i)
{
	return i[p];
}

int arr[] = { 0, 1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, };

int main(int argc, char *argv[])
{
	int i = atoi(argv[1]);

	printf("%d[arr] = %d\n", i, foo(arr, i));
	return 0;
}
