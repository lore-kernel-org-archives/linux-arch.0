From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
Date: Mon, 13 Sep 2010 12:04:44 +0100
Message-ID: <20100913110444.GB14882@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org> <SNT125-W35B89F6AA83C8DD22E7946BA770@phx.gbl> <20100913075025.GA14882@console-pimps.org> <20100913085137.GE23741@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:42787 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753951Ab0IMLEp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 07:04:45 -0400
Content-Disposition: inline
In-Reply-To: <20100913085137.GE23741@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Marc Titinger <mtittinge@hotmail.com>, robert.richter@amd.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, linux-sh@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com, will.deacon@arm.com, acme@redhat.com, lethal@linux-sh.org, linux-arm-kernel@lists.infradead.org

On Mon, Sep 13, 2010 at 10:51:37AM +0200, Ingo Molnar wrote:
> 
> * Matt Fleming <matt@console-pimps.org> wrote:
> 
> > On Mon, Sep 13, 2010 at 09:13:32AM +0200, Marc Titinger wrote:
> > > 
> > > Hi, 
> > > 
> > > I'm just being curious : do these patches change the way those chips 
> > > should be supported, that do not have a PMU-like IP, but implement 
> > > PC-sampling thanks to a general purpose timer (not the system timer) 
> > > ?
> > 
> > CPUs that do not have a PMU are not required to use the perf-events 
> > oprofile backend, it is entirely optional. The pc-sampling timer in 
> > oprofile is not affected by this series.
> 
> It should still work fine though: a generalized oprofile backend should 
> simply use hrtimer based events. That also has a chance to be higher 
> quality than the system time fallback, on PMU-less (but high-res-timer 
> capable) systems.

Yeah, that's a good point. It would make a nice addition to this patch
series. I may get chance to take a look at it at some point.
