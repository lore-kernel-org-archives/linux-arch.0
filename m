From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Thu, 2 Jul 2020 11:00:42 -0700
Message-ID: <20200702180042.GW9247@paulmck-ThinkPad-P72>
References: <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <20200701091054.GW4781@hirez.programming.kicks-ass.net>
 <4427b0f825324da4b1640e32265b04bd@AcuMS.aculab.com>
 <20200701160624.GO9247@paulmck-ThinkPad-P72>
 <aeed740a4d86470d84ae7d5f1cf07951@AcuMS.aculab.com>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aeed740a4d86470d84ae7d5f1cf07951@AcuMS.aculab.com>
Sender: linux-pci-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 02, 2020 at 09:37:26AM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 01 July 2020 17:06
> ...
> > > Would an asm statement that uses the same 'register' for input and
> > > output but doesn't actually do anything help?
> > > It won't generate any code, but the compiler ought to assume that
> > > it might change the value - so can't do optimisations that track
> > > the value across the call.
> > 
> > It might replace the volatile load, but there are optimizations that
> > apply to the downstream code as well.
> > 
> > Or are you suggesting periodically pushing the dependent variable
> > through this asm?  That might work, but it would be easier and
> > more maintainable to just mark the variable.
> 
> Marking the variable requires compiler support.
> Although what 'volatile register int foo;' means might be interesting.
> 
> So I was thinking that in the case mentioned earlier you do:
> 	ptr += LAUNDER(offset & 1);
> to ensure the compiler didn't convert to:
> 	if (offset & 1) ptr++;
> (Which is probably a pessimisation - the reverse is likely better.)

Indeed, Akshat's prototype follows the "volatile" qualifier in many
ways.  https://github.com/AKG001/gcc/

							Thanx, Paul
