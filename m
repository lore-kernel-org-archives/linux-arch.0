From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC][PATCH 00/31] implement atomic_fetch_$op
Date: Sat, 23 Apr 2016 11:23:41 +0800
Message-ID: <20160423032341.GB31398@wfg-t540p.sh.intel.com>
References: <20160422090413.393652501@infradead.org>
 <20160422094455.GO3430@twins.programming.kicks-ass.net>
 <20160422125656.GA15453@wfg-t540p.sh.intel.com>
 <874matxzj9.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32018 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbcDWDYA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 23:24:00 -0400
Content-Disposition: inline
In-Reply-To: <874matxzj9.fsf@purkki.adurom.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de

On Fri, Apr 22, 2016 at 09:35:06PM +0300, Kalle Valo wrote:
> Fengguang Wu <fengguang.wu@intel.com> writes:
> 
> >> OK, weirdness. I received the "BUILD SUCCESS" email without any arm64
> >> builds listed, but I just received a build bot email telling me the
> >> arm64 build was borked (which I know it is).
> >
> > Sorry, that may happen because even though most errors will be
> > detected in the first hour or before the BUILD SUCCESS/DONE
> > notification, the build/boot/performance tests for a particular branch
> > may continue for days, during the time test coverage keeps growing.
> > Which means it's possible to receive a build failure after receiving
> > BUILD SUCCESS notification.
> >
> > In particular, 0-day bot classify 500+ kconfigs into 2 priority lists:
> >
> > P1: 100+ realtime priority kconfigs which should be finished before sending
> >     out BUILD SUCCESS notification
> >
> > P2: 400+ background priority kconfigs which may take hours to days to finish
> >
> > That split is a tradeoff between timeliness and completeness. It turns
> > out to work well as long as we choose the suitable P1 list.
> >
> > So the more accurate interpretation of "BUILD SUCCESS/DONE" would be:
> > 0day bot is working on your tree (no worry about out-of-service) and
> > reached a major milestone.
> 
> Thanks, this is very useful information. But would it be also possible
> to get a report about the P2 completion (or failure)?

Good question! I'm not sure people would care (or even be confused)
about a report that arrive after days, however based on some statistic
data we may find the suitable time to wait for possible error reports.

The past reports show that about 60% errors are reported in 2 hours,
90% errors are reported in 24 hours and there are 1% errors reported
after 1 week.

So developers may reasonably wait for 1 day before sending out patches.

Thanks,
Fengguang
