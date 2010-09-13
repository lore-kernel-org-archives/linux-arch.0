From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Date: Mon, 13 Sep 2010 10:51:37 +0200
Message-ID: <20100913085137.GE23741@elte.hu>
References: <cover.1284357372.git.matt@console-pimps.org>
 <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl>
 <20100913075025.GA14882@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:57812 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507Ab0IMIv6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 04:51:58 -0400
Content-Disposition: inline
In-Reply-To: <20100913075025.GA14882@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Marc Titinger <mtittinge@hotmail.com>, robert.richter@amd.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, will.deacon@arm.com, acme@redhat.com, lethal@linux-sh.org, linux-arm-kernel@lists.infradead.org


* Matt Fleming <matt@console-pimps.org> wrote:

> On Mon, Sep 13, 2010 at 09:13:32AM +0200, Marc Titinger wrote:
> > 
> > Hi, 
> > 
> > I'm just being curious : do these patches change the way those chips 
> > should be supported, that do not have a PMU-like IP, but implement 
> > PC-sampling thanks to a general purpose timer (not the system timer) 
> > ?
> 
> CPUs that do not have a PMU are not required to use the perf-events 
> oprofile backend, it is entirely optional. The pc-sampling timer in 
> oprofile is not affected by this series.

It should still work fine though: a generalized oprofile backend should 
simply use hrtimer based events. That also has a chance to be higher 
quality than the system time fallback, on PMU-less (but high-res-timer 
capable) systems.

Thanks,

	Ingo
