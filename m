From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v2 00/33] implement atomic_fetch_$op
Date: Wed, 8 Jun 2016 14:43:12 +0200
Message-ID: <20160608124312.GA30927@twins.programming.kicks-ass.net>
References: <20160531101925.702692792@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4EAF393@us01wembx1.internal.synopsys.com>
 <20160602093304.GX3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160602093304.GX3190@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 02, 2016 at 11:33:04AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 02, 2016 at 09:27:36AM +0000, Vineet Gupta wrote:

> > What's ur merge plan - are u going to rebase/respin once more so I can push those
> > updates to Linus for 4.7-rc2. Or you could carry those ARC patches in ur tree -
> > ahead of ur series. I'd much rather prefer the revert / cleanup before adding new
> > code which extends the back off code only to be deleted later.
> 
> I was hoping to get these into tip for v4.8, I can rebase on whatever
> changes you make in v4.7 no problem.

-rc2 seems to have happened and I cannot seem to find changes to
arc/atomic.h, will you still be pushing those patches this window or
should I queue my patches?
