From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sat, 3 May 2008 18:37:07 +0200
Message-ID: <20080503163707.GA16644@elte.hu>
References: <1209832169.6929.42.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764803AbYECQhk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1209832169.6929.42.camel@lappy>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Guillaume Chazarain <guichaz@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>, Dhaval Giani <dhaval@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hi,
> 
> This is my current proposal to replace the rq->clock stuff (and 
> possibly cpu_clock()).
> 
> it _DOESN'T_ boot ;-/ and I seem to have caught a flu that makes my 
> whole body hurt like hell, so I'm not getting anything done.

ouch - getter better soon!

> Brain dump before I crash:
> 
>  - architectures that have a 'perfect' hardware clock can set
>      CONFIG_HAVE_STABLE_CLOCK

ok.

>  - the 'jiffie' window might be superfulous when we update tick_gtod
>    before the __update_sched_clock() call in sched_clock_tick()
> 
>  - cpu_clock() might be implemented as:
> 
>      sched_clock_cpu(smp_processor_id())
> 
>    if the accuracy proves good enough - how far can TSC drift in a
>    single jiffie when considering the filtering and idle hooks?

it 'can' be very bad - so we have to assume it's random and fall back to 
jiffies quality in that case. In practice on most x86 CPUs it wont drift 
that far - even drifting TSCs drift minimally (there are AMD 
Athlon64/Opteron CPUs where a CPU in HLT will cause the clock and the 
TSC to drift a bit) - and stopping TSCs will just stop.

But in terms of BIOSes trying to fix things up and in terms of cpufreq 
artifacts (the CPU's clock itself going through transients) anything can 
happen and the code must be robust.
 
>  - what other architectures besides x86 would need this?

we rarely get any interactivity reports from anything non-x86 so i doubt 
it truly matters on anything but x86. If it _breaks_ in terms of 
crashing or locking we do hear from other architectures ;-)

	Ingo
