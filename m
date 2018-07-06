From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Date: Fri, 6 Jul 2018 21:22:15 +0800
Message-ID: <20180706132215.GB30265@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180705180503.GH2530@hirez.programming.kicks-ass.net>
 <20180706060740.GB8707@guoren>
 <20180706093932.GT2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706093932.GT2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 06, 2018 at 11:39:32AM +0200, Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 02:07:40PM +0800, Guo Ren wrote:
> 
> > > Please explain those mb()'s... I'm thinking you meant to use smp_mb().
> > Yes, smp_mb(). Current smp_mb()&mb() is the same: sync.is.
> > 
> > In next version patch, I'll seperate smp_mb() and mb() and use ld/st.barrier
> > instead of sync.is. Sync.is is expensive that it flush cpu's pipeline.
> 
> I'll second my own call for documentation, because now there's three
> memory ordering instructions:
> 
>  "SYNC", "SYNC.IS" and "LD/ST.BARRIER"
> 
> None of which have yet been explained.
In C-SKY there are:

sync:        completion barrier
sync.s:      completion barrier and shareable to other cores
sync.i:      completion barrier with flush cpu pipeline
sync.is:     completion barrier with flush cpu pipeline and shareable to other cores 

bar.brwarw:  ordering barrier for all load/store instructions before it
bar.brwarws: ordering barrier for all load/store instructions before it and shareable to other cores
bar.brar:    ordering barrier for all load       instructions before it
bar.brars:   ordering barrier for all load       instructions before it and shareable to other cores
bar.bwaw:    ordering barrier for all store      instructions before it
bar.bwaws:   ordering barrier for all store      instructions before it and shareable to other cores
