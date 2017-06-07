From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Wed, 7 Jun 2017 13:50:26 +1000
Message-ID: <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
        <20170530012659.16791-4-npiggin@gmail.com>
        <20170602201500.urllmug33bjtuzen@redhat.com>
        <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
        <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32993 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbdFGDul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 23:50:41 -0400
In-Reply-To: <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 6 Jun 2017 12:49:58 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Sat, Jun 03, 2017 at 04:10:05PM +1000, Nicholas Piggin wrote:

> > > >  config HARDLOCKUP_DETECTOR
> > > > -	def_bool y
> > > > -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> > > > -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> > > > +	bool "Detect Hard Lockups"
> > > > +	depends on LOCKUP_DETECTOR
> > > > +	depends on !HAVE_NMI_WATCHDOG && (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)
> > > > +	select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG    
> > > 
> > > Here is my confusion with HAVE_NMI_WATCHDOG
> > > 
> > > It seems like you can only select HARDLOCKUP_DETECTOR if !HAVE_NMI_DETECTOR
> > > which would break sparc, I think.
> > > 
> > > And then it always selects HARDLOCKUP_DETECTOR_PERF because of the
> > > dependency on !HAVE_NMI_WATCHDOG???  
> > 
> > I don't think so -- sparc today does not select HARDLOCKUP_DETECTOR.  
> 
> Well yes, but your patch changes the definition of HARDLOCKUP_DETECTOR to
> HARDLOCKUP_DETECTOR_PERF and then recreates HARDLOCKUP_DETECTOR.
> 
> For example look at kernel/watchdog.c::watchdog_enabled (line 38)
> 
> sparc has HAVE_NMI_WATCHDOG set, but that will disable HARDLOCKUP_DETECTOR
> which I believes means sparc's nmi_watchdog is disabled on boot and has to
> be manually enabled?

Ahh okay because sparc is using watchdog_nmi_enable/disable from the
softlockup watchdog, which checks watchdog_enabled.

> 
> 
> I _think_ having
> 
> depends on LOCKUP_DETECTOR
> depends on HAVE_NMI_WATCHDOG || HAVE_PERF_EVENTS_NMI
> select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG
> 
> will work because your new definition of HARDLOCKUP_DETECTOR is a
> combination of HAVE_NMI_WATCHDOG && HARDLOCKUP_DETECTOR_PERF ??
> 
> Did I get that right?

Well in some ways, except that most of the NMI watchdogs do not seem to
heed the HARDLOCKUP_DETECTOR configuration sysctls and commands.

NMI_WATCHDOG by itself was supposed to be for an arch that wnats to do
completely it own thing.

sparc is somewhere in the middle. It uses some of the HLD stuff, but
not all. That makes it a bit tricky.


> I almost wonder if arches should set either HAVE_NMI_WATCHDOG or
> HAVE_PERF_NMI_WATCHDOG and then use those two to determine
> HARDLOCKUP_DETECTOR.  Would that make the config options slightly less
> confusing?

This would probably be the right direction to go in, but it will take
slightly more I think. We first need to remove HAVE_NMI_WATCHDOG from
meaning that an arch has its own watchdog and does not want any HLD
stuff. I think with arch_touch_nmi_watchdog(), we can probably get there.

While transitioning, we could add a new option instead,

HAVE_ARCH_HARDLOCKUP_DETECTOR

I think HAVE_PERF_EVENTS_NMI is sufficient to imply it will use the PERF
HLD. Possibly you could just change the name to be a bit more regular,
HAVE_PERF_NMI_HARDLOCKUP_DETECTOR

Thanks,
Nick
