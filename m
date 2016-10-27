From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Thu, 27 Oct 2016 21:25:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610272122510.4913@nanos>
References: <573BA5E2.5040506@intel.com> <20160518072424.GU4329@intel.com> <20160526183207.GX4329@intel.com> <CAJZ5v0in8YwMBgLd6=KgGVc-f2yVvutOJG_u05OKLK7_EzN0yQ@mail.gmail.com> <20160531072650.GP4329@intel.com> <20160713145425.GB4329@intel.com>
 <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com> <20160809172057.GZ4329@intel.com> <20161027172852.GE4617@intel.com> <alpine.DEB.2.20.1610272035180.4913@nanos> <20161027192006.GF4617@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1968387829-1477596307=:4913"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20161027192006.GF4617@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1968387829-1477596307=:4913
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> On Thu, Oct 27, 2016 at 08:48:57PM +0200, Thomas Gleixner wrote:
> > What that old patch did, was:
> > 
> > 1) Make sure that the broadcast device is actually armed at resume.
> > 
> >    That might cause the HPET to resume proper.
> > 
> > 2) Force a max. 3 seconds rearm when the targeted expiry time is > than 10
> >    seconds
> > 
> >    That might make sure that lower C-States are never entered.
> 
> Doh. I lost the other hunk somewhere. Let's try that again... And indeed
> with the other hunk in tow the machine would appear to resume properly.

So it would be interesting whether that hunk in resume_broadcast() is
sufficient.
 
> > What's the lowest C-State with acpi-idle and what's the lowest one with
> > intel_idle?
> 
> acpi_idle
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH INTEL MWAIT 0x30
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:100
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:200
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:5677316
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:5920
> 
> intel_idle:
> /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:MWAIT 0x30
> /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:100
> /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C4-ATM
> /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:400
> /sys/devices/system/cpu/cpu0/cpuidle/state3/time:7146705
> /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:6826

Does the machine work, when you limit intel idle to C3, which would then
match acpi idle ?

Thanks,

	tglx
--8323329-1968387829-1477596307=:4913--
