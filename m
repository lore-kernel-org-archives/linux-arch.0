From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Thu, 30 Aug 2018 19:15:10 +0200
Message-ID: <20180830171510.GQ24082@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <1535640375.4465.68.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535640375.4465.68.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 30, 2018 at 02:46:16PM +0000, Eugeniy Paltsev wrote:
> On Thu, 2018-08-30 at 16:17 +0200, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 11:53:17AM +0000, Eugeniy Paltsev wrote:
> > > I can see crashes with LLSC enabled in both SMP running on 4 cores
> > > and SMP running on 1 core.
> > 
> > So you're running on LL/SC enabled hardware; that would make Will's
> > patch irrelevant (although still a good idea for the hardware that does
> > care about that spinlocked atomic crud).
> > 
> > Does something like the below cure things? That would confirm the
> > suggestion that the change to __clear_bit_unlock() is the curprit.
> 
> I tested it - this doesn't change anything, the problem still reproduces.

OK, 'good' :-)

> I'll test it with last Will fix.

Yes, that missing "bnz 1b" is very very suspect.
