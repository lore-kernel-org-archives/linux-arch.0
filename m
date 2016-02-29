From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Mon, 29 Feb 2016 16:49:24 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602291648210.3638@nanos>
References: <20160226164321.657646833@linutronix.de> <6355023.m2RKuauZef@vostro.rjw.lan> <alpine.DEB.2.11.1602270823480.3638@nanos> <1490843.2y32Taz9fS@vostro.rjw.lan> <alpine.DEB.2.11.1602281545140.3638@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41230 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcB2PvD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 10:51:03 -0500
In-Reply-To: <alpine.DEB.2.11.1602281545140.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Sun, 28 Feb 2016, Thomas Gleixner wrote:
> 
> Understood. I'll fix that thing up so that won't happen and I put it on the
> list of things to look at deeper.

The below delta patch should do what you need, right?

Thanks,

	tglx

8<-------------

--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1461,6 +1461,11 @@ static ssize_t write_cpuhp_target(struct
 	if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)
 		return -EINVAL;
 #endif
+
+	ret = lock_device_hotplug_sysfs();
+	if (ret)
+		return ret;
+
 	mutex_lock(&cpuhp_state_mutex);
 	sp = cpuhp_get_step(target);
 	ret = !sp->name || sp->cant_stop ? -EINVAL : 0;
@@ -1472,6 +1477,8 @@ static ssize_t write_cpuhp_target(struct
 		ret = do_cpu_up(dev->id, target);
 	else
 		ret = do_cpu_down(dev->id, target);
+
+	unlock_device_hotplug();
 	return ret ? ret : count;
 }
 
