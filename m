From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Sat, 3 Jun 2017 16:10:05 +1000
Message-ID: <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
        <20170530012659.16791-4-npiggin@gmail.com>
        <20170602201500.urllmug33bjtuzen@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34075 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdFCGKV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Jun 2017 02:10:21 -0400
In-Reply-To: <20170602201500.urllmug33bjtuzen@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 2 Jun 2017 16:15:00 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Tue, May 30, 2017 at 11:26:58AM +1000, Nicholas Piggin wrote:
> > Split SOFTLOCKUP_DETECTOR from LOCKUP_DETECTOR, and split
> > HARDLOCKUP_DETECTOR_PERF from HARDLOCKUP_DETECTOR.
> > 
> > LOCKUP_DETECTOR provides the boot, sysctl, and programming interfaces
> > for lockup detectors. An architecture that defines HAVE_NMI_WATCHDOG
> > need not use this this if it has a very basic watchdog or uses its own
> > options and interfaces (e.g., sparc). touch_nmi_watchdog() will
> > continue to call their arch_touch_nmi_watchdog().
> > 
> > HARDLOCKUP_DETECTOR_PERF is the perf-based lockup detector.
> > 
> > HARDLOCKUP_DETECTOR is the framework for arch NMI_WATCHDOG hard lockup
> > detectors that conform to the LOCKUP_DETECTOR interfaces.  
> 
> Hi Nick,
> 
> Sorry for the late response.  I did some sanity testing on your patches on
> x86_64 and it seems to work fine.  I don't think I have any real issues with
> the patches (without making time-consuming cleanup changes).
> 
> My last concern is wrapping my head around the config options.
> 
> HAVE_NMI_WATCHDOG seems to have a dual meaning, I think.

Yeah it's not the clearest. I think we need another pass over config
options to start straightening them out.

It means the arch has a hardlockup detector, so it has the
arch_touch_nmi_watchdog() and you can't also select the perf HLD.

> In the sparc case, it uses the HARDLOCKUP_DETECTOR framework (hence the
> original split out of watchdog_hld.c).  Actually more like the
> SOFTLOCKUP_DETECTOR framework for which HARDLOCKUP_DETECTOR is a part of.

Well yes it uses some of the start/stop framework for the SLD, but
doesn't use much beyond that of the lockup detector stuff (most of
the boot options and sysctl parameters etc it does not use). So sparc
is a little odd.

I would hope to convert it over to more like powerpc patch and make
it a first class HLD, but it seems not all options are 100% compatible
so it would need some careful testing.

> 
> In your ppc64 case, it means do _not_ use the HARDLOCKUP_DETECTOR or
> SOFTLOCKUP_DETECTOR framework.  Instead just the bare bones LOCKUP_DETECTOR.

It does use the HLD framework. The subsequent patch for powerpc adds
a PPC64 case in the dependencies.

> 
> 
> If so, the following is a little confusing to me..
> 
> 
> <snip>
> 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e4587ebe52c7..a3afe3e10278 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -801,10 +801,27 @@ config LOCKUP_DETECTOR
> >  	  The frequency of hrtimer and NMI events and the soft and hard lockup
> >  	  thresholds can be controlled through the sysctl watchdog_thresh.
> >  
> > +config SOFTLOCKUP_DETECTOR
> > +	bool "Detect Soft Lockups"
> > +	depends on LOCKUP_DETECTOR
> > +
> > +config HARDLOCKUP_DETECTOR_PERF
> > +	bool
> > +	select SOFTLOCKUP_DETECTOR  
> 
> Perhaps add a 'depends on (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)'

Kconfig is pretty clunky, I was struggling to make it do the right
thing... I could try.

> 
> > +
> > +#
> > +# arch/ can define HAVE_NMI_WATCHDOG to provide their own NMI watchdog
> > +# rather than the perf based detector.
> > +#
> > +# The arch may do its own thing, or select HARDLOCKUP_DETECTOR, in which
> > +# case it should conform to HARDLOCKUP_DETECTOR interfaces and settings
> > +# (e.g., sysctl and cmdline).
> > +#
> >  config HARDLOCKUP_DETECTOR
> > -	def_bool y
> > -	depends on LOCKUP_DETECTOR && !HAVE_NMI_WATCHDOG
> > -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> > +	bool "Detect Hard Lockups"
> > +	depends on LOCKUP_DETECTOR
> > +	depends on !HAVE_NMI_WATCHDOG && (PERF_EVENTS && HAVE_PERF_EVENTS_NMI)
> > +	select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG  
> 
> Here is my confusion with HAVE_NMI_WATCHDOG
> 
> It seems like you can only select HARDLOCKUP_DETECTOR if !HAVE_NMI_DETECTOR
> which would break sparc, I think.
> 
> And then it always selects HARDLOCKUP_DETECTOR_PERF because of the
> dependency on !HAVE_NMI_WATCHDOG???

I don't think so -- sparc today does not select HARDLOCKUP_DETECTOR.

After this patch, it always selects the _PERF detector because that's
the only one available. See the powerpc patch which adds the PPC64
exception here.

Yes it's a bit clunky. I think we can subsequently remove HAVE_NMI_DETECTOR
and replace it with something a bit saner and clean up some of these
convoluted cases.

Thanks,
Nick
