From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [v9 PATCH 4/9]: x86: refactor x86 idle power management code
 and remove all instances of pm_idle.
Date: Mon, 26 Oct 2009 08:58:31 +0100
Message-ID: <20091026075831.GB22625@elf.ucw.cz>
References: <20091016093850.GB27350@linux.vnet.ibm.com>
 <20091016094308.GF27350@linux.vnet.ibm.com>
 <20091023160711.GB1431@ucw.cz>
 <20091026075550.GB17689@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58420 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148AbZJZH6d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Oct 2009 03:58:33 -0400
Content-Disposition: inline
In-Reply-To: <20091026075550.GB17689@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org


> > > +static int local_idle_loop(struct cpuidle_device *dev, struct cpuidle_state *st)
> > > +{
> > > +	ktime_t t1, t2;
> > > +	s64 diff;
> > > +	int ret;
> > > +
> > > +	t1 = ktime_get();
> > > +	local_idle();
> > > +	t2 = ktime_get();
> > > +
> > > +	diff = ktime_to_us(ktime_sub(t2, t1));
> > > +	if (diff > INT_MAX)
> > > +		diff = INT_MAX;
> > > +	ret = (int) diff;
> > > +
> > > +	return ret;
> > > +}
> > 
> > So we get this routine essentially 3 times. Is there no way to share
> > the code?
> > 
> 
> We can move this code to a common place, but that would mean exporting
> the idle function pointer to be called from within this routine, which
> is exactly what we wanted to avoid.
> 
> Any suggestions are welcome.

You can just pass idle routine as a parameter...?

int common_idle_loop(struct cpuidle_device *dev, struct cpuidle_state
*st, void *idle(void))

...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
