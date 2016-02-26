From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Sat, 27 Feb 2016 00:46:18 +0100
Message-ID: <6355023.m2RKuauZef@vostro.rjw.lan>
References: <20160226164321.657646833@linutronix.de> <20160226182341.022814799@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46643 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755700AbcBZXon (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 18:44:43 -0500
In-Reply-To: <20160226182341.022814799@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

Hi Thomas,

On Friday, February 26, 2016 06:43:32 PM Thomas Gleixner wrote:
> Make it possible to write a target state to the per cpu state file, so we can
> switch between states.

One thing that potentially may be problematic here is that any kind of
"offline" operations needs to be carried out under device_hotplug_lock,
because there are cases in which devices (including CPUs) are taken
offline in groups and if one offline fails, the whole operation has to
be rolled back.

So if you put a CPU into one of the intermediate states manually and
something like the above happens in parallel with it, they may not
play well together IMO.

Thanks,
Rafael
