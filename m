From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Sat, 27 Feb 2016 15:43:18 +0100
Message-ID: <1490843.2y32Taz9fS@vostro.rjw.lan>
References: <20160226164321.657646833@linutronix.de> <6355023.m2RKuauZef@vostro.rjw.lan> <alpine.DEB.2.11.1602270823480.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51107 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756331AbcB0Oln (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 09:41:43 -0500
In-Reply-To: <alpine.DEB.2.11.1602270823480.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Saturday, February 27, 2016 08:39:42 AM Thomas Gleixner wrote:
> Rafael,
> 
> On Sat, 27 Feb 2016, Rafael J. Wysocki wrote:
> > On Friday, February 26, 2016 06:43:32 PM Thomas Gleixner wrote:
> > > Make it possible to write a target state to the per cpu state file, so we can
> > > switch between states.
> > 
> > One thing that potentially may be problematic here is that any kind of
> > "offline" operations needs to be carried out under device_hotplug_lock,
> > because there are cases in which devices (including CPUs) are taken
> > offline in groups and if one offline fails, the whole operation has to
> > be rolled back.
> >
> > So if you put a CPU into one of the intermediate states manually and
> > something like the above happens in parallel with it, they may not
> > play well together IMO.
> 
> I don't see how that is related. device_hotplug_lock is completely independent
> of cpu hotplug today, unless I'm missing some magic connection here.

Well, there is a magic connection which is my point.  That's mostly about
physical hot-remove.

> Physical CPU hotplug is a different story, but that's about bringing the cpus
> into the system or taking them out. Sure, if you want to take one or more cpus
> physically out, you have to bring them offline first. If you plug them in then
> it's not necessarily related to actually bringing them online. That's a
> different set of operations.

So that's mostly about the hot-remove part.  Namely, devices may need to go
away together (like in one package), so we need to offline them together first.

That's because generally offline may fail, for example for memory, and now
if a CPU is bundled to a set of memory that cannot be taken offline, it
can't be hot-removed too.  If offline fails for one component, we roll back,
but if it is successful for all of them, we can eject the whole bundle and
that's where the problem resides.

Say we've taken all of them offline and now we are ready to eject.  If an
online from sysfs (or any other place) comes in at this point, we'll be
ejecting a CPU that's potentially doing something which is not awesome.

That's why we have device_hotplug_lock and some ugly code related to it.

It extends to parents and children somewhat because of device objects
representing packages (we want those to be "offline" only if all their
children are offline) and that's why the lock is held around offline from
sysfs too.

I'm not entirely happy with this for quite obvious reasons, but it gets
the job done ATM.

> We surely need to look into that aspect, but I don't see a reason why e.g. a
> device hotplug operation should be in any way related to the intermediate
> state of a particular cpu. If that's the case, then there is something really
> wrong.

If that state is different from complete offline, we should not try to eject
(the package containing) that CPU.

> I'm aware that we have a gazillion of silly assumptions all over the place and
> some of them are wrong today and just do not explode in our face simply
> because it's extremly hard to trigger. That's one reason why we need to go
> through all the cpu notifier related sites and inspect them deeply.

Agreed, but the particular concern I'm talking about is not in that category IMO.

Thanks,
Rafael
