Return-Path: <SRS0=KQoP=AO=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCOvw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:51:52 -0400
Date: Fri, 3 Jul 2020 07:51:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200703145151.GG9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <CANpmjNP+7TtE0WPU=nX5zs3T2+4hPkkm08meUm2VDVY3RgsHDw@mail.gmail.com>
 <20200701114027.GO4800@hirez.programming.kicks-ass.net>
 <20200701140654.GL9247@paulmck-ThinkPad-P72>
 <20200701150512.GH4817@hirez.programming.kicks-ass.net>
 <20200701160338.GN9247@paulmck-ThinkPad-P72>
 <20200702082040.GB4781@hirez.programming.kicks-ass.net>
 <20200702175948.GV9247@paulmck-ThinkPad-P72>
 <20200703131330.GX4800@hirez.programming.kicks-ass.net>
 <20200703132523.GM117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703132523.GM117543@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200703145151.SkrBX_5V0JDSXERcyM_rRb_5Qlc8PondFHBpF0sE0yU@z>

On Fri, Jul 03, 2020 at 03:25:23PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2020 at 03:13:30PM +0200, Peter Zijlstra wrote:
> > > The prototype for GCC is here: https://github.com/AKG001/gcc/
> > 
> > Thanks! Those test cases are somewhat over qualified though:
> > 
> >        static volatile _Atomic (TYPE) * _Dependent_ptr a;     		\
> 
> One question though; since its a qualifier, and we've recently spend a
> whole lot of effort to strip qualifiers in say READ_ONCE(), how does,
> and how do we want, this qualifier to behave.

Dereferencing a _Dependent_ptr pointer gives you something that is not
_Dependent_ptr, unless the declaration was like this:

	_Dependent_ptr _Atomic (TYPE) * _Dependent_ptr a;

And if I recall correctly, the current state is that assigning a
_Dependent_ptr variable to a non-_Dependent_ptr variable strips this
marking (though the thought was to be able to ask for a warning).

So, yes, it would be nice to be able to explicitly strip the
_Dependent_ptr, perhaps the kill_dependency() macro, which is already
in the C standard.

> C++ has very convenient means of manipulating qualifiers, so it's not
> much of a problem there, but for C it is, as we've found, really quite
> cumbersome. Even with _Generic() we can't manipulate individual
> qualifiers afaict.

Fair point, and in C++ this is a templated class, at least in the same
sense that std::atomic<> is a templated class.

But in this case, would kill_dependency do what you want?

							Thanx, Paul
