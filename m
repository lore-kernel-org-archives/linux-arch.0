Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 13 Apr 2005 11:59:28 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: i386-cpu-hotplug-updated-for-mm.patch
Message-Id: <20050413115928.694025b7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504131211130.23582@montezuma.fsmlabs.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03456F3C@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.61.0504131211130.23582@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org, ashok.raj@intel.com
List-ID: <linux-arch.vger.kernel.org>

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Wed, 13 Apr 2005, Luck, Tony wrote:
> 
> > But my local cpu hotplug expert (Ashok) has this to say about
> > the irq redirection part of the i386 code:
> > 
> > On i386, the way they do in fixup_irqs() to 
> > 
> >   Redirect interrupts
> >   Local_irq_enable() // hack to permit irq processing
> >   Mdelay();; hack to wait
> >   Local_irq_disable()
> > 
> > Is totally not the right solution, there are easy cases that a race
> > condition can be triggered, and chipsets can also lockup if you do
> > programming the rte's without disabling them first.
> > 
> > This really ought to be fixed before putting it into production
> > kernels.
> > 
> > They also need to change irq to deferred mode when we do proc/irq
> > write handling like what we do for ia64.
> 
> I'd prefer doing that change as a followup, but i'm fine with doing it 
> before, i'm  just trying to avoid patches dependent on this backing up.

That sounds reasonable at this stage, if the racy code is only used during
"hotplugging".  But I don't think that's the case, is it?
