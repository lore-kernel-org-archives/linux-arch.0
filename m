From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Mon, 7 Nov 2016 13:49:37 +0200
Message-ID: <20161107114937.GX4617@intel.com>
References: <20160809172057.GZ4329@intel.com>
 <20161027172852.GE4617@intel.com>
 <alpine.DEB.2.20.1610272035180.4913@nanos>
 <20161027192006.GF4617@intel.com>
 <alpine.DEB.2.20.1610272122510.4913@nanos>
 <20161027203745.GH4617@intel.com>
 <alpine.DEB.2.20.1610272238390.4913@nanos>
 <20161028155603.GI4617@intel.com>
 <alpine.DEB.2.20.1610282049500.5053@nanos>
 <20161101204737.GB4617@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:24535 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbcKGLtq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Nov 2016 06:49:46 -0500
Content-Disposition: inline
In-Reply-To: <20161101204737.GB4617@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>

On Tue, Nov 01, 2016 at 10:47:37PM +0200, Ville Syrjälä wrote:
> On Fri, Oct 28, 2016 at 08:58:41PM +0200, Thomas Gleixner wrote:
> > On Fri, 28 Oct 2016, Ville Syrjälä wrote:
> > > On Thu, Oct 27, 2016 at 10:41:18PM +0200, Thomas Gleixner wrote:
> > > > On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> > > > > On Thu, Oct 27, 2016 at 09:25:05PM +0200, Thomas Gleixner wrote:
> > > > > > So it would be interesting whether that hunk in resume_broadcast() is
> > > > > > sufficient.
> > > > > 
> > > > > So far it looks like the answer is yes.
> > > > > 
> > > > > Looks to be about 5 seconds slower than acpi-idle in resuming, but
> > > > > I suppose that's not all that surprising ;)
> > > > 
> > > > Well, set it to 1msec then. If that works reliably then we really can do
> > > > that unconditionally. There is no harm in firing a useless timer during
> > > > resume once.
> > > 
> > > I narrowed down the required timeout, and looks like 25ms is the
> > > minimum that works. With 24ms I already started to have failures. So
> > > maybe just bump it up by an order of magnitude to 250ms for some
> > > safety margin?
> 
> I left the thing running for the weekend and it failed 26 out of 16057
> times with the 25ms timeout. Looks like it takes ~5 minutes to resume
> when it fails, but eventually it does come back.
> 
> > 
> > Sure, but what puzzles me is that we need a timeout that big. What happens
> > between broadcast_resume() and broadcast_resume() + 25ms?
> > 
> > IOW, what is the event/resume function which we need to bridge. We should
> > really try to track than down.
> 
> My hunch would be that SMM trap in the DSDT/SSDT since that's where
> things ended up last time I was tracing these resume problems. Though I
> can't recall if that was just with acpi-idle or if intel_idle landed in
> the same spot as well.
> 
> I guess I can try to repeat that test tomorrow, or I'll try your function
> tracer method if the other thing fails.

I didn't manage to find a lot of time to play around with this, but it
definitely looks like the SMM trap is the problem here. I repeated my
pm_trace experiemnts and when it gets stuck it is trying to execute the
_WAK ACPI method which is where the SMM trap happens.

Maybe the SMM code was written with the expectation of a periodic tick
or something like that?

> 
> > 
> > You might try to enable function tracing and do a tracing_off() when that
> > 25ms timeout fires.
> > 
> > Something like 
> > 
> > 	stop_trace = true;
> > 
> > in broadcast_resume() and then in the broadcast timer function:
> > 
> > 	if (stop_trace) {
> > 		stop_trace = false;
> > 		tracing_off();
> > 	}
> > 
> > Then when the machine is up read the trace, compress and upload it
> > somewhere or send it in private mail if it's not that big.
> > 
> > Thanks,
> > 
> > 	tglx
> 
> 
> -- 
> Ville Syrjälä
> Intel OTC

-- 
Ville Syrjälä
Intel OTC
