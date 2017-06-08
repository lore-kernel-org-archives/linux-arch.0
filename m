From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Thu, 8 Jun 2017 12:05:02 -0400
Message-ID: <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170530012659.16791-4-npiggin@gmail.com>
 <20170602201500.urllmug33bjtuzen@redhat.com>
 <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
 <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
 <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdFHQFE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jun 2017 12:05:04 -0400
Content-Disposition: inline
In-Reply-To: <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Jun 07, 2017 at 01:50:26PM +1000, Nicholas Piggin wrote:
> > 
> > I _think_ having
> > 
> > depends on LOCKUP_DETECTOR
> > depends on HAVE_NMI_WATCHDOG || HAVE_PERF_EVENTS_NMI
> > select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG
> > 
> > will work because your new definition of HARDLOCKUP_DETECTOR is a
> > combination of HAVE_NMI_WATCHDOG && HARDLOCKUP_DETECTOR_PERF ??
> > 
> > Did I get that right?
> 
> Well in some ways, except that most of the NMI watchdogs do not seem to
> heed the HARDLOCKUP_DETECTOR configuration sysctls and commands.
> 
> NMI_WATCHDOG by itself was supposed to be for an arch that wnats to do
> completely it own thing.
> 
> sparc is somewhere in the middle. It uses some of the HLD stuff, but
> not all. That makes it a bit tricky.

Hmm, I can see sparc relying on SOFTLOCKUP, but the HARDLOCKUP code with
your patches seems really small.  The only sysctl is nmi_watchdog and
hardlockup_panic.  The former is needed but the later is only implemented in
the HARDLOCKUP_DETECTOR_PERF case.

So by having HAVE_NMI_WATCHDOG, you sorta need a sysctl knob which the
HARDLOCKUP_DETECTOR seems to provide on top of the default knobs.

With sparc being special and needing SOFTLOCKUP to call its nmi
enable/disable hooks.


Is there a particular chunk of code you had in mind that did not make sense
with HARDLOCKUP_DETECTOR enabled?

> 
> 
> > I almost wonder if arches should set either HAVE_NMI_WATCHDOG or
> > HAVE_PERF_NMI_WATCHDOG and then use those two to determine
> > HARDLOCKUP_DETECTOR.  Would that make the config options slightly less
> > confusing?
> 
> This would probably be the right direction to go in, but it will take
> slightly more I think. We first need to remove HAVE_NMI_WATCHDOG from
> meaning that an arch has its own watchdog and does not want any HLD
> stuff. I think with arch_touch_nmi_watchdog(), we can probably get there.
> 
> While transitioning, we could add a new option instead,
> 
> HAVE_ARCH_HARDLOCKUP_DETECTOR
> 
> I think HAVE_PERF_EVENTS_NMI is sufficient to imply it will use the PERF
> HLD. Possibly you could just change the name to be a bit more regular,
> HAVE_PERF_NMI_HARDLOCKUP_DETECTOR

Actually, I don't think I can just rename it as it has a specific use to let
OPROFILE know the perf events are being NMI triggered as opposed to IRQ
triggered.

Though I like the direction you are going.  Then arches either have one or
the other.  Or in the ppc case it is dependent on what ppc platform is being
used.

Then the HARDLOCKUP_DETECTOR needs one or the other to work correctly with
the arch/<arch>/Kconfig explicitly stating which one to use?

Cheers,
Don



> 
> Thanks,
> Nick
