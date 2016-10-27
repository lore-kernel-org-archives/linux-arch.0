From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Thu, 27 Oct 2016 20:48:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610272035180.4913@nanos>
References: <20160511133406.GC4329@intel.com> <20160516193910.GL4329@intel.com> <573BA5E2.5040506@intel.com> <20160518072424.GU4329@intel.com> <20160526183207.GX4329@intel.com> <CAJZ5v0in8YwMBgLd6=KgGVc-f2yVvutOJG_u05OKLK7_EzN0yQ@mail.gmail.com>
 <20160531072650.GP4329@intel.com> <20160713145425.GB4329@intel.com> <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com> <20160809172057.GZ4329@intel.com> <20161027172852.GE4617@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1523702045-1477594139=:4913"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20161027172852.GE4617@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1523702045-1477594139=:4913
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> On Tue, Aug 09, 2016 at 08:20:57PM +0300, Ville Syrjälä wrote:
> > On Thu, Jul 14, 2016 at 04:29:42PM +0800, Feng Tang wrote:
> > > if you only want it to work, you can try an old patch
> > > https://bugzilla.kernel.org/attachment.cgi?id=76071 from a similar bug
> > > https://bugzilla.kernel.org/show_bug.cgi?id=41932
> > > 
> > > Alistair Buxton confirmed it work for 3.18 at least
> > > https://bugzilla.kernel.org/show_bug.cgi?id=107151#c16
> > 
> > That patch is a bit too ripe by now. Would need a fresh squeezed one.
> 
> Since no one else bothered to refresh the patch I did it myself:
> 
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index f6aae7977824..d73d094a8972 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -657,8 +657,16 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
>  	 * - There are pending events on sleeping CPUs which were not
>  	 * in the event mask
>  	 */
> -	if (next_event.tv64 != KTIME_MAX)
> +	if (next_event.tv64 != KTIME_MAX) {
> +		s64 delta = next_event.tv64 - now.tv64;
> +
> +		if (delta >= 10000000000) {
> +			printk(KERN_CRIT "%s(): The delta is big: %lld\n", __func__, delta);
> +			next_event.tv64 = now.tv64 + 3000000000;
> +		}
> +
>  		tick_broadcast_set_event(dev, next_cpu, next_event);
> +	}
>  
>  	raw_spin_unlock(&tick_broadcast_lock);
> 
> Unfortunately it doesn't do anything for me.

And I'm not surprised, because the original patch forced a 5 seconds event
in the broadcast device on resume, aside of limiting the reprogramming.

What that old patch did, was:

1) Make sure that the broadcast device is actually armed at resume.

   That might cause the HPET to resume proper.

2) Force a max. 3 seconds rearm when the targeted expiry time is > than 10
   seconds

   That might make sure that lower C-States are never entered.
 
> The fortunate thing is that acpi-idle has magically been fixed in the
> meantime, so I can at least go back to using that one and have working
> S3.

What's the lowest C-State with acpi-idle and what's the lowest one with
intel_idle?

Thanks,

	tglx
--8323329-1523702045-1477594139=:4913--
