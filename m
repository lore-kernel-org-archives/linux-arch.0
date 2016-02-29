From: Will Deacon <will.deacon@arm.com>
Subject: Re: [patch 01/20] idle: Move x86ism out of generic code
Date: Mon, 29 Feb 2016 19:48:10 +0000
Message-ID: <20160229194810.GI14848@arm.com>
References: <20160226164321.657646833@linutronix.de>
 <20160226182340.242063758@linutronix.de>
 <CAMzpN2j=Nb25x6UQqa6r3UbWgrrhoRb-72U+zOFVA7RrqQ0Z3A@mail.gmail.com>
 <alpine.DEB.2.11.1602292026050.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47050 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328AbcB2TsD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 14:48:03 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602292026050.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Brian Gerst <brgerst@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Mon, Feb 29, 2016 at 08:35:41PM +0100, Thomas Gleixner wrote:
> On Sat, 27 Feb 2016, Brian Gerst wrote:
> > >         arch_cpu_idle_prepare();
> > >         cpu_idle_loop();
> > >  }
> > 
> > Does this actually work with stack protector enabled?
> > boot_init_stack_canary() is inlined while arch_cpu_idle_prepare() is
> > not.
> 
> Stupid me. No it does of course not. I could have sworn that I tested that,
> but obvioulsy not.
> 
> I drop that patch, but actually the real question is whether we can drop that
> '#ifdef x86' around that boot_init_stack_canary() invocation.
> 
> AFAICT, neither arm, arm64 nor mips and sh call it on anything else than the
> boot cpu. I can't see why that would be an issue on those architectures and
> why it would be a problem if the boot cpu calls it again here.
> 
> CC'ed the relevant maintainers. Is there any issue with the patch below?

On arm[64], the canary is unfortunately global, so I don't think it would
be safe to update it live like this without effectively stopping the
machine and forcing everybody into idle.

Will
