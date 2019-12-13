From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Date: Fri, 13 Dec 2019 11:47:06 +0100
Message-ID: <20191213104706.xnpqaehmtean3mkd@ltop.local>
References: <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191212205338.GB11802@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 12, 2019 at 09:53:38PM +0100, Peter Zijlstra wrote:
> Now, looking at the current GCC source:
> 
>   https://github.com/gcc-mirror/gcc/blob/97d7270f894395e513667a031a0c309d1819d05e/gcc/c/c-parser.c#L3707
> 
> it seems that __typeof__() is supposed to strip all qualifiers from
> _Atomic types. That lead me to try:
> 
> 	typeof(_Atomic typeof(p)) __p = (p);
> 
> But alas, I still get the same junk you got for ool_store_release() :/

I was checking this to see if Sparse was ready to support this.
I was a bit surprised because at first sigth GCC was doing as
it claims (typeof striping const & volatile on _Atomic types)
but your exampe wasn't working. But it's working if an
intermediate var is used:
	_Atomic typeof(p) tmp;
	typeof(tmp) __p = (p);
or, uglier but probably more practical:
	typeof(({_Atomic typeof(p) tmp; })) __p = (p);

Go figure!

OTOH, at least on GCC 8.3, it seems to always do the same with
volatiles than it does with consts.

-- Luc Van Oostenryck
