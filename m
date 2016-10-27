From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: S3 resume regression [1cf4f629d9d2 ("cpu/hotplug: Move online
 calls to hotplugged cpu")]
Date: Thu, 27 Oct 2016 23:37:45 +0300
Message-ID: <20161027203745.GH4617@intel.com>
References: <20160526183207.GX4329@intel.com>
 <CAJZ5v0in8YwMBgLd6=KgGVc-f2yVvutOJG_u05OKLK7_EzN0yQ@mail.gmail.com>
 <20160531072650.GP4329@intel.com>
 <20160713145425.GB4329@intel.com>
 <CA++bM2sLMDLdeyLd_gpknTj+Y5xMk261SvivU5YxTnL0jRZovA@mail.gmail.com>
 <20160809172057.GZ4329@intel.com>
 <20161027172852.GE4617@intel.com>
 <alpine.DEB.2.20.1610272035180.4913@nanos>
 <20161027192006.GF4617@intel.com>
 <alpine.DEB.2.20.1610272122510.4913@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610272122510.4913@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Feng Tang <feng.79.tang@gmail.com>, feng.tang@intel.com, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Peter Zijlstra <peterz@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Turner <pjt@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 27, 2016 at 09:25:05PM +0200, Thomas Gleixner wrote:
> On Thu, 27 Oct 2016, Ville Syrjälä wrote:
> > On Thu, Oct 27, 2016 at 08:48:57PM +0200, Thomas Gleixner wrote:
> > > What that old patch did, was:
> > > 
> > > 1) Make sure that the broadcast device is actually armed at resume.
> > > 
> > >    That might cause the HPET to resume proper.
> > > 
> > > 2) Force a max. 3 seconds rearm when the targeted expiry time is > than 10
> > >    seconds
> > > 
> > >    That might make sure that lower C-States are never entered.
> > 
> > Doh. I lost the other hunk somewhere. Let's try that again... And indeed
> > with the other hunk in tow the machine would appear to resume properly.
> 
> So it would be interesting whether that hunk in resume_broadcast() is
> sufficient.

So far it looks like the answer is yes.

Looks to be about 5 seconds slower than acpi-idle in resuming, but
I suppose that's not all that surprising ;)

>  
> > > What's the lowest C-State with acpi-idle and what's the lowest one with
> > > intel_idle?
> > 
> > acpi_idle
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH INTEL MWAIT 0x30
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:100
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:200
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/time:5677316
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:5920
> > 
> > intel_idle:
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/desc:MWAIT 0x30
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/disable:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/latency:100
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/name:C4-ATM
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/power:0
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/residency:400
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/time:7146705
> > /sys/devices/system/cpu/cpu0/cpuidle/state3/usage:6826
> 
> Does the machine work, when you limit intel idle to C3, which would then
> match acpi idle ?

I'm pretty sure I had tested all of these, but I just double checked
to make sure. There's no C3 with intel_idle so I limited to C2, but
that did not help.

Isn't it possible that ACPI C3 is in fact C4? I thought ACPI C-states
are always numbered non-sparsely, and in this case ACPI C3 could be
anything from C3 to C11 (if the processor actually supported such
states obviously). Actually now that I look at the descriptions for
the states in sysfs, it says "MWAIT 0x30" for state3 on both drivers,
which I presume means it's in fact C4 for both.

-- 
Ville Syrjälä
Intel OTC
