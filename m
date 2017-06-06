From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Tue, 6 Jun 2017 12:49:58 -0400
Message-ID: <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
 <20170602201500.urllmug33bjtuzen@redhat.com>
 <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdFFQuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jun 2017 12:50:00 -0400
Content-Disposition: inline
In-Reply-To: <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Jun 03, 2017 at 04:10:05PM +1000, Nicholas Piggin wrote:
> > My last concern is wrapping my head around the config options.
> > 
> > HAVE_NMI_WATCHDOG seems to have a dual meaning, I think.
> 
> Yeah it's not the clearest. I think we need another pass over config
> options to start straightening them out.
> 
> It means the arch has a hardlockup detector, so it has the
> arch_touch_nmi_watchdog() and you can't also select the perf HLD.

Ok, agreed.

> 
> > In the sparc case, it uses the HARDLOCKUP_DETECTOR framework (hence the
> > original split out of watchdog_hld.c).  Actually more like the
> > SOFTLOCKUP_DETECTOR framework for which HARDLOCKUP_DETECTOR is a part of.
> 
> Well yes it uses some of the start/stop framework for the SLD, but
> doesn't use much beyond that of the lockup detector stuff (most of
> the boot options and sysctl parameters etc it does not use). So sparc
> is a little odd.
> 
> I would hope to convert it over to more like powerpc patch and make
> it a first class HLD, but it seems not all options are 100% compatible
> so it would need some careful testing.
> 

Ok.  More comments on sparc below..

> > 
> > In your ppc64 case, it means do _not_ use the HARDLOCKUP_DETECTOR or
> > SOFTLOCKUP_DETECTOR framework.  Instead just the bare bones LOCKUP_DETECTOR.
> 
> It does use the HLD framework. The subsequent patch for powerpc adds
> a PPC64 case in the dependencies.

Ah, ok.

> 
> > 
> > 
> > If so, the following is a little confusing to me..
> > 
> > 
> > <snip>
> > 
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index e4587ebe52c7..a3afe3e10278 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -801,10 +801,27 @@ config LOCKUP_DETECTOR
> > >  	  The frequency of hrtimer and NMI events and the soft and hard lockup
> > >  	  thresholds can be controlled through the sysctl watchdog_thresh.
> > >  
> > > +config SOFTLOCKUP_DETECTOR
> > > +	bool "Detect Soft Lockups"
> > > +	depends on LOCKUP_DETECTOR
> > > +
> > > +config HARDLOCKUP_DETECTOR_PERF
> > > +	bool
> > > +	select SOFTLOCKUP_DETECTOR  
> > 
> > Perhaps add a 'depends on (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)'
> 
> Kconfig is pretty clunky, I was struggling to make it do the right
> thing... I could try.
> 
> > 
> > > +
> > > +#
> > > +# arch/ can define HAVE_NMI_WATCHDOG to provide their own NMI watchdog
> > > +# rather than the perf based detector.
> > > +#
> > > +# The arch may do its own thing, or select HARDLOCKUP_DETECTOR, in which
> > > +# case it should conform to HARDLOCKUP_DETECTOR interfaces and settings
> > > +# (e.g., sysctl and cmdline).
> > > +#
> > >  config HARDLOCKUP_DETECTOR
> > > -	def_bool y
> > > -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> > > -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> > > +	bool "Detect Hard Lockups"
> > > +	depends on LOCKUP_DETECTOR
> > > +	depends on !HAVE_NMI_WATCHDOG && (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)
> > > +	select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG  
> > 
> > Here is my confusion with HAVE_NMI_WATCHDOG
> > 
> > It seems like you can only select HARDLOCKUP_DETECTOR if !HAVE_NMI_DETECTOR
> > which would break sparc, I think.
> > 
> > And then it always selects HARDLOCKUP_DETECTOR_PERF because of the
> > dependency on !HAVE_NMI_WATCHDOG???
> 
> I don't think so -- sparc today does not select HARDLOCKUP_DETECTOR.

Well yes, but your patch changes the definition of HARDLOCKUP_DETECTOR to
HARDLOCKUP_DETECTOR_PERF and then recreates HARDLOCKUP_DETECTOR.

For example look at kernel/watchdog.c::watchdog_enabled (line 38)

sparc has HAVE_NMI_WATCHDOG set, but that will disable HARDLOCKUP_DETECTOR
which I believes means sparc's nmi_watchdog is disabled on boot and has to
be manually enabled?


I _think_ having

depends on LOCKUP_DETECTOR
depends on HAVE_NMI_WATCHDOG || HAVE_PERF_EVENTS_NMI
select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG

will work because your new definition of HARDLOCKUP_DETECTOR is a
combination of HAVE_NMI_WATCHDOG && HARDLOCKUP_DETECTOR_PERF ??

Did I get that right?


I almost wonder if arches should set either HAVE_NMI_WATCHDOG or
HAVE_PERF_NMI_WATCHDOG and then use those two to determine
HARDLOCKUP_DETECTOR.  Would that make the config options slightly less
confusing?

Thoughts?

Cheers,
Don

> 
> After this patch, it always selects the _PERF detector because that's
> the only one available. See the powerpc patch which adds the PPC64
> exception here.
> 
> Yes it's a bit clunky. I think we can subsequently remove HAVE_NMI_DETECTOR
> and replace it with something a bit saner and clean up some of these
> convoluted cases.
> 
> Thanks,
> Nick
