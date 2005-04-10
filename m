Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 10 Apr 2005 00:23:57 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: [patch] sched: unlocked context-switches
Message-ID: <20050410072357.GA2155@twiddle.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F033DB07E@scsmsx401.amr.corp.intel.com> <20050409043848.GA2677@elte.hu> <1113038543.9568.430.camel@gaston> <20050409154612.55d6a6fa.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409154612.55d6a6fa.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mingo@elte.hu, tony.luck@intel.com, linux-kernel@vger.kernel.org, akpm@osdl.org, nickpiggin@yahoo.com.au, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Apr 09, 2005 at 03:46:12PM -0700, David S. Miller wrote:
> On Sat, 09 Apr 2005 19:22:23 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > ppc64 already has a local_irq_save/restore in switch_to, around the low
> > level asm bits, so it should be fine.
> 
> Sparc64 essentially does as well.  In fact, it uses an IRQ disable
> which is stronger  than local_irq_save in that it disables reception
> of CPU cross-calls as well.

Alpha does the switch in PALmode, which is never interruptable.


r~
