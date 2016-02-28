From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Sun, 28 Feb 2016 15:49:33 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602281545140.3638@nanos>
References: <20160226164321.657646833@linutronix.de> <6355023.m2RKuauZef@vostro.rjw.lan> <alpine.DEB.2.11.1602270823480.3638@nanos> <1490843.2y32Taz9fS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490843.2y32Taz9fS@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>
List-Id: linux-arch.vger.kernel.org

Rafael,

On Sat, 27 Feb 2016, Rafael J. Wysocki wrote:
> Say we've taken all of them offline and now we are ready to eject.  If an
> online from sysfs (or any other place) comes in at this point, we'll be
> ejecting a CPU that's potentially doing something which is not awesome.
> 
> That's why we have device_hotplug_lock and some ugly code related to it.
> 
> It extends to parents and children somewhat because of device objects
> representing packages (we want those to be "offline" only if all their
> children are offline) and that's why the lock is held around offline from
> sysfs too.
> 
> I'm not entirely happy with this for quite obvious reasons, but it gets
> the job done ATM.

Understood. I'll fix that thing up so that won't happen and I put it on the
list of things to look at deeper.

Thanks,

	tglx
