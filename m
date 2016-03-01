From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch 10/20] cpu/hotplug: Make target state writeable
Date: Tue, 01 Mar 2016 02:53:07 +0100
Message-ID: <1663539.5mkFR3orCE@vostro.rjw.lan>
References: <20160226164321.657646833@linutronix.de> <alpine.DEB.2.11.1602281545140.3638@nanos> <alpine.DEB.2.11.1602291648210.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64241 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750754AbcCABv2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 20:51:28 -0500
In-Reply-To: <alpine.DEB.2.11.1602291648210.3638@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Sebastian Siewior <bigeasy@linutronix.de>, Paul Turner <pjt@google.com>

On Monday, February 29, 2016 04:49:24 PM Thomas Gleixner wrote:
> On Sun, 28 Feb 2016, Thomas Gleixner wrote:
> > 
> > Understood. I'll fix that thing up so that won't happen and I put it on the
> > list of things to look at deeper.
> 
> The below delta patch should do what you need, right?

Yup, thanks!

Rafael


> 8<-------------
> 
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1461,6 +1461,11 @@ static ssize_t write_cpuhp_target(struct
>  	if (target != CPUHP_OFFLINE && target != CPUHP_ONLINE)
>  		return -EINVAL;
>  #endif
> +
> +	ret = lock_device_hotplug_sysfs();
> +	if (ret)
> +		return ret;
> +
>  	mutex_lock(&cpuhp_state_mutex);
>  	sp = cpuhp_get_step(target);
>  	ret = !sp->name || sp->cant_stop ? -EINVAL : 0;
> @@ -1472,6 +1477,8 @@ static ssize_t write_cpuhp_target(struct
>  		ret = do_cpu_up(dev->id, target);
>  	else
>  		ret = do_cpu_down(dev->id, target);
> +
> +	unlock_device_hotplug();
>  	return ret ? ret : count;
>  }
