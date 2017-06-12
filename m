From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/4] watchdog: Split up config options
Date: Mon, 12 Jun 2017 18:07:39 +1000
Message-ID: <20170612180739.1aa4b123@roar.ozlabs.ibm.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
        <20170530012659.16791-4-npiggin@gmail.com>
        <20170602201500.urllmug33bjtuzen@redhat.com>
        <20170603161005.279fe0ef@roar.ozlabs.ibm.com>
        <20170606164958.lkwy7t7xzdpxg4mp@redhat.com>
        <20170607135026.1a6129a8@roar.ozlabs.ibm.com>
        <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32942 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdFLIHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2017 04:07:51 -0400
In-Reply-To: <20170608160502.uzp7vmr7s4fj6hjm@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Don Zickus <dzickus@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 8 Jun 2017 12:05:02 -0400
Don Zickus <dzickus@redhat.com> wrote:

> On Wed, Jun 07, 2017 at 01:50:26PM +1000, Nicholas Piggin wrote:
> > > 
> > > I _think_ having
> > > 
> > > depends on LOCKUP_DETECTOR
> > > depends on HAVE_NMI_WATCHDOG || HAVE_PERF_EVENTS_NMI
> > > select HARDLOCKUP_DETECTOR_PERF if !HAVE_NMI_WATCHDOG
> > > 
> > > will work because your new definition of HARDLOCKUP_DETECTOR is a
> > > combination of HAVE_NMI_WATCHDOG && HARDLOCKUP_DETECTOR_PERF ??
> > > 
> > > Did I get that right?  
> > 
> > Well in some ways, except that most of the NMI watchdogs do not seem to
> > heed the HARDLOCKUP_DETECTOR configuration sysctls and commands.
> > 
> > NMI_WATCHDOG by itself was supposed to be for an arch that wnats to do
> > completely it own thing.
> > 
> > sparc is somewhere in the middle. It uses some of the HLD stuff, but
> > not all. That makes it a bit tricky.  
> 
> Hmm, I can see sparc relying on SOFTLOCKUP, but the HARDLOCKUP code with
> your patches seems really small.  The only sysctl is nmi_watchdog and
> hardlockup_panic.  The former is needed but the later is only implemented in
> the HARDLOCKUP_DETECTOR_PERF case.
> 
> So by having HAVE_NMI_WATCHDOG, you sorta need a sysctl knob which the
> HARDLOCKUP_DETECTOR seems to provide on top of the default knobs.

I would say there's a few others like the cpumask, threshold, panic,
backtrace, etc.

> With sparc being special and needing SOFTLOCKUP to call its nmi
> enable/disable hooks.

Yes, although we could just remove that dependency (it's minimal code
to start them up with hotplug).

That said, I would hope to actually go the other way in general and move
architectures to using the generic parameters as much as possible.

> Is there a particular chunk of code you had in mind that did not make sense
> with HARDLOCKUP_DETECTOR enabled?

Perhaps the couple of other archs that have their own NMI watchdogs.

> 
> > 
> >   
> > > I almost wonder if arches should set either HAVE_NMI_WATCHDOG or
> > > HAVE_PERF_NMI_WATCHDOG and then use those two to determine
> > > HARDLOCKUP_DETECTOR.  Would that make the config options slightly less
> > > confusing?  
> > 
> > This would probably be the right direction to go in, but it will take
> > slightly more I think. We first need to remove HAVE_NMI_WATCHDOG from
> > meaning that an arch has its own watchdog and does not want any HLD
> > stuff. I think with arch_touch_nmi_watchdog(), we can probably get there.
> > 
> > While transitioning, we could add a new option instead,
> > 
> > HAVE_ARCH_HARDLOCKUP_DETECTOR
> > 
> > I think HAVE_PERF_EVENTS_NMI is sufficient to imply it will use the PERF
> > HLD. Possibly you could just change the name to be a bit more regular,
> > HAVE_PERF_NMI_HARDLOCKUP_DETECTOR  
> 
> Actually, I don't think I can just rename it as it has a specific use to let
> OPROFILE know the perf events are being NMI triggered as opposed to IRQ
> triggered.
> 
> Though I like the direction you are going.  Then arches either have one or
> the other.  Or in the ppc case it is dependent on what ppc platform is being
> used.

Okay, glad we're on the same page conceptually :)

> 
> Then the HARDLOCKUP_DETECTOR needs one or the other to work correctly with
> the arch/<arch>/Kconfig explicitly stating which one to use?

Yeah I guess the arch would advertise it has the PERF_HLD or ARCH_HLD if
it provides its own. HARDLOCKUP_DETECTOR option would then depend on
one of the two being defined.

I could try redoing the series with those changes to Kconfig and see how
it looks?

Thanks,
Nick
