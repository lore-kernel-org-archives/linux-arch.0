From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Fri, 28 Oct 2016 20:58:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610282049500.5053@nanos>
References: <20160531072650.GP4329@intel.com> <20160713145425.GB4329@intel.com> <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com> <20160809172057.GZ4329@intel.com> <20161027172852.GE4617@intel.com> <alpine.DEB.2.20.1610272035180.4913@nanos>
 <20161027192006.GF4617@intel.com> <alpine.DEB.2.20.1610272122510.4913@nanos> <20161027203745.GH4617@intel.com> <alpine.DEB.2.20.1610272238390.4913@nanos> <20161028155603.GI4617@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-621006073-1477681124=:5053"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028155603.GI4617@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-621006073-1477681124=:5053
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 28 Oct 2016, Ville Syrjälä wrote:
> On Thu, Oct 27, 2016 at 10:41:18PM +0200, Thomas Gleixner wrote:
> > On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> > > On Thu, Oct 27, 2016 at 09:25:05PM +0200, Thomas Gleixner wrote:
> > > > So it would be interesting whether that hunk in resume_broadcast() is
> > > > sufficient.
> > > 
> > > So far it looks like the answer is yes.
> > > 
> > > Looks to be about 5 seconds slower than acpi-idle in resuming, but
> > > I suppose that's not all that surprising ;)
> > 
> > Well, set it to 1msec then. If that works reliably then we really can do
> > that unconditionally. There is no harm in firing a useless timer during
> > resume once.
> 
> I narrowed down the required timeout, and looks like 25ms is the
> minimum that works. With 24ms I already started to have failures. So
> maybe just bump it up by an order of magnitude to 250ms for some
> safety margin?

Sure, but what puzzles me is that we need a timeout that big. What happens
between broadcast_resume() and broadcast_resume() + 25ms?

IOW, what is the event/resume function which we need to bridge. We should
really try to track than down.

You might try to enable function tracing and do a tracing_off() when that
25ms timeout fires.

Something like 

	stop_trace = true;

in broadcast_resume() and then in the broadcast timer function:

	if (stop_trace) {
		stop_trace = false;
		tracing_off();
	}

Then when the machine is up read the trace, compress and upload it
somewhere or send it in private mail if it's not that big.

Thanks,

	tglx
--8323329-621006073-1477681124=:5053--
