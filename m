From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Tue, 21 Oct 2008 00:17:44 +0200
Message-ID: <20081020221744.GA30133@elte.hu>
References: <20081016234657.837704867@polymtl.ca> <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org> <20081017012835.GA30195@Krystal> <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com> <20081017172515.GA9639@goodmis.org> <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com> <20081017184215.GB9874@Krystal> <alpine.LFD.2.00.0810201256350.3518@nehalem.linux-foundation.org> <1f1b08da0810201438g6a109af5i75b34841462b655d@mail.gmail.com> <alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752121AbYJTWT0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: john stultz <johnstul@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> That's why I'd suggest making _purely_ local time, and then aiming for 
> something NTP-like. But maybe there are better solutions out there.

this 'fast local time' was the rough idea we tried to implement via the 
cpu_clock(cpu) interface.

cpu_clock() results are loosely coupled to xtime in every scheduler tick 
via the scd->tick_gtod logic.

( That way in a sense it tracks NTP time as well, if NTP is fed back 
  into GTOD, such as when ntpd is running. Granted, this is not the same 
  quality at all as if it did native NTP-alike corrections, but it at 
  least has a long-term stability. )

And it only ever does cross-CPU work if we specifically ask for a remote 
clock:

        if (cpu != raw_smp_processor_id()) {
                struct sched_clock_data *my_scd = this_scd();

                lock_double_clock(scd, my_scd);

it still does this "serialization looking" even in the local case:

                __raw_spin_lock(&scd->lock);
                clock = __update_sched_clock(scd, now);
        }

        __raw_spin_unlock(&scd->lock);

... but that lock is strictly per CPU, so it only matters if there _is_ 
cross-CPU "interest" in that clock. Otherwise these locks are in essence 
just per CPU and cause no cacheline bouncing, etc.

... but we could try to eliminate even that potential for any locking. 
On 64-bit it's a real possibility i think. (we need the lock for 32-bit 
mainly, the timestamps are all 64 bits)

... it also has all the tsc-stops-in-idle smarts, knows about cpufreq, 
etc. Those things are needed even on UP, to not get really bad 
transients in time.

That still leaves us with sched_clock() complexity, which has spread out 
a bit more than it should have. So it's not all as simple as you'd like 
it to be i think, but we are trying hard ...

Ideas to simplify/robustify it are welcome.

	Ingo
