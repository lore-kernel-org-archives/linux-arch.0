From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Sat, 27 Feb 2016 08:39:42 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602270823480.3638@nanos>
References: <20160226164321.657646833@linutronix.de> <20160226182341.022814799@linutronix.de> <6355023.m2RKuauZef@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35318 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcB0HlR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 27 Feb 2016 02:41:17 -0500
In-Reply-To: <6355023.m2RKuauZef@vostro.rjw.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

Rafael,

On Sat, 27 Feb 2016, Rafael J. Wysocki wrote:
> On Friday, February 26, 2016 06:43:32 PM Thomas Gleixner wrote:
> > Make it possible to write a target state to the per cpu state file, so we can
> > switch between states.
> 
> One thing that potentially may be problematic here is that any kind of
> "offline" operations needs to be carried out under device_hotplug_lock,
> because there are cases in which devices (including CPUs) are taken
> offline in groups and if one offline fails, the whole operation has to
> be rolled back.
>
> So if you put a CPU into one of the intermediate states manually and
> something like the above happens in parallel with it, they may not
> play well together IMO.

I don't see how that is related. device_hotplug_lock is completely independent
of cpu hotplug today, unless I'm missing some magic connection here.

Physical CPU hotplug is a different story, but that's about bringing the cpus
into the system or taking them out. Sure, if you want to take one or more cpus
physically out, you have to bring them offline first. If you plug them in then
it's not necessarily related to actually bringing them online. That's a
different set of operations.

We surely need to look into that aspect, but I don't see a reason why e.g. a
device hotplug operation should be in any way related to the intermediate
state of a particular cpu. If that's the case, then there is something really
wrong.

I'm aware that we have a gazillion of silly assumptions all over the place and
some of them are wrong today and just do not explode in our face simply
because it's extremly hard to trigger. That's one reason why we need to go
through all the cpu notifier related sites and inspect them deeply.

Thanks,

	tglx
