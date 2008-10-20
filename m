From: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Mon, 20 Oct 2008 16:47:23 -0700
Message-ID: <1224546444.7092.58.camel@localhost.localdomain>
References: <20081016232729.699004293@polymtl.ca>
	 <20081016234657.837704867@polymtl.ca>
	 <alpine.LFD.2.00.0810161701470.3288@nehalem.linux-foundation.org>
	 <20081017012835.GA30195@Krystal>
	 <57C9024A16AD2D4C97DC78E552063EA3532D455F@orsmsx505.amr.corp.intel.com>
	 <20081017172515.GA9639@goodmis.org>
	 <57C9024A16AD2D4C97DC78E552063EA3533458AC@orsmsx505.amr.corp.intel.com>
	 <20081017184215.GB9874@Krystal>
	 <alpine.LFD.2.00.0810201256350.3518@nehalem.linux-foundation.org>
	 <1f1b08da0810201438g6a109af5i75b34841462b655d@mail.gmail.com>
	 <alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754674AbYJTXrs@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Mon, 2008-10-20 at 15:06 -0700, Linus Torvalds wrote:
> 
> On Mon, 20 Oct 2008, john stultz wrote:
> > 
> > I'm not quite sure I followed your per-cpu xtime thoughts.  Could you
> > explain further your thinking as to why the entire timekeeping
> > subsystem should be per-cpu instead of just keeping that back in the
> > arch-specific clocksource implementation?  In other words, why keep
> > things synced at the nanosecond level instead of keeping the per-cpu
> > TSC synched at the cycle level?
> 
> I don't think you can kep them sync'ed without taking frequency drift into 
> account. When you have multiple boards (ie big boxes), they simply _will_ 
> be in different clock domains. They won't have the exact same frequency.
> 
> So the "rewrite the TSC every once in a while" approach (where "after 
> coming out of idle" is just a special case of "once in a while" due to 
> many CPU's losing TSC in idle) works well in the kind of situation where 
> you really only have a single clock domain, and the TSC's are all 
> basically from the same reference clock. And that's a common case, but it 
> certainly isn't the _only_ case.
> 
> What about fundamnetally different frequencies (old TSC's that change with 
> cpufreq)? Or what about just subtle different ones (new TSC's but on 
> separate sockets that use separate external clocks)?

Ok. Thanks, the clarification about dealing with the multiple frequency
domains helps me understand what you're looking for and why per-cpu time
bases would be needed.

I was assuming that we were just looking at the single frequency domain,
but unsynced TSCs due to idle halting (or maybe just very slight
frequency skew).

<snip>
> Oh, I'm sure you can do hacky things, and work around known issues, and 
> consider the TSC to be globally stable in a lot of common schenarios. 
> That's what you get by re-syncing after idle etc. And it's going to work 
> in a lot of situations.

Yea, and indeed this is path we've been on, because folks have had quite
a bit of difficulty getting the single freq domain solution working. So
small hacks have been added over time, hoping to get there for just one
freq.

> But it's not going to solve the "hey, I have 512 CPU's, they are all on 
> different boards, and no, they are _not_ synchronized to one global 
> clock!".

Yep. And for now we dodge that by pushing to use an stable global
clocksource like HPET for these cases, at the cost of performance.


> That's why I'd suggest making _purely_ local time, and then aiming for 
> something NTP-like. But maybe there are better solutions out there.

The difficulty with NTP-like, is distributed systems tend to expect
slight deltas between machines. Userland gettimeofday() users do not
expect detectable skew between cpus.

Getting that last part right without those "at least don't go backwards"
hacks is hard.

I'll keep thinking about it.

thanks
-john
