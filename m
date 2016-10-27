From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Thu, 27 Oct 2016 22:41:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610272238390.4913@nanos>
References: <20160526183207.GX4329@intel.com> <CAJZ5v0in8YwMBgLd6=KgGVc-f2yVvutOJG_u05OKLK7_EzN0yQ@mail.gmail.com> <20160531072650.GP4329@intel.com> <20160713145425.GB4329@intel.com> <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com>
 <20160809172057.GZ4329@intel.com> <20161027172852.GE4617@intel.com> <alpine.DEB.2.20.1610272035180.4913@nanos> <20161027192006.GF4617@intel.com> <alpine.DEB.2.20.1610272122510.4913@nanos> <20161027203745.GH4617@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-18361705-1477600880=:4913"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027203745.GH4617@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-18361705-1477600880=:4913
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> On Thu, Oct 27, 2016 at 09:25:05PM +0200, Thomas Gleixner wrote:
> > So it would be interesting whether that hunk in resume_broadcast() is
> > sufficient.
> 
> So far it looks like the answer is yes.
> 
> Looks to be about 5 seconds slower than acpi-idle in resuming, but
> I suppose that's not all that surprising ;)

Well, set it to 1msec then. If that works reliably then we really can do
that unconditionally. There is no harm in firing a useless timer during
resume once.

> > Does the machine work, when you limit intel idle to C3, which would then
> > match acpi idle ?
> 
> I'm pretty sure I had tested all of these, but I just double checked
> to make sure. There's no C3 with intel_idle so I limited to C2, but
> that did not help.
> 
> Isn't it possible that ACPI C3 is in fact C4? I thought ACPI C-states
> are always numbered non-sparsely, and in this case ACPI C3 could be
> anything from C3 to C11 (if the processor actually supported such
> states obviously). Actually now that I look at the descriptions for
> the states in sysfs, it says "MWAIT 0x30" for state3 on both drivers,
> which I presume means it's in fact C4 for both.

Indeed.

Thanks,

	tglx
--8323329-18361705-1477600880=:4913--
