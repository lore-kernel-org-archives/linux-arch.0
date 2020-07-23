From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [EXT] Re: [PATCH v4 00/13] "Task_isolation" mode
Date: Thu, 23 Jul 2020 17:48:20 +0200
Message-ID: <20200723154820.GA709@worktop.programming.kicks-ass.net>
References: <04be044c1bcd76b7438b7563edc35383417f12c8.camel@marvell.com>
 <87imeextf3.fsf@nanos.tec.linutronix.de>
 <20200723142902.GT5523@worktop.programming.kicks-ass.net>
 <670609a91be23ebb4f179850601439fbed844479.camel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <670609a91be23ebb4f179850601439fbed844479.camel@marvell.com>
Sender: netdev-owner@vger.kernel.org
To: Alex Belits <abelits@marvell.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, Prasun Kapoor <pkapoor@marvell.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "frederic@kernel.org" <frederic@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 23, 2020 at 03:41:46PM +0000, Alex Belits wrote:
> 
> On Thu, 2020-07-23 at 16:29 +0200, Peter Zijlstra wrote:
> > .
> > 
> > This.. as presented it is an absolutely unreviewable pile of junk. It
> > presents code witout any coherent problem description and analysis.
> > And
> > the patches are not split sanely either.
> 
> There is a more complete and slightly outdated description in the
> previous version of the patch at 
> https://lore.kernel.org/lkml/07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com/

Not the point, you're mixing far too many things in one go. You also
have the patches split like 'generic / arch-1 / arch-2' which is wrong
per definition, as patches should be split per change and not care about
sily boundaries.

Also, if you want generic entry code, there's patches for that here:

  https://lkml.kernel.org/r/20200722215954.464281930@linutronix.de
